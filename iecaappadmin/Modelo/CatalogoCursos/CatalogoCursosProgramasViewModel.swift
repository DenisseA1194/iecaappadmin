//  ZonasViewModel.swift

import Foundation
import Alamofire

class CatalogoCursosProgramasViewModel: ObservableObject {
    
    @Published var catalogoCursosProgramas: [CatalogoCursosProgramas] = []
    
    func editarCatalogoCursosProgramas(catalogoCursosProgramas: CatalogoCursosProgramas) {
        CatalogoCursosProgramasAPIService.shared.editarCatalogoCursosProgramas(catalogoCursosProgramas: catalogoCursosProgramas) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    if let index = self?.catalogoCursosProgramas.firstIndex(where: { $0.Id == catalogoCursosProgramas.Id }) {
                        self?.catalogoCursosProgramas[index] = catalogoCursosProgramas
                    }
                }
            case .failure(let error):
                print("Error al editar la zona:", error)
            }
        }
    }
    //
    //    func eliminarApellido(apellido: Apellido) {
    //        guard let index = apellido.firstIndex(where: { $0.Id == apellido.Id }) else {
    //            return
    //        }
    //
    //        ApellidoAPIService.shared.eliminarApellidos(idApellido: apellido.Id) { [weak self] result in
    //            switch result {
    //            case .success:
    //                DispatchQueue.main.async {
    //                    self?.apellido.remove(at: index)
    //                }
    //            case .failure(let error):
    //                print("Error al eliminar la zona:", error)
    //            }
    //        }
    //    }
    
    func fetchCatalogoCursosProgramas() {
        CatalogoCursosProgramasAPIService.shared.fetchCatalogoCursosProgramas() { [weak self] result in
            switch result {
            case .success(let departamento):
                DispatchQueue.main.async {
                    self?.catalogoCursosProgramas = departamento
                }
            case .failure(let error):
                print("Error al obtener datos de la API:", error)
            }
        }
    }
    
    func agregarNuevoCatalogoCursosProgramas(catalogoCursosProgramas: CatalogoCursosProgramas) {
        CatalogoCursosProgramasAPIService.shared.agregarCatalogoCursosProgramas(nuevoCatalogoCursosProgramas: catalogoCursosProgramas) { [weak self] result in
            switch result {
            case .success(let catalogoCursosProgramas):
                DispatchQueue.main.async {
                    self?.catalogoCursosProgramas.append(catalogoCursosProgramas)
                    self?.actualizarListaCatalogoCursosProgramas()
                }
            case .failure(let error):
                self?.actualizarListaCatalogoCursosProgramas()
                print("Error al agregar la Zona:", error)
            }
        }
    }
    
    
    func actualizarListaCatalogoCursosProgramas(){
        fetchCatalogoCursosProgramas()
    }
    
    
    
}

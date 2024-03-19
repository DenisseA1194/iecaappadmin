//  ZonasViewModel.swift

import Foundation
import Alamofire

class DepartamentoViewModel: ObservableObject {
    
    @Published var departamento: [CatalogoClientesDepartamentos] = []

    func editarDepartamento(departamento: CatalogoClientesDepartamentos) {
        CatalogoClientesDepartamentosAPIService.shared.editarCatalogoClientesDepartamentos(catalogoClientesDepartamentos: departamento) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    if let index = self?.departamento.firstIndex(where: { $0.Id == departamento.Id }) {
                        self?.departamento[index] = departamento
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

    func fetchDepartamentos() {
        CatalogoClientesDepartamentosAPIService.shared.fetchCatalogoClientesDepartamentos { [weak self] result in
            switch result {
            case .success(let departamento):
                DispatchQueue.main.async {
                    self?.departamento = departamento
                }
            case .failure(let error):
                print("Error al obtener datos de la API:", error)
            }
        }
    }
    
    func agregarNuevaDepartamento(nuevaDepartamento: CatalogoClientesDepartamentos) {
        CatalogoClientesDepartamentosAPIService.shared.agregarCatalogoClientesDepartamentos(nuevoCatalogoClientesDepartamentos: nuevaDepartamento) { [weak self] result in
               switch result {
               case .success(let departamento):
                   DispatchQueue.main.async {
                       self?.departamento.append(departamento)
                       self?.actualizarListaDepartamento()
                   }
               case .failure(let error):
                   self?.actualizarListaDepartamento()
                   print("Error al agregar la Zona:", error)
               }
           }
       }

    
    func actualizarListaDepartamento() {
        fetchDepartamentos()
    }
}




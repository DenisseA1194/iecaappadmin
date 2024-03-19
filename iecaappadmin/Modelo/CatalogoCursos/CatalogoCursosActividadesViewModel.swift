//
//  CatalogoCursosCampoDeFormacionViewModel.swift
//  iecaappadmin
//
//  Created by Omar on 12/02/24.
//

import Foundation

class CatalogoCursosActividadesViewModel: ObservableObject {
    @Published var catalogoCursosActividades: [CatalogoCursosActividades] = []
    private let apiService = CatalogoCursosActividadesAPIService.shared
    
    func editarCatalogoCursosActividades(catalogoCursosActividades: CatalogoCursosActividades) {
        apiService.editarCatalogoCursosActividades(catalogoCursosActividades: catalogoCursosActividades) { result in
            switch result {
            case .success:
                // Handle success
                print("Catálogo de cursos de campo de formación editado correctamente.")
                self.fetchCatalogoCursosCampoDeFormacion()
            case .failure(let error):
                // Handle failure
                print("Error al editar el catálogo de cursos de campo de formación: \(error.localizedDescription)")
            }
        }
    }
    
//    func eliminarCatalogoCursosActivades(idCatalogoCursosCampoDeFormacion: String) {
//        apiService.eliminarCatalogoCursosCampoDeFormacion(idCatalogoCursosCampoDeFormacion: idCatalogoCursosCampoDeFormacion) { result in
//            switch result {
//            case .success:
//                // Handle success
//                print("Catálogo de cursos de campo de formación eliminado correctamente.")
//            case .failure(let error):
//                // Handle failure
//                print("Error al eliminar el catálogo de cursos de campo de formación: \(error.localizedDescription)")
//            }
//        }
//    }
    
    func fetchCatalogoCursosCampoDeFormacion() {
        apiService.fetchCatalogoCursosActividades { result in
            switch result {
            case .success(let catalogoCursososActividades):
                // Update the published property with the fetched data
                DispatchQueue.main.async {
                    self.catalogoCursosActividades = catalogoCursososActividades
                }
            case .failure(let error):
                // Handle failure
               
                print("Error al obtener el catálogo de cursos actividades: \(error.localizedDescription)")
            }
        }
    }
    
    func agregarCatalogoCursosActividades(nuevoCatalogoCursosActividades: CatalogoCursosActividades) {
        apiService.agregarCatalogoCursosActividades(nuevoCatalogoCursosActividades: nuevoCatalogoCursosActividades) { result in
            switch result {
            case .success(let catalogoCursosActividades):
                // Handle success
                print("catalogoCursosActividades agregado correctamente: \(catalogoCursosActividades)")
                self.fetchCatalogoCursosCampoDeFormacion()
            case .failure(let error):
                // Handle failure
                self.fetchCatalogoCursosCampoDeFormacion()
                print("Error al agregar el catálogo de cursos de campo de formación: \(error.localizedDescription)")
            }
        }
    }
}

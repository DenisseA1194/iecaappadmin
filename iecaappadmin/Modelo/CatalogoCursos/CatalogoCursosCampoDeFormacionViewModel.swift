//
//  CatalogoCursosCampoDeFormacionViewModel.swift
//  iecaappadmin
//
//  Created by Omar on 12/02/24.
//

import Foundation

class CatalogoCursosCampoDeFormacionViewModel: ObservableObject {
    @Published var catalogoCursosCampoDeFormacion: [CatalogoCursosCampoDeFormacion] = []
    private let apiService = CatalogoCursosCampoDeFormacionAPIService.shared
    
    func editarCatalogoCursosCampoDeFormacion(catalogoCursosCampoDeFormacion: CatalogoCursosCampoDeFormacion) {
        apiService.editarCatalogoCursosCampoDeFormacion(catalogoCursosCampoDeFormacion: catalogoCursosCampoDeFormacion) { result in
            switch result {
            case .success:
                // Handle success
                print("Catálogo de cursos de campo de formación editado correctamente.")
            case .failure(let error):
                // Handle failure
                print("Error al editar el catálogo de cursos de campo de formación: \(error.localizedDescription)")
            }
        }
    }
    
    func eliminarCatalogoCursosCampoDeFormacion(idCatalogoCursosCampoDeFormacion: String) {
        apiService.eliminarCatalogoCursosCampoDeFormacion(idCatalogoCursosCampoDeFormacion: idCatalogoCursosCampoDeFormacion) { result in
            switch result {
            case .success:
                // Handle success
                print("Catálogo de cursos de campo de formación eliminado correctamente.")
            case .failure(let error):
                // Handle failure
                print("Error al eliminar el catálogo de cursos de campo de formación: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchCatalogoCursosCampoDeFormacion() {
        apiService.fetchCatalogoCursosCampoDeFormacion { result in
            switch result {
            case .success(let catalogoCursosCampoDeFormacion):
                // Update the published property with the fetched data
                DispatchQueue.main.async {
                    self.catalogoCursosCampoDeFormacion = catalogoCursosCampoDeFormacion
                }
            case .failure(let error):
                // Handle failure
                print("Error al obtener el catálogo de cursos de campo de formación: \(error.localizedDescription)")
            }
        }
    }
    
    func agregarCatalogoCursosCampoDeFormacion(nuevoCatalogoCursosCampoDeFormacion: CatalogoCursosCampoDeFormacion) {
        apiService.agregarCatalogoCursosCampoDeFormacion(nuevoCatalogoCursosCampoDeFormacion: nuevoCatalogoCursosCampoDeFormacion) { result in
            switch result {
            case .success(let catalogoCursosCampoDeFormacion):
                // Handle success
                print("Catálogo de cursos de campo de formación agregado correctamente: \(catalogoCursosCampoDeFormacion)")
            case .failure(let error):
                // Handle failure
                print("Error al agregar el catálogo de cursos de campo de formación: \(error.localizedDescription)")
            }
        }
    }
}

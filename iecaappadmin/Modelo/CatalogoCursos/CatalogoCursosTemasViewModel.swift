
//
//  CatalogoCursosPlataformasViewModel.swift
//  iecaappadmin
//
//  Created by Omar on 13/02/24.
//

import Foundation

class CatalogoCursosTemasViewModel: ObservableObject {
    @Published var catalogoCursosTemas: [CatalogoCursosTemas] = []
    private let apiService = CatalogoCursosTemasAPIService.shared
    
    func editarCatalogoCursosTemas(catalogoCursosTemas: CatalogoCursosTemas) {
        apiService.editarCatalogoCursosTemas(catalogoCursosTemas: catalogoCursosTemas) { result in
            switch result {
            case .success:
                // Handle success
                print("Catálogo de cursos de temas editado correctamente.")
            case .failure(let error):
                // Handle failure
                print("Error al editar el catálogo de cursos de temas: \(error.localizedDescription)")
            }
        }
    }
    
    func eliminarCatalogoCursosTemas(idCatalogoCursosTemas: String) {
        apiService.eliminarCatalogoCursosTemas(idCatalogoCursosTemas: idCatalogoCursosTemas) { result in
            switch result {
            case .success:
                // Handle success
                print("Catálogo de cursos de temas eliminado correctamente.")
            case .failure(let error):
                // Handle failure
                print("Error al eliminar el catálogo de cursos de temas: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchCatalogoCursosTemas() {
        apiService.fetchCatalogoCursosTemas { [weak self] result in
            switch result {
            case .success(let catalogoCursosTemas):
                // Update the published property with the fetched data
                DispatchQueue.main.async {
                    self?.catalogoCursosTemas = catalogoCursosTemas
                }
            case .failure(let error):
                // Handle failure
                print("Error al obtener el catálogo de cursos de temas: \(error.localizedDescription)")
            }
        }
    }
    
    func agregarCatalogoTemas(nuevoCatalogoTemas: CatalogoCursosTemas) {
        CatalogoCursosTemasAPIService.shared.agregarCatalogoCursosTemas(nuevoCatalogoCursosTemas: nuevoCatalogoTemas){ [weak self] result in
            switch result {
            case .success(let catalogoCursosTemas):
                DispatchQueue.main.async {
                    self?.catalogoCursosTemas.append(catalogoCursosTemas)
                    self?.actualizarListaTemas()
                }
            case .failure(let error):
                self?.actualizarListaTemas()
                print("Error al agregar curso:", error)
            }
        }
    }
    
    func actualizarListaTemas() {
        fetchCatalogoCursosTemas()
    }
}

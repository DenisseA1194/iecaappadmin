//
//  CatalogoCursosPlataformasViewModel.swift
//  iecaappadmin
//
//  Created by Omar on 13/02/24.
//

import Foundation

class CatalogoCursosPlataformasViewModel: ObservableObject {
    @Published var catalogoCursosPlataformas: [CatalogoCursosPlataformas] = []
    private let apiService = CatalogoCursosPlataformasAPIService.shared
    
    func editarCatalogoCursosPlataformas(catalogoCursosPlataformas: CatalogoCursosPlataformas) {
        apiService.editarCatalogoCursosPlataformas(catalogoCursosPlataformas: catalogoCursosPlataformas) { result in
            switch result {
            case .success:
                // Handle success
                print("Catálogo de cursos de plataformas editado correctamente.")
            case .failure(let error):
                // Handle failure
                print("Error al editar el catálogo de cursos de plataformas: \(error.localizedDescription)")
            }
        }
    }
    
    func eliminarCatalogoCursosPlataformas(idCatalogoCursosPlataformas: String) {
        apiService.eliminarCatalogoCursosPlataformas(idCatalogoCursosPlataformas: idCatalogoCursosPlataformas) { result in
            switch result {
            case .success:
                // Handle success
                print("Catálogo de cursos de plataformas eliminado correctamente.")
            case .failure(let error):
                // Handle failure
                print("Error al eliminar el catálogo de cursos de plataformas: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchCatalogoCursosPlataformas() {
        apiService.fetchCatalogoCursosPlataformas { [weak self] result in
            switch result {
            case .success(let catalogoCursosPlataformas):
                // Update the published property with the fetched data
                DispatchQueue.main.async {
                    self?.catalogoCursosPlataformas = catalogoCursosPlataformas
                }
            case .failure(let error):
                // Handle failure
                print("Error al obtener el catálogo de cursos de plataformas: \(error.localizedDescription)")
            }
        }
    }
    
    func agregarCatalogoCursosPlataformas(nuevoCatalogoCursosPlataformas: CatalogoCursosPlataformas) {
        
        
        CatalogoCursosPlataformasAPIService.shared.agregarCatalogoCursosPlataformas(nuevoCatalogoCursosPlataformas: nuevoCatalogoCursosPlataformas){ [weak self] result in
            switch result {
            case .success(let catalogoCursosPlataforma):
                DispatchQueue.main.async {
                    self?.catalogoCursosPlataformas.append(catalogoCursosPlataforma)
                    self?.actualizarListaPlataformas()
                }
            case .failure(let error):
                self?.actualizarListaPlataformas()
                print("Error al agregar curso:", error)
            }
        }
    }
    
    func actualizarListaPlataformas() {
        fetchCatalogoCursosPlataformas()
    }
}

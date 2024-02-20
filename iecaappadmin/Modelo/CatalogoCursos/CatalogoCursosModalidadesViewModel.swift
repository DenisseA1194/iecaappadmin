//
//  CatalogoCursosModalidadesViewModel.swift
//  iecaappadmin
//
//  Created by Omar on 12/02/24.
//

import Foundation
import Alamofire

class CatalogoCursosModalidadesViewModel: ObservableObject {
    
    private let service = CatalogoCursosModalidadesAPIService.shared
    
    @Published var catalogoCursosModalidades: [CatalogoCursosModalidades] = []
    @Published var error: Error?
    @Published var isLoading = false
    
    // Función para recuperar los catálogos de cursos de modalidades
    func fetchCatalogoCursosModalidades() {
       
        service.fetchCatalogoCursosModalidades { result in
            switch result {
            case .success(let catalogoCursosModalidades):
                // Update the published property with the fetched data
                DispatchQueue.main.async {
                    self.catalogoCursosModalidades = catalogoCursosModalidades
                }
            case .failure(let error):
                // Handle failure
                print("Error al obtener el catálogo de cursos catalogoCursosModalidades: \(error.localizedDescription)")
            }
        }
    }
    
    // Función para agregar un nuevo catálogo de cursos de modalidades
    func agregarCatalogoCursosModalidades(nuevoCatalogoCursosModalidades: CatalogoCursosModalidades) {
        isLoading = true
        service.agregarCatalogoCursosModalidades(nuevoCatalogoCursosModalidades: nuevoCatalogoCursosModalidades) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let catalogoCursosModalidades):
                    self.catalogoCursosModalidades.append(catalogoCursosModalidades)
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
    
    // Función para editar un catálogo de cursos de modalidades existente
    func editarCatalogoCursosModalidades(catalogoCursosModalidades: CatalogoCursosModalidades) {
        isLoading = true
        service.editarCatalogoCursosModalidades(catalogoCursosModalidades: catalogoCursosModalidades) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success:
                    // Actualizar el catálogo en la lista después de la edición
                    if let index = self.catalogoCursosModalidades.firstIndex(where: { $0.id == catalogoCursosModalidades.id }) {
                        self.catalogoCursosModalidades[index] = catalogoCursosModalidades
                    }
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
    
    // Función para eliminar un catálogo de cursos de modalidades existente
    func eliminarCatalogoCursosModalidades(idCatalogoCursosModalidades: String) {
        isLoading = true
        service.eliminarCatalogoCursosModalidades(idCatalogoCursosModalidades: idCatalogoCursosModalidades) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success:
                    // Eliminar el catálogo de la lista después de la eliminación
                    if let index = self.catalogoCursosModalidades.firstIndex(where: { $0.id == idCatalogoCursosModalidades }) {
                        self.catalogoCursosModalidades.remove(at: index)
                    }
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
}

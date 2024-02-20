//
//  CatalogoCursosTipoConfidencialidadViewModel.swift
//  iecaappadmin
//
//  Created by Omar on 12/02/24.
//

import Foundation
import Foundation
import Alamofire

class CatalogoCursosTipoConfidencialidadViewModel: ObservableObject {
    
    private let service = CatalogoCursosTipoConfidencialidadAPIService.shared
    private let apiService = CatalogoCursosTipoConfidencialidadAPIService.shared
    @Published var catalogoCursosTipoConfidencialidad: [CatalogoCursosTipoConfidencialidad] = []
    @Published var error: Error?
    @Published var isLoading = false
    
    // Función para recuperar los catálogos de cursos de tipo confidencialidad
    func fetchCatalogoCursosTipoConfidencialidad() {
        apiService.fetchCatalogoCursosTipoConfidencialidad { result in
            switch result {
            case .success(let catalogoCursosTipoConfidencialidad):
                // Update the published property with the fetched data
                DispatchQueue.main.async {
                    self.catalogoCursosTipoConfidencialidad = catalogoCursosTipoConfidencialidad
                }
            case .failure(let error):
                // Handle failure
                print("Error al obtener el catálogo de cursos TipoConfidencialidad: \(error.localizedDescription)")
            }
        }
    }
    
    // Función para agregar un nuevo catálogo de cursos de tipo confidencialidad
    func agregarCatalogoCursosTipoConfidencialidad(nuevoCatalogoCursosTipoConfidencialidad: CatalogoCursosTipoConfidencialidad) {
        isLoading = true
        service.agregarCatalogoCursosTipoConfidencialidad(nuevoCatalogoCursosTipoConfidencialidad: nuevoCatalogoCursosTipoConfidencialidad) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let catalogoCursosTipoConfidencialidad):
                    self.catalogoCursosTipoConfidencialidad.append(catalogoCursosTipoConfidencialidad)
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
    
    // Función para editar un catálogo de cursos de tipo confidencialidad existente
    func editarCatalogoCursosTipoConfidencialidad(catalogoCursosTipoConfidencialidad: CatalogoCursosTipoConfidencialidad) {
        isLoading = true
        service.editarCatalogoCursosTipoConfidencialidad(catalogoCursosTipoConfidencialidad: catalogoCursosTipoConfidencialidad) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success:
                    // Actualizar el catálogo en la lista después de la edición
                    if let index = self.catalogoCursosTipoConfidencialidad.firstIndex(where: { $0.id == catalogoCursosTipoConfidencialidad.id }) {
                        self.catalogoCursosTipoConfidencialidad[index] = catalogoCursosTipoConfidencialidad
                    }
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
    
    // Función para eliminar un catálogo de cursos de tipo confidencialidad existente
    func eliminarCatalogoCursosTipoConfidencialidad(idCatalogoCursosTipoConfidencialidad: String) {
        isLoading = true
        service.eliminarCatalogoCursosTipoConfidencialidad(idCatalogoCursosTipoConfidencialidad: idCatalogoCursosTipoConfidencialidad) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success:
                    // Eliminar el catálogo de la lista después de la eliminación
                    if let index = self.catalogoCursosTipoConfidencialidad.firstIndex(where: { $0.id == idCatalogoCursosTipoConfidencialidad }) {
                        self.catalogoCursosTipoConfidencialidad.remove(at: index)
                    }
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
}

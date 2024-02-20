//
//  CatalogoCursosEspecialidadesViewModel.swift
//  iecaappadmin
//
//  Created by Omar on 12/02/24.
//

import Foundation

import Alamofire

class CatalogoCursosEspecialidadesViewModel: ObservableObject {
    
    private let service = CatalogoCursosEspecialidadesAPIService.shared
    private let apiService = CatalogoCursosEspecialidadesAPIService.shared
    @Published var catalogoCursosEspecialidades: [CatalogoCursosEspecialidades] = []
    @Published var error: Error?
    @Published var isLoading = false
    
    // Función para recuperar los catálogos de cursos de especialidades
    func fetchCatalogoCursosEspecialidades() {
        apiService.fetchCatalogoCursosEspecialidades { result in
            switch result {
            case .success(let catalogoCursosEspecialidades):
                // Update the published property with the fetched data
                DispatchQueue.main.async {
                    self.catalogoCursosEspecialidades = catalogoCursosEspecialidades
                }
            case .failure(let error):
                // Handle failure
                print("Error al obtener el catálogo de cursos especialidad: \(error.localizedDescription)")
            }
        }
    }
    
    // Función para agregar un nuevo catálogo de cursos de especialidades
    func agregarCatalogoCursosEspecialidades(nuevoCatalogoCursosEspecialidades: CatalogoCursosEspecialidades) {
        
        CatalogoCursosEspecialidadesAPIService.shared.agregarCatalogoCursosEspecialidades(nuevoCatalogoCursosEspecialidades: nuevoCatalogoCursosEspecialidades){ [weak self] result in
        switch result {
            case .success(let catalogoCursosEspeciales):
                DispatchQueue.main.async {
                    self?.catalogoCursosEspecialidades.append(catalogoCursosEspeciales)
                    self?.actualizarListaEspecialidades()
                }
            case .failure(let error):
            self?.actualizarListaEspecialidades()
                print("Error al agregar la Especialidad:", error)
                // Puedes manejar el error de alguna manera si es necesario
            }
        }
    }
    
    // Función para editar un catálogo de cursos de especialidades existente
    func editarCatalogoCursosEspecialidades(catalogoCursosEspecialidades: CatalogoCursosEspecialidades) {
        isLoading = true
        service.editarCatalogoCursosEspecialidades(catalogoCursosEspecialidades: catalogoCursosEspecialidades) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success:
                    // Actualizar el catálogo en la lista después de la edición
                    if let index = self.catalogoCursosEspecialidades.firstIndex(where: { $0.id == catalogoCursosEspecialidades.id }) {
                        self.catalogoCursosEspecialidades[index] = catalogoCursosEspecialidades
                    }
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
    
    // Función para eliminar un catálogo de cursos de especialidades existente
    func eliminarCatalogoCursosEspecialidades(idCatalogoCursosEspecialidades: String) {
        isLoading = true
        service.eliminarCatalogoCursosEspecialidades(idCatalogoCursosEspecialidades: idCatalogoCursosEspecialidades) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success:
                    // Eliminar el catálogo de la lista después de la eliminación
                    if let index = self.catalogoCursosEspecialidades.firstIndex(where: { $0.id == idCatalogoCursosEspecialidades }) {
                        self.catalogoCursosEspecialidades.remove(at: index)
                    }
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
    
    func actualizarListaEspecialidades() {
           fetchCatalogoCursosEspecialidades()
       }
}

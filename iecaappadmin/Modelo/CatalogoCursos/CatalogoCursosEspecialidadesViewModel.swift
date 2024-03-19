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
    func fetchCatalogoCursosEspecialidades(idArea: String, completion: @escaping (Result<[CatalogoCursosEspecialidades], Error>) -> Void) {
        apiService.fetchCatalogoCursosEspecialidades(idArea: idArea, completion: completion)
    }
//    func fetchData(idArea: String) {
//           // Llamamos a la función que realiza la consulta al servidor
//           CatalogoCursosEspecialidadesAPIService.shared.fetchCatalogoCursosEspecialidades(idArea: idArea) { [weak self] result in
//               switch result {
//               case .success(let catalogoCursosEspecialidades):
//                   DispatchQueue.main.async {
//                       // Actualizamos la propiedad catalogoCursosEspecialidades con los datos obtenidos
//                       self?.catalogoCursosEspecialidades = catalogoCursosEspecialidades
//                       // Llamamos a la función que depende de los registros obtenidos
//                       self?.doSomethingWithCatalogo()
//                   }
//               case .failure(let error):
//                   // Manejamos el error si es necesario
//                   print("Error al obtener el catálogo de cursos de especialidades:", error)
//               }
//           }
//       }
       
       func doSomethingWithCatalogo() {
         
       }
    func fetchCatalogoCursosEspecialidades(idArea: String) {
        apiService.fetchCatalogoCursosEspecialidades(idArea: idArea) { result in
            switch result {
            case .success(let catalogoCursosEspecialidades):
                // Update the published property with the fetched data
                print("Segunda parte")
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
    func agregarCatalogoCursosEspecialidades(idArea: String,nuevoCatalogoCursosEspecialidades: CatalogoCursosEspecialidades) {
        
        CatalogoCursosEspecialidadesAPIService.shared.agregarCatalogoCursosEspecialidades(nuevoCatalogoCursosEspecialidades: nuevoCatalogoCursosEspecialidades){ [weak self] result in
        switch result {
            case .success(let catalogoCursosEspeciales):
                DispatchQueue.main.async {
                    self?.catalogoCursosEspecialidades.append(catalogoCursosEspeciales)
                    self?.actualizarListaEspecialidades(idArea: idArea)
                }
            case .failure(let error):
            self?.actualizarListaEspecialidades(idArea: idArea)
                print("Error al agregar la Especialidad:", error)
                // Puedes manejar el error de alguna manera si es necesario
            }
        }
    }
    
    // Función para editar un catálogo de cursos de especialidades existente
    func editarCatalogoCursosEspecialidades(idArea: String,catalogoCursosEspecialidades: CatalogoCursosEspecialidades) {
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
    
    func actualizarListaEspecialidades(idArea: String) {
        fetchCatalogoCursosEspecialidades(idArea: idArea)
       }
}

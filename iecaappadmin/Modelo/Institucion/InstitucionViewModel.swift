//  ZonasViewModel.swift

import Foundation
import Alamofire

class InstitucionViewModel: ObservableObject {
    
    @Published var instituciones: [Institucion] = []

    func editarInstitucion(institucion: Institucion) {
        InstitucionAPIService.shared.editarInstitucion(institucion: institucion) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    if let index = self?.instituciones.firstIndex(where: { $0.Id == institucion.Id }) {
                        self?.instituciones[index] = institucion
                    }
                }
            case .failure(let error):
                print("Error al editar la zona:", error)
            }
        }
    }
    
    func eliminarInstitucion(institucion: Institucion) {
        guard let index = instituciones.firstIndex(where: { $0.Id == institucion.Id }) else {
            return
        }

        InstitucionAPIService.shared.eliminarInstitucion(idInstitucion: institucion.Id) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.instituciones.remove(at: index)
                }
            case .failure(let error):
                print("Error al eliminar la zona:", error)
            }
        }
    }

//    func fetchInstitucion() {
//        InstitucionAPIService.shared.fetchInstituciones { [weak self] result in
//            switch result {
//            case .success(let instituciones):
//                DispatchQueue.main.async {
//                    self?.instituciones = instituciones
//                }
//            case .failure(let error):
//                print("Error al obtener datos de la API:", error)
//            }
//        }
//    }
    
    func fetchInstitucion() {
        InstitucionAPIService.shared.fetchInstituciones { [weak self] result in
            switch result {
            case .success(let instituciones):
                DispatchQueue.main.async {
                    self?.instituciones = instituciones
                    // Imprimir los datos de las instituciones
                    print("Datos de las instituciones:")
                    for institucion in instituciones {
                        print("Nombre: \(institucion.Nombre)")
                        print("Correo: \(institucion.Correo)")
                        print("Teléfono: \(institucion.Telefono)")
                        // Imprime los demás atributos según sea necesario
                    }
                }
            case .failure(let error):
                print("Error al obtener datos de la API:", error)
            }
        }
    }
    
    func agregarNuevaInstitucion(nuevaInstitucion: Institucion) {
        InstitucionAPIService.shared.agregarInstitucion(institucion: nuevaInstitucion) { [weak self] result in
               switch result {
               case .success(let institucion):
                   DispatchQueue.main.async {
                       self?.instituciones.append(institucion)
                       self?.actualizarListaInstitucion()
                   }
               case .failure(let error):
                   self?.actualizarListaInstitucion()
                   print("Error al agregar la Zona:", error)
               }
           }
       }

    
    func actualizarListaInstitucion() {
        fetchInstitucion()
    }
}


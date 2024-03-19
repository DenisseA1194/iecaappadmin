
//  ZonasViewModel.swift

import Foundation
import Alamofire

class CursosAutorizacionViewModel: ObservableObject {
    
    @Published var autorizaciones: [CursosAutorizaciones] = []

    func editarAutorizacion(autorizacion: CursosAutorizaciones) {
        CursosAutorizacionesAPIService.shared.editarCursosAutorizaciones(cursosAutorizaciones:autorizacion) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    if let index = self?.autorizaciones.firstIndex(where: { $0.Id == autorizacion.Id }) {
                        self?.autorizaciones[index] = autorizacion
                    }
                }
            case .failure(let error):
                print("Error al editar la autorizacion:", error)
            }
        }
    }
    
    func eliminarAutorizacion(autorizacion: CursosAutorizaciones) {
        guard let index = autorizaciones.firstIndex(where: { $0.Id == autorizacion.Id }) else {
            return
        }

        CursosAutorizacionesAPIService.shared.eliminarCursosAutorizaciones(idCursosAutorizaciones: autorizacion.Id) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.autorizaciones.remove(at: index)
                }
            case .failure(let error):
                print("Error al eliminar la zona:", error)
            }
        }
    }

    func fetchAutorizaciones() {
        CursosAutorizacionesAPIService.shared.fetchCursosAutorizaciones() { [weak self] result in
            switch result {
            case .success(let autorizaciones):
                DispatchQueue.main.async {
                    self?.autorizaciones = autorizaciones
                }
            case .failure(let error):
                print("Error al obtener datos de la API:", error)
            }
        }
    }
    
    func agregarNuevaAutorizacion(nuevaAutorizacion: CursosAutorizaciones) {
           CursosAutorizacionesAPIService.shared.agregarCursosAutorizaciones(nuevoCursosAutorizaciones: nuevaAutorizacion) { [weak self] result in
               switch result {
               case .success(let autorizacion):
                   DispatchQueue.main.async {
                       self?.autorizaciones.append(autorizacion)
                       self?.actualizarAutorizaciones()
                   }
               case .failure(let error):
                   self?.actualizarAutorizaciones()
                   print("Error al agregar la Zona:", error)
               }
           }
       }

    
    func actualizarAutorizaciones() {
        fetchAutorizaciones()
    }
}


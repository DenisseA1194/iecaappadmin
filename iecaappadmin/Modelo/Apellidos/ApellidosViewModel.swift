//  ZonasViewModel.swift

import Foundation
import Alamofire

class ApellidoViewModel: ObservableObject {
    
    @Published var apellido: [Apellido] = []

    func editarZona(apellido: Apellido) {
        ApellidoAPIService.shared.editarApellidos(apellido: apellido) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    if let index = self?.apellido.firstIndex(where: { $0.Id == apellido.Id }) {
                        self?.apellido[index] = apellido
                    }
                }
            case .failure(let error):
                print("Error al editar la zona:", error)
            }
        }
    }
//    
//    func eliminarApellido(apellido: Apellido) {
//        guard let index = apellido.firstIndex(where: { $0.Id == apellido.Id }) else {
//            return
//        }
//
//        ApellidoAPIService.shared.eliminarApellidos(idApellido: apellido.Id) { [weak self] result in
//            switch result {
//            case .success:
//                DispatchQueue.main.async {
//                    self?.apellido.remove(at: index)
//                }
//            case .failure(let error):
//                print("Error al eliminar la zona:", error)
//            }
//        }
//    }

    func fetchApellidos() {
        ApellidoAPIService.shared.fetchApellidos { [weak self] result in
            switch result {
            case .success(let apellido):
                DispatchQueue.main.async {
                    self?.apellido = apellido
                }
            case .failure(let error):
                print("Error al obtener datos de la API:", error)
            }
        }
    }
    
    func agregarNuevaApellido(nuevaApellido: Apellido) {
           ApellidoAPIService.shared.agregarApellidos(apellido: nuevaApellido) { [weak self] result in
               switch result {
               case .success(let apellido):
                   DispatchQueue.main.async {
                       self?.apellido.append(apellido)
                       self?.actualizarListaApellido()
                   }
               case .failure(let error):
                   self?.actualizarListaApellido()
                   print("Error al agregar la Zona:", error)
               }
           }
       }

    
    func actualizarListaApellido() {
        fetchApellidos()
    }
}



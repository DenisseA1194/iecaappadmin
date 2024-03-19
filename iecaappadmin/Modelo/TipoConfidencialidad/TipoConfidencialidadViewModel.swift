// TipoConfidencialidadViewModel.swift
import Foundation

class TipoConfidencialidadViewModel: ObservableObject {
    
    @Published var tipoConfidencialidad: [TipoConfidencialidad] = []

    func editarTipoConfidencialidad(tipoConfidencialidad: TipoConfidencialidad) {
        TipoConfidencialidadAPIService.shared.editarTipoConfidencialidad(tipoConfidencialidad: tipoConfidencialidad) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    if let index = self?.tipoConfidencialidad.firstIndex(where: { $0.Id == tipoConfidencialidad.Id }) {
                        self?.tipoConfidencialidad[index] = tipoConfidencialidad
                    }
                }
            case .failure(let error):
                print("Error al editar el tipo de confidencialidad:", error)
            }
        }
    }
//    
//    func eliminarTipoConfidencialidad(tipoConfidencialidad: TipoConfidencialidad) {
//        guard let index = tipoConfidencialidadViewModel.tiposConfidencialidad.firstIndex(where: { $0.Id == tipoConfidencialidad.Id }) else {
//            return
//        }
//
//        TipoConfidencialidadAPIService.shared.eliminarTipoConfidencialidad(idTipoConfidencialidad: tipoConfidencialidad.Id) { [weak self] result in
//            switch result {
//            case .success:
//                DispatchQueue.main.async {
//                    self?.tiposConfidencialidadViewModel.tiposConfidencialidad.remove(at: index)
//                }
//            case .failure(let error):
//                print("Error al eliminar el tipo de confidencialidad:", error)
//            }
//        }
//    }


    func fetchTiposConfidencialidad() {
        TipoConfidencialidadAPIService.shared.fetchTiposConfidencialidad { [weak self] result in
            switch result {
            case .success(let tiposConfidencialidad):
                DispatchQueue.main.async {
                    self?.tipoConfidencialidad = tiposConfidencialidad
                }
            case .failure(let error):
                print("Error al obtener datos de la API:", error)
            }
        }
    }
    
    func agregarNuevoTipoConfidencialidad(nuevoTipoConfidencialidad: TipoConfidencialidad) {
           TipoConfidencialidadAPIService.shared.agregarTipoConfidencialidad(tipoConfidencialidad: nuevoTipoConfidencialidad) { [weak self] result in
               switch result {
               case .success(let tipoConfidencialidad):
                   DispatchQueue.main.async {
                       self?.tipoConfidencialidad.append(tipoConfidencialidad)
                       self?.actualizarListaTiposConfidencialidad()
                   }
               case .failure(let error):
                   self?.actualizarListaTiposConfidencialidad()
                   print("Error al agregar el Tipo de Confidencialidad:", error)
               }
           }
       }

    
    func actualizarListaTiposConfidencialidad() {
        fetchTiposConfidencialidad()
    }
}


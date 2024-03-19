//  ZonasViewModel.swift

import Foundation
import Alamofire

class PuestosViewModel: ObservableObject {
    
    @Published var puesto: [Puesto] = []

    func editarPuesto(puesto: Puesto) {
        PuestoAPIService.shared.editarPuesto(puesto: puesto) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    if let index = self?.puesto.firstIndex(where: { $0.Id == puesto.Id }) {
                        self?.puesto[index] = puesto
                    }
                }
            case .failure(let error):
                print("Error al editar el puesto:", error)
            }
        }
    }
    
    func eliminarPuesto(puestos: Puesto) {
        guard let index = puesto.firstIndex(where: { $0.Id == puestos.Id }) else {
            return
        }

        PuestoAPIService.shared.eliminarPuesto(idPuesto: puestos.Id) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.puesto.remove(at: index)
                }
            case .failure(let error):
                print("Error al eliminar la zona:", error)
            }
        }
    }

    func fetchPuesto() {
        PuestoAPIService.shared.fetchPuestos { [weak self] result in
            switch result {
            case .success(let puesto):
                DispatchQueue.main.async {
                    self?.puesto = puesto
                }
            case .failure(let error):
                print("Error al obtener datos de la API:", error)
            }
        }
    }
    
    func agregarNuevaPuesto(nuevaPuesto: Puesto) {
        PuestoAPIService.shared.agregarPuesto(puesto: nuevaPuesto) { [weak self] result in
               switch result {
               case .success(let puesto):
                   DispatchQueue.main.async {
                       self?.puesto.append(puesto)
                       self?.actualizarListaPuesto()
                   }
               case .failure(let error):
                   self?.actualizarListaPuesto()
                   print("Error al agregar la Zona:", error)
               }
           }
       }

    
    func actualizarListaPuesto() {
        fetchPuesto()
    }
}



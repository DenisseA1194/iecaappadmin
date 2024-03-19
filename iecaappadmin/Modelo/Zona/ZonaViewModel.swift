//  ZonasViewModel.swift

import Foundation
import Alamofire

class ZonasViewModel: ObservableObject {
    
    @Published var zonas: [Zona] = []

    func editarZona(zona: Zona) {
        ZonaAPIService.shared.editarZona(zona: zona) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    if let index = self?.zonas.firstIndex(where: { $0.Id == zona.Id }) {
                        self?.zonas[index] = zona
                    }
                }
            case .failure(let error):
                print("Error al editar la zona:", error)
            }
        }
    }
    
    func eliminarZona(zona: Zona) {
        guard let index = zonas.firstIndex(where: { $0.Id == zona.Id }) else {
            return
        }

        ZonaAPIService.shared.eliminarZona(idZona: zona.Id) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.zonas.remove(at: index)
                }
            case .failure(let error):
                print("Error al eliminar la zona:", error)
            }
        }
    }

    func fetchZonas() {
        ZonaAPIService.shared.fetchZonas { [weak self] result in
            switch result {
            case .success(let zonas):
                DispatchQueue.main.async {
                    self?.zonas = zonas
                }
            case .failure(let error):
                print("Error al obtener datos de la API:", error)
            }
        }
    }
    
    func agregarNuevaZona(nuevaZona: Zona) {
           ZonaAPIService.shared.agregarZona(zona: nuevaZona) { [weak self] result in
               switch result {
               case .success(let zona):
                   DispatchQueue.main.async {
                       self?.zonas.append(zona)
                       self?.actualizarListaZonas()
                   }
               case .failure(let error):
                   self?.actualizarListaZonas()
                   print("Error al agregar la Zona:", error)
               }
           }
       }

    
    func actualizarListaZonas() {
        fetchZonas()
    }
}


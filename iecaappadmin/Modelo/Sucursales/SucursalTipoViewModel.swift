//
//  SucursalTipoViewModel.swift
//  iecaappadmin
//
//  Created by Omar on 06/02/24.
//

import Foundation
import Alamofire

class SucursalTipoViewModel: ObservableObject {
    
    @Published var sucursalesTipo: [SucursalTipo] = []

    func editarSucursalTipo(sucursalTipo: SucursalTipo) {
        SucursalTipoAPIService.shared.editarSucursalTipo(sucursalTipo: sucursalTipo) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    if let index = self?.sucursalesTipo.firstIndex(where: { $0.Id == sucursalTipo.Id }) {
                        self?.sucursalesTipo[index] = sucursalTipo
                    }
                }
            case .failure(let error):
                print("Error al editar la SucursalTipo:", error)
            }
        }
    }
    
    func eliminarSucursalTipo(sucursalTipo: SucursalTipo) {
        guard let index = sucursalesTipo.firstIndex(where: { $0.Id == sucursalTipo.Id }) else {
            return
        }

        SucursalTipoAPIService.shared.eliminarSucursalTipo(idSucursalTipo: sucursalTipo.Id) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.sucursalesTipo.remove(at: index)
                }
            case .failure(let error):
                print("Error al eliminar la SucursalTipo:", error)
            }
        }
    }

    func fetchSucursalesTipo() {
        SucursalTipoAPIService.shared.fetchSucursalesTipo { [weak self] result in
            switch result {
            case .success(let sucursales):
                DispatchQueue.main.async {
                    self?.sucursalesTipo = sucursales
                }
            case .failure(let error):
                print("Error al obtener datos de la API:", error)
            }
        }
    }
    
     func agregarNuevaSucursal(nuevaSucursalTipo: SucursalTipo) {
         SucursalTipoAPIService.shared.agregarSucursalTipo(nuevaSucursalTipo: nuevaSucursalTipo) { [weak self] result in
             switch result {
             case .success(let sucursalTipo):
                 DispatchQueue.main.async {
                     self?.sucursalesTipo.append(sucursalTipo)
                     self?.actualizarListaSucursalesTipo()
                 }
             case .failure(let error):
                 self?.actualizarListaSucursalesTipo()
                 print("Error al agregar la SucursalTipo:", error)
             }
         }
     }

    func actualizarListaSucursalesTipo() {
        fetchSucursalesTipo()
    }
}



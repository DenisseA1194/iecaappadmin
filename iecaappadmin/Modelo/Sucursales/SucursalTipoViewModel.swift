//
//  SucursalTipoViewModel.swift
//  iecaappadmin
//
//  Created by Omar on 06/02/24.
//

import Foundation
import Alamofire

class SucursalTipoViewModel: ObservableObject {
    
    @Published var sucursales: [SucursalTipo] = []

    func editarSucursal(sucursal: SucursalTipo) {
        SucursalTipoAPIService.shared.editarSucursal(sucursal: sucursal) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    if let index = self?.sucursales.firstIndex(where: { $0.Id == sucursal.Id }) {
                        self?.sucursales[index] = sucursal
                    }
                }
            case .failure(let error):
                print("Error al editar la SucursalTipo:", error)
            }
        }
    }
    
    func eliminarSucursal(sucursal: SucursalTipo) {
        guard let index = sucursales.firstIndex(where: { $0.Id == sucursal.Id }) else {
            return
        }

        SucursalTipoAPIService.shared.eliminarSucursal(idSucursal: sucursal.Id) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.sucursales.remove(at: index)
                }
            case .failure(let error):
                print("Error al eliminar la SucursalTipo:", error)
            }
        }
    }

    func fetchSucursales() {
        SucursalTipoAPIService.shared.fetchSucursales { [weak self] result in
            switch result {
            case .success(let sucursales):
                DispatchQueue.main.async {
                    self?.sucursales = sucursales
                }
            case .failure(let error):
                print("Error al obtener datos de la API:", error)
            }
        }
    }
    
    // func agregarNuevaSucursal(nuevaSucursal: Sucursal) {
    //     SucursalAPIService.shared.agregarSucursal(nuevaSucursal: nuevaSucursal) { [weak self] result in
    //         switch result {
    //         case .success(let sucursal):
    //             DispatchQueue.main.async {
    //                 self?.sucursales.append(sucursal)
    //                 self?.actualizarListaSucursales()
    //             }
    //         case .failure(let error):
    //             self?.actualizarListaSucursales()
    //             print("Error al agregar la SucursalTipo:", error)
    //         }
    //     }
    // }

    func actualizarListaSucursales() {
        fetchSucursales()
    }
}



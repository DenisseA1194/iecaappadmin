//
//  SucursalesViewModel.swift
//  iecaappadmin
//
//  Created by Omar on 06/02/24.
//

import Foundation
import Alamofire



class SucursalesViewModel: ObservableObject {
    
    @Published var sucursales: [Sucursal] = []

    
    func editarSucursal(sucursal: Sucursal) {
       
        
                SucursalAPIService.shared.editarSucursal(sucursal: sucursal) { [weak self] result in
                    switch result {
                    case .success:
                        DispatchQueue.main.async {
                           
                            if let index = self?.sucursales.firstIndex(where: { $0.Id == sucursal.Id }) {
                                self?.sucursales[index] = sucursal
                            }
                        }
                    case .failure(let error):
                        print("Error al editar la sucursal:", error)
                       
                    }
                }
            
        
    }
    
    func eliminarSucursal(sucursal: Sucursal) {
        guard let index = sucursales.firstIndex(where: { $0.Id == sucursal.Id }) else {
                    return
                }

                SucursalAPIService.shared.eliminarSucursal(idSucursal: sucursal.Id) { [weak self] result in
                    switch result {
                    case .success:
                        DispatchQueue.main.async {
                            self?.sucursales.remove(at: index)
                        }
                    case .failure(let error):
                        print("Error al eliminar la sucursal:", error)
                    }
                }
       }
    
    
  
       func fetchSucursales() {
           
           
           SucursalAPIService.shared.fetchSucursales { [weak self] result in
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
    
    func agregarNuevaSucursal(nuevaSucursal: Sucursal) {
        
        SucursalAPIService.shared.agregarSucursal(nuevaSucursal: nuevaSucursal) { [weak self] result in
        switch result {
            case .success(let sucursal):
                DispatchQueue.main.async {
                    self?.sucursales.append(sucursal)
                    self?.actualizarListaSucursales()
                }
            case .failure(let error):
            self?.actualizarListaSucursales()
                print("Error al agregar la sucursal:", error)
                // Puedes manejar el error de alguna manera si es necesario
            }
        }
       }
    
    func actualizarListaSucursales() {
           fetchSucursales()
       }
        
    }

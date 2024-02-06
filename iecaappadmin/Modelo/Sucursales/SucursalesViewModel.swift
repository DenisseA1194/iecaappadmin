//
//  SucursalesViewModel.swift
//  iecaappadmin
//
//  Created by Omar on 06/02/24.
//

import Foundation
import Alamofire



class SucursalesViewModel: ObservableObject {
    
    func editarSucursal(sucursal: Sucursal) {
        // Agregar lógica para enviar los cambios al servidor, actualizar datos, etc.
        // Aquí simplemente simulamos editar la sucursal en el ViewModel para fines de demostración.
//        if let index = sucursales.firstIndex(where: { $0.Id == sucursal.Id }) {
//            sucursales[index] = sucursal
//        }
        
                SucursalAPIService.shared.editarSucursal(sucursal: sucursal) { [weak self] result in
                    switch result {
                    case .success:
                        DispatchQueue.main.async {
                            // Actualizar la sucursal en la lista
                            if let index = self?.sucursales.firstIndex(where: { $0.Id == sucursal.Id }) {
                                self?.sucursales[index] = sucursal
                            }
                        }
                    case .failure(let error):
                        print("Error al editar la sucursal:", error)
                        // Puedes manejar el error de alguna manera si es necesario
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
    
    
    @Published var sucursales: [Sucursal] = []  // Inicializar con un array vacío

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

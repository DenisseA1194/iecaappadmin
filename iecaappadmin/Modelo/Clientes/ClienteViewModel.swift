//
//  ClienteViewModel.swift
//  iecaappadmin
//
//  Created by Omar on 06/02/24.
//

import Foundation
import Alamofire

class ClientesViewModel: ObservableObject {
    @Published var clientes: [Cliente] = []

    
    func editarClientes(cliente: Cliente) {
       
                ClienteAPIService.shared.editarCliente(cliente: cliente) { [weak self] result in
                    switch result {
                    case .success:
                        DispatchQueue.main.async {
                          
                            if let index = self?.clientes.firstIndex(where: { $0.Id == cliente.IdCliente }) {
                                self?.clientes[index] = cliente
                            }
                        }
                    case .failure(let error):
                        print("Error al editar el cliente:", error)
                       
                    }
                }
            
        
    }
    
    func eliminarCliente(cliente: Cliente) {
        guard let index = clientes.firstIndex(where: { $0.IdCliente == cliente.IdCliente }) else {
                    return
                }

                ClienteAPIService.shared.eliminarCliente(idCliente: cliente.IdCliente) { [weak self] result in
                    switch result {
                    case .success:
                        DispatchQueue.main.async {
                            self?.clientes.remove(at: index)
                        }
                    case .failure(let error):
                        print("Error al eliminar el cliente:", error)
                    }
                }
       }
    
    
   
       func fetchClientes() {
           ClienteAPIService.shared.fetchClientes { [weak self] result in
               switch result {
               case .success(let clientes):
                   DispatchQueue.main.async {
                       self?.clientes = clientes
                       
                   }
               case .failure(let error):
                   print("Error al obtener datos de la API:", error)
               }
           }
       }
    
    func agregarNuevoCliente(nuevoCliente: Cliente) {
        
        ClienteAPIService.shared.agregarCliente(cliente: nuevoCliente) { [weak self] result in
        switch result {
            case .success(let cliente):
                DispatchQueue.main.async {
                    self?.clientes.append(cliente)
                    self?.actualizarListaClientes()
                }
            case .failure(let error):
            self?.actualizarListaClientes()
                print("Error al agregar cliente:", error)
               
            }
        }
       }
    
    func actualizarListaClientes() {
           fetchClientes()
       }
        
    }

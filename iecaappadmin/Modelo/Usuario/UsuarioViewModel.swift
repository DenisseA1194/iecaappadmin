//
//  UsuarioViewModel.swift
//  iecaappadmin
//
//  Created by Omar on 01/03/24.
//

import Foundation


import Foundation
import Alamofire

class UsuariosViewModel: ObservableObject {
    
    @Published var usuarios: [Usuarios] = []

    func editarUsuario(usuario: Usuarios) {
        UsuariosAPIService.shared.editarUsuario(usuario: usuario) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    if let index = self?.usuarios.firstIndex(where: { $0.Id == usuario.Id }) {
                        self?.usuarios[index] = usuario
                    }
                }
            case .failure(let error):
                print("Error al editar el Usuario:", error)
            }
        }
    }
    
    func eliminarUsuario(usuario: Usuarios) {
        guard let index = usuarios.firstIndex(where: { $0.Id == usuario.Id }) else {
            return
        }

        UsuariosAPIService.shared.eliminarUsuario(idUsuario: usuario.Id) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.usuarios.remove(at: index)
                }
            case .failure(let error):
                print("Error al eliminar el Usuario:", error)
            }
        }
    }

    func fetchUsuarios() {
        UsuariosAPIService.shared.fetchUsuarios { [weak self] result in
            switch result {
            case .success(let usuarios):
                DispatchQueue.main.async {
                    self?.usuarios = usuarios
                }
            case .failure(let error):
                print("Error al obtener datos de la API:", error)
            }
        }
    }
    
    func agregarNuevoUsuario(nuevoUsuario: Usuarios) {
        UsuariosAPIService.shared.agregarUsuario(usuario: nuevoUsuario) { [weak self] result in
            switch result {
            case .success(let usuario):
                DispatchQueue.main.async {
                    self?.usuarios.append(usuario)
                    self?.actualizarListaUsuarios()
                }
            case .failure(let error):
                self?.actualizarListaUsuarios()
                print("Error al agregar el Usuario:", error)
            }
        }
    }

    func actualizarListaUsuarios() {
        fetchUsuarios()
    }
}

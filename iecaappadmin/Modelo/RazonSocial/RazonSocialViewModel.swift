//  RazonSocialViewModel.swift
//  iecaappadmin
//
//  Created by Omar on 22/02/24.
//

import Foundation
import FirebaseFirestore

class RazonSocialViewModel: ObservableObject {
    
    @Published var razonSocials: [RazonSocial] = []
    
    func editarRazonSocial(razonSocial: RazonSocial) {
        RazonSocialAPIService.shared.editarRazonSocial(razonSocial: razonSocial) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    
                    if let index = self?.razonSocials.firstIndex(where: { $0.id == razonSocial.id }) {
                        self?.razonSocials[index] = razonSocial
                    }
                }
            case .failure(let error):
                print("Error al editar la razon social:", error)
                
            }
        }
    }
    
    func eliminarRazonSocial(razonSocial: RazonSocial) {
        guard let index = razonSocials.firstIndex(where: { $0.id == razonSocial.id }) else {
            return
        }
        
        RazonSocialAPIService.shared.eliminarRazonSocial(idRazonSocial: razonSocial.id) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.razonSocials.remove(at: index)
                }
            case .failure(let error):
                print("Error al eliminar la razon social:", error)
            }
        }
    }
    
    func fetchRazonSocials() {
        RazonSocialAPIService.shared.fetchRazonesSociales { [weak self] result in
            switch result {
            case .success(let razonSocials):
                DispatchQueue.main.async {
                    self?.razonSocials = razonSocials
                }
            case .failure(let error):
                print("Error al obtener datos de la API:", error)
            }
        }
    }
    
    func agregarNuevaRazonSocial(nuevaRazonSocial: RazonSocial) {
        RazonSocialAPIService.shared.agregarRazonSocial(razonSocial: nuevaRazonSocial) { [weak self] result in
            switch result {
            case .success(let razonSocial):
                DispatchQueue.main.async {
                    self?.razonSocials.append(razonSocial)
                    self?.actualizarListaRazonSocials()
                }
            case .failure(let error):
                self?.actualizarListaRazonSocials()
                print("Error al agregar la razon social:", error)
            }
        }
    }
    
    func actualizarListaRazonSocials() {
        fetchRazonSocials()
    }
}


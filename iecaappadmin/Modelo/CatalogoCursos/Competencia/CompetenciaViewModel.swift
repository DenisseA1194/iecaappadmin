//  ZonasViewModel.swift

import Foundation
import Alamofire

class CompetenciaViewModel: ObservableObject {
    
    @Published var competencias: [Competencia] = []

    func editarCompetencia(competencia: Competencia) {
        CompetenciaAPIService.shared.editarCompetencia(competencia: competencia) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    if let index = self?.competencias.firstIndex(where: { $0.Id == competencia.Id }) {
                        self?.competencias[index] = competencia
                    }
                }
            case .failure(let error):
                print("Error al editar la zona:", error)
            }
        }
    }
    
    func eliminarCompetencia(competencia: Competencia) {
        guard let index = competencias.firstIndex(where: { $0.Id == competencia.Id }) else {
            return
        }

        CompetenciaAPIService.shared.eliminarCompetencia(idCompetencia: competencia.Id) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.competencias.remove(at: index)
                }
            case .failure(let error):
                print("Error al eliminar la zona:", error)
            }
        }
    }

    func fetchCompetencias() {
        CompetenciaAPIService.shared.fetchCompetencias { [weak self] result in
            switch result {
            case .success(let competencias):
                DispatchQueue.main.async {
                    self?.competencias = competencias
                }
            case .failure(let error):
                print("Error al obtener datos de la API:", error)
            }
        }
    }
    
    func agregarNuevaCompetencia(nuevaCompetencia: Competencia) {
           CompetenciaAPIService.shared.agregarCompetencia(nuevaCompetencia: nuevaCompetencia) { [weak self] result in
               switch result {
               case .success(let competencia):
                   DispatchQueue.main.async {
                       self?.competencias.append(competencia)
                       self?.actualizarListaCompetencias()
                   }
               case .failure(let error):
                   self?.actualizarListaCompetencias()
                   print("Error al agregar la Zona:", error)
               }
           }
       }

    
    func actualizarListaCompetencias() {
        fetchCompetencias()
    }
}


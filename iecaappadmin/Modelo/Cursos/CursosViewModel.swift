//
//  CursosViewModel.swift
//  iecaappadmin
//
//  Created by Omar on 07/02/24.
//

import Foundation
import Alamofire

class CursosViewModel: ObservableObject {
    
    @Published var cursos: [Curso] = []
    
    func editarCurso(curso: Curso) {
                CursoAPIService.shared.editarCurso(curso: curso) { [weak self] result in
                    switch result {
                    case .success:
                        DispatchQueue.main.async {
                           
                            if let index = self?.cursos.firstIndex(where: { $0.Id == curso.Id }) {
                                self?.cursos[index] = curso
                            }
                        }
                    case .failure(let error):
                        print("Error al editar la sucursal:", error)
                       
                    }
                }
    }
    
    func eliminarCurso(curso: Curso) {
        guard let index = cursos.firstIndex(where: { $0.Id == curso.Id }) else {
                    return
                }

                CursoAPIService.shared.eliminarCurso(idCurso: curso.Id) { [weak self] result in
                    switch result {
                    case .success:
                        DispatchQueue.main.async {
                            self?.cursos.remove(at: index)
                        }
                    case .failure(let error):
                        print("Error al eliminar el curso:", error)
                    }
                }
       }
    
    

       func fetchCursos() {
           CursoAPIService.shared.fetchCursos { [weak self] result in
               switch result {
               case .success(let cursos):
                   DispatchQueue.main.async {
                       self?.cursos = cursos
                   }
               case .failure(let error):
                   print("Error al obtener datos de la API:", error)
               }
           }
       }
    
    func agregarNuevoCurso(nuevoCurso: Curso) {
        CursoAPIService.shared.agregarCurso(curso: nuevoCurso) { [weak self] result in
        switch result {
            case .success(let curso):
                DispatchQueue.main.async {
                    self?.cursos.append(curso)
                    self?.actualizarListaCursos()
                }
            case .failure(let error):
            self?.actualizarListaCursos()
                print("Error al agregar curso:", error)
            }
        }
       }
    
    func actualizarListaCursos() {
           fetchCursos()
       }
        
    }


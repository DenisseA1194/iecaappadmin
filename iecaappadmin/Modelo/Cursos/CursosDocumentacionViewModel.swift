//
//  CursosDocumentacionViewModel.swift
//  iecaappadmin
//
//  Created by Omar on 11/02/24.
//

import Foundation

import Alamofire

//class CursosDocumentacionViewModel: ObservableObject {
//    
//    @Published var cursos: [CursosDocumentacion] = []
//    
//   func editarCurso(curso: CursosActividades) {
//        CursosDocumentacionAPIService.shared.editarCursosActividades(cursosActividades: curso) { [weak self] result in
//                    switch result {
//                    case .success:
//                        DispatchQueue.main.async {
//                           
//                            if let index = self?.cursos.firstIndex(where: { $0.Id == curso.Id }) {
//                                self?.cursos[index] = curso
//                            }
//                        }
//                    case .failure(let error):
//                        print("Error al editar la actividad:", error)
//                       
//                    }
//                }
//    }
//    
//    func eliminarCurso(curso: CursosActividades) {
//        guard let index = cursos.firstIndex(where: { $0.Id == curso.Id }) else {
//                    return
//                }
//
//        CursosActividadesAPIService.shared.eliminarCursosActividades(idCursosActividades: curso.Id) { [weak self] result in
//                    switch result {
//                    case .success:
//                        DispatchQueue.main.async {
//                            self?.cursos.remove(at: index)
//                        }
//                    case .failure(let error):
//                        print("Error al eliminar el actividad:", error)
//                    }
//                }
//       }
//    
//    
//
//       func fetchCursos() {
//           CursosActividadesAPIService.shared.fetchCursosActividades { [weak self] result in
//               switch result {
//               case .success(let cursos):
//                   DispatchQueue.main.async {
//                       self?.cursos = cursos
//                   }
//               case .failure(let error):
//                   print("Error al obtener datos de la API:", error)
//               }
//           }
//       }
//    
//    func agregarNuevoCurso(nuevoCurso: CursosActividades) {
//        CursosActividadesAPIService.shared.agregarCursosActividades(nuevoCursosActividades: nuevoCurso) { [weak self] result in
//        switch result {
//            case .success(let curso):
//                DispatchQueue.main.async {
//                    self?.cursos.append(curso)
//                    self?.actualizarListaCursos()
//                }
//            case .failure(let error):
//            self?.actualizarListaCursos()
//                print("Error al agregar actividad:", error)
//            }
//        }
//       }
//    
//    func actualizarListaCursos() {
//           fetchCursos()
//       }
//        
//    }

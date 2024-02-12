//
//  CursosBibliografiaViewModel.swift
//  iecaappadmin
//
//  Created by Omar on 11/02/24.
//

import Foundation


class CursosBibliografiaViewModel: ObservableObject {
    
    @Published var cursos: [CursosBiografias] = []
    
    func editarCursoBiografia(curso: CursosBiografias) {
        CursosBiografiasAPIService.shared.editarCursosBiografias(cursosBiografias: curso) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    
                    if let index = self?.cursos.firstIndex(where: { $0.Id == curso.Id }) {
                        self?.cursos[index] = curso
                    }
                    
                }
            case .failure(let error):
                print("Error al editar la biografia:", error)
                
            }
        }
    }
    
    func eliminarCursoBiografia(curso: CursosBiografias) {
        guard let index = cursos.firstIndex(where: { $0.Id == curso.Id }) else {
            return
        }
        
        CursosBiografiasAPIService.shared.eliminarCursosBiografias(idCursosBiografias: curso.Id) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.cursos.remove(at: index)
                }
            case .failure(let error):
                print("Error al eliminar el actividad:", error)
            }
        }
    }
    
    func fetchCursosBiografia() {
        CursosBiografiasAPIService.shared.fetchCursosBiografias { [weak self] result in
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
    
    func agregarNuevoCursoBiografia(nuevoCurso: CursosBiografias) {
        CursosBiografiasAPIService.shared.agregarCursosBiografias(nuevoCursosBiografias: nuevoCurso) { [weak self] result in
            switch result {
            case .success(let curso):
                DispatchQueue.main.async {
                    self?.cursos.append(curso)
                    self?.actualizarListaCursos()
                }
            case .failure(let error):
                self?.actualizarListaCursos()
                print("Error al agregar biografia:", error)
            }
        }
    }
    
    func actualizarListaCursos() {
        fetchCursosBiografia()
    }
    
}

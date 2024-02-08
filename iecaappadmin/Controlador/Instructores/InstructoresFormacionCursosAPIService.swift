//
//  File14.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class InstructoresFormacionCursosAPIService {
  
        private let webService = WebService()
        static let shared = InstructoresFormacionCursosAPIService()
    
    func editarInstructoresFormacionCursos(instructoresFormacionCursos: InstructoresFormacionCursos, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/InstructoresFormacionCursos/\(instructoresFormacionCursos.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdEmpresa": instructoresFormacionCursos.IdEmpresa,
            "IdInstructor":instructoresFormacionCursos.IdInstructor,
            "IdInstitucion": instructoresFormacionCursos.IdInstitucion,
            "FechaInicio": formattedDate,
            "FechaFinaliza": formattedDate,
            "Tema": instructoresFormacionCursos.Tema,
            "Duracion":instructoresFormacionCursos.Duracion,
            "Observaciones": instructoresFormacionCursos.Observaciones,
            "FechaAlta": formattedDate,
            "Calificacion":instructoresFormacionCursos.Calificacion,
            "IdCursoObtenido":instructoresFormacionCursos.IdCursoObtenido,
            "Notas":instructoresFormacionCursos.Notas,
            "IdAreaInteres":instructoresFormacionCursos.IdAreaInteres
        ]
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                print("JSON a enviar:")
                print(jsonString)
            }

        AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    
    func eliminarInstructoresFormacionCursos(idInstructoresFormacionCursos: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/InstructoresFormacionCursos/\(idInstructoresFormacionCursos)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
           AF.request(url, method: .delete)
               .validate()
               .response { response in
                   switch response.result {
                   case .success:
                       completion(.success(()))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }

        func fetchInstructoresFormacionCursos(completion: @escaping (Result<[InstructoresFormacionCursos], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/InstructoresFormacionCursos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [InstructoresFormacionCursos].self) { response in
                    switch response.result {
                    case .success(let instructoresFormacionCursos):
                        completion(.success(instructoresFormacionCursos))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarInstructoresFormacionCursos(nuevoInstructoresFormacionCursos: InstructoresFormacionCursos, completion: @escaping (Result<InstructoresFormacionCursos, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdEmpresa": nuevoInstructoresFormacionCursos.IdEmpresa,
            "IdInstructor":nuevoInstructoresFormacionCursos.IdInstructor,
            "IdInstitucion": nuevoInstructoresFormacionCursos.IdInstitucion,
            "FechaInicio": nuevoInstructoresFormacionCursos.FechaInicio,
            "FechaFinaliza": nuevoInstructoresFormacionCursos.FechaFinaliza,
            "Tema": nuevoInstructoresFormacionCursos.Tema,
            "Duracion":nuevoInstructoresFormacionCursos.Duracion,
            "Observaciones": nuevoInstructoresFormacionCursos.Observaciones,
            "FechaAlta": nuevoInstructoresFormacionCursos.FechaAlta,
            "Calificacion":nuevoInstructoresFormacionCursos.Calificacion,
            "IdCursoObtenido":nuevoInstructoresFormacionCursos.IdCursoObtenido,
            "Notas":nuevoInstructoresFormacionCursos.Notas,
            "IdAreaInteres":nuevoInstructoresFormacionCursos.IdAreaInteres
           ]
        
           AF.request(webService.getBaseURL() + "/api/InstructoresFormacionCursos", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: InstructoresFormacionCursos.self) { response in
                   switch response.result {
                   case .success(let instructoresFormacionCursos):
                       completion(.success(instructoresFormacionCursos))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


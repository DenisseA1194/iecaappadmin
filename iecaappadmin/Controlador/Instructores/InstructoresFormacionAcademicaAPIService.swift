//
//  File13.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class InstructoresFormacionAcademicaAPIService {
  
    private let webService = WebService()
    static let shared = InstructoresFormacionAcademicaAPIService()
    
    func editarInstructoresFormacionAcademica(instructoresFormacionAcademica: InstructoresFormacionAcademica, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/InstructoresFormacionAcademica/\(instructoresFormacionAcademica.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdEmpresa": instructoresFormacionAcademica.IdEmpresa,
            "IdInstructor":instructoresFormacionAcademica.IdInstructor,
            "IdInstitucion": instructoresFormacionAcademica.IdInstitucion,
            "FechaInicio": formattedDate,
            "FechaFinaliza": formattedDate,
            "Tema": instructoresFormacionAcademica.Tema,
            "Duracion":instructoresFormacionAcademica.Duracion,
            "Observaciones": instructoresFormacionAcademica.Observaciones,
            "FechaAlta": formattedDate,
            "Calificacion":instructoresFormacionAcademica.Calificacion,
            "IdTituloObtenido":instructoresFormacionAcademica.IdTituloObtenido,
            "Notas":instructoresFormacionAcademica.Notas,
            "IdAreaInteres":instructoresFormacionAcademica.IdAreaInteres
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

    
    func eliminarInstructoresFormacionAcademica(idInstructoresFormacionAcademica: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/InstructoresFormacionAcademica/\(idInstructoresFormacionAcademica)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchInstructoresFormacionAcademica(completion: @escaping (Result<[InstructoresFormacionAcademica], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/InstructoresFormacionAcademica?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [InstructoresFormacionAcademica].self) { response in
                    switch response.result {
                    case .success(let instructoresFormacionAcademica):
                        completion(.success(instructoresFormacionAcademica))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarInstructoresFormacionAcademica(nuevoInstructoresFormacionAcademica: InstructoresFormacionAcademica, completion: @escaping (Result<InstructoresFormacionAcademica, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdEmpresa": nuevoInstructoresFormacionAcademica.IdEmpresa,
            "IdInstructor":nuevoInstructoresFormacionAcademica.IdInstructor,
            "IdInstitucion": nuevoInstructoresFormacionAcademica.IdInstitucion,
            "FechaInicio": nuevoInstructoresFormacionAcademica.FechaInicio,
            "FechaFinaliza": nuevoInstructoresFormacionAcademica.FechaFinaliza,
            "Tema": nuevoInstructoresFormacionAcademica.Tema,
            "Duracion":nuevoInstructoresFormacionAcademica.Duracion,
            "Observaciones": nuevoInstructoresFormacionAcademica.Observaciones,
            "FechaAlta": nuevoInstructoresFormacionAcademica.FechaAlta,
            "Calificacion":nuevoInstructoresFormacionAcademica.Calificacion,
            "IdTituloObtenido":nuevoInstructoresFormacionAcademica.IdTituloObtenido,
            "Notas":nuevoInstructoresFormacionAcademica.Notas,
            "IdAreaInteres":nuevoInstructoresFormacionAcademica.IdAreaInteres
           ]
        
           AF.request(webService.getBaseURL() + "/api/InstructoresFormacionAcademica", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: InstructoresFormacionAcademica.self) { response in
                   switch response.result {
                   case .success(let instructoresFormacionAcademica):
                       completion(.success(instructoresFormacionAcademica))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


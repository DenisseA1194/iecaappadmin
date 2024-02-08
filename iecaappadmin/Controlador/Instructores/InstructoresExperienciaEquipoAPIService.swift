//
//  File12.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class InstructoresExperienciaEquipoAPIService {
  
    private let webService = WebService()
        static let shared = InstructoresExperienciaEquipoAPIService()
    
    func editarInstructoresExperienciaEquipo(instructoresExperienciaEquipo: InstructoresExperienciaEquipo, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/InstructoresExperienciaEquipo/\(instructoresExperienciaEquipo.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdEmpresa":instructoresExperienciaEquipo.IdEmpresa,
            "IdInstructor": instructoresExperienciaEquipo.IdInstructor,
            "FechaAlta": formattedDate,
            "Notas": instructoresExperienciaEquipo.Notas,
            "Experiencia": instructoresExperienciaEquipo.Experiencia,
            "IdEquipoHerramienta": instructoresExperienciaEquipo.IdEquipoHerramienta
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

    
    func eliminarInstructoresExperienciaEquipo(idInstructoresExperienciaEquipo: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/InstructoresExperienciaEquipo/\(idInstructoresExperienciaEquipo)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchInstructoresExperienciaEquipo(completion: @escaping (Result<[InstructoresExperienciaEquipo], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/InstructoresExperienciaEquipo?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [InstructoresExperienciaEquipo].self) { response in
                    switch response.result {
                    case .success(let instructoresExperienciaEquipo):
                        completion(.success(instructoresExperienciaEquipo))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarInstructoresExperienciaEquipo(nuevoInstructoresExperienciaEquipo: InstructoresExperienciaEquipo, completion: @escaping (Result<InstructoresExperienciaEquipo, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdEmpresa":nuevoInstructoresExperienciaEquipo.IdEmpresa,
            "IdInstructor": nuevoInstructoresExperienciaEquipo.IdInstructor,
            "FechaAlta": nuevoInstructoresExperienciaEquipo.FechaAlta,
            "Notas": nuevoInstructoresExperienciaEquipo.Notas,
            "Experiencia": nuevoInstructoresExperienciaEquipo.Experiencia,
            "IdEquipoHerramienta": nuevoInstructoresExperienciaEquipo.IdEquipoHerramienta
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/InstructoresExperienciaEquipo", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: InstructoresExperienciaEquipo.self) { response in
                   switch response.result {
                   case .success(let instructoresExperienciaEquipo):
                       completion(.success(instructoresExperienciaEquipo))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


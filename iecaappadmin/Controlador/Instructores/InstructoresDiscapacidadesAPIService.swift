//
//  File6.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class InstructoresDiscapacidadesAPIService {
  
    private let webService = WebService()
        static let shared = InstructoresDiscapacidadesAPIService()
    
    func editarInstructoresDiscapacidades(instructoresDiscapacidades: InstructoresDiscapacidades, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/InstructoresDiscapacidades/\(instructoresDiscapacidades.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdEmpresa":instructoresDiscapacidades.IdEmpresa,
            "Fecha": formattedDate,
            "IdInstructor": instructoresDiscapacidades.IdInstructor,
            "IdDiscapacidad": instructoresDiscapacidades.IdDiscapacidad,
            "Notas": instructoresDiscapacidades.Notas,
            "FechaDeteccion": formattedDate
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

    
    func eliminarInstructoresDiscapacidades(idInstructoresDiscapacidades: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/InstructoresDiscapacidades/\(idInstructoresDiscapacidades)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchInstructoresDiscapacidades(completion: @escaping (Result<[InstructoresDiscapacidades], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/InstructoresDiscapacidades?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [InstructoresDiscapacidades].self) { response in
                    switch response.result {
                    case .success(let instructoresDiscapacidades):
                        completion(.success(instructoresDiscapacidades))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarInstructoresDiscapacidades(nuevoInstructoresDiscapacidades: InstructoresDiscapacidades, completion: @escaping (Result<InstructoresDiscapacidades, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdEmpresa":nuevoInstructoresDiscapacidades.IdEmpresa,
            "Fecha": nuevoInstructoresDiscapacidades.Fecha,
            "IdInstructor": nuevoInstructoresDiscapacidades.IdInstructor,
            "IdDiscapacidad": nuevoInstructoresDiscapacidades.IdDiscapacidad,
            "Notas": nuevoInstructoresDiscapacidades.Notas,
            "FechaDeteccion": nuevoInstructoresDiscapacidades.FechaDeteccion
           ]
        
           AF.request(webService.getBaseURL() + "/api/InstructoresDiscapacidades", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: InstructoresDiscapacidades.self) { response in
                   switch response.result {
                   case .success(let instructoresDiscapacidades):
                       completion(.success(instructoresDiscapacidades))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


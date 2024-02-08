//
//  File7.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class InstructoresDocumentacionAPIService {
  
    private let webService = WebService()
        static let shared = InstructoresDocumentacionAPIService()
    
    func editarInstructoresDocumentacion(instructoresDocumentacion: InstructoresDocumentacion, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/InstructoresDocumentacion/\(instructoresDocumentacion.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdInstructor": instructoresDocumentacion.IdInstructor,
            "IdEmpresa":instructoresDocumentacion.IdEmpresa,
            "IdTipoDocumento": instructoresDocumentacion.IdTipoDocumento,
            "Emision": formattedDate,
            "Vence": formattedDate,
            "Vigente": instructoresDocumentacion.Vigente,
            "Comentarios": instructoresDocumentacion.Comentarios,
            "FechaAlta": formattedDate,
            "Link":instructoresDocumentacion.Link,
            "Notas":instructoresDocumentacion.Notas
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

    
    func eliminarInstructoresDocumentacion(idInstructoresDocumentacion: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/InstructoresDocumentacion/\(idInstructoresDocumentacion)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchInstructoresDocumentacion(completion: @escaping (Result<[InstructoresDocumentacion], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/InstructoresDocumentacion?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [InstructoresDocumentacion].self) { response in
                    switch response.result {
                    case .success(let instructoresDocumentacion):
                        completion(.success(instructoresDocumentacion))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarInstructoresDocumentacion(nuevoInstructoresDocumentacion: InstructoresDocumentacion, completion: @escaping (Result<InstructoresDocumentacion, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdInstructor": nuevoInstructoresDocumentacion.IdInstructor,
            "IdEmpresa":nuevoInstructoresDocumentacion.IdEmpresa,
            "IdTipoDocumento": nuevoInstructoresDocumentacion.IdTipoDocumento,
            "Emision": nuevoInstructoresDocumentacion.Emision,
            "Vence": nuevoInstructoresDocumentacion.Vence,
            "Vigente": nuevoInstructoresDocumentacion.Vigente,
            "Comentarios": nuevoInstructoresDocumentacion.Comentarios,
            "FechaAlta": nuevoInstructoresDocumentacion.FechaAlta,
            "Link":nuevoInstructoresDocumentacion.Link,
            "Notas":nuevoInstructoresDocumentacion.Notas
           ]
        
           AF.request(webService.getBaseURL() + "/api/InstructoresDocumentacion", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: InstructoresDocumentacion.self) { response in
                   switch response.result {
                   case .success(let instructoresDocumentacion):
                       completion(.success(instructoresDocumentacion))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


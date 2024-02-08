//
//  File17.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class InstructoresRedesSocialesAPIService {
  
    private let webService = WebService()
        static let shared = InstructoresRedesSocialesAPIService()
    
    func editarInstructoresRedesSociales(instructoresRedesSociales: InstructoresRedesSociales, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/InstructoresRedesSociales/\(instructoresRedesSociales.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdEmpresa": instructoresRedesSociales.IdEmpresa,
            "IdInstructor":instructoresRedesSociales.IdInstructor,
            "FechaAlta": formattedDate,
            "Notas": instructoresRedesSociales.Notas,
            "IdRedSocial": instructoresRedesSociales.IdRedSocial
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

    
    func eliminarInstructoresRedesSociales(idInstructoresRedesSociales: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/InstructoresRedesSociales/\(idInstructoresRedesSociales)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchInstructoresRedesSociales(completion: @escaping (Result<[InstructoresRedesSociales], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/InstructoresRedesSociales?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [InstructoresRedesSociales].self) { response in
                    switch response.result {
                    case .success(let instructoresRedesSociales):
                        completion(.success(instructoresRedesSociales))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarInstructoresRedesSociales(nuevoInstructoresRedesSociales: InstructoresRedesSociales, completion: @escaping (Result<InstructoresRedesSociales, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdEmpresa": nuevoInstructoresRedesSociales.IdEmpresa,
            "IdInstructor":nuevoInstructoresRedesSociales.IdInstructor,
            "FechaAlta": nuevoInstructoresRedesSociales.FechaAlta,
            "Notas": nuevoInstructoresRedesSociales.Notas,
            "IdRedSocial": nuevoInstructoresRedesSociales.IdRedSocial
           ]
        
           AF.request(webService.getBaseURL() + "/api/InstructoresRedesSociales", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: InstructoresRedesSociales.self) { response in
                   switch response.result {
                   case .success(let instructoresRedesSociales):
                       completion(.success(instructoresRedesSociales))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


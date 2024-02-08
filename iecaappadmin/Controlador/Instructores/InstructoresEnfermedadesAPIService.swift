//
//  File9.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class InstructoresEnfermedadesAPIService {
  
    private let webService = WebService()
        static let shared = InstructoresEnfermedadesAPIService()
    
    func editarInstructoresEnfermedades(instructoresEnfermedades: InstructoresEnfermedades, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/InstructoresEnfermedades/\(instructoresEnfermedades.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdEmpresa": instructoresEnfermedades.IdEmpresa,
            "Fecha": formattedDate,
            "IdInstructor":instructoresEnfermedades.IdInstructor,
            "IdEnfermedad": instructoresEnfermedades.IdEnfermedad,
            "FechaDeteccion": formattedDate,
            "Notas": instructoresEnfermedades.Notas
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

    
    func eliminarInstructoresEnfermedades(idInstructoresEnfermedades: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/InstructoresEnfermedades/\(idInstructoresEnfermedades)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchInstructoresEnfermedades(completion: @escaping (Result<[InstructoresEnfermedades], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/InstructoresEnfermedades?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [InstructoresEnfermedades].self) { response in
                    switch response.result {
                    case .success(let instructoresEnfermedades):
                        completion(.success(instructoresEnfermedades))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarInstructoresEnfermedades(nuevoInstructoresEnfermedades: InstructoresEnfermedades, completion: @escaping (Result<InstructoresEnfermedades, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdEmpresa": nuevoInstructoresEnfermedades.IdEmpresa,
            "Fecha": nuevoInstructoresEnfermedades.Fecha,
            "IdInstructor":nuevoInstructoresEnfermedades.IdInstructor,
            "IdEnfermedad": nuevoInstructoresEnfermedades.IdEnfermedad,
            "FechaDeteccion": nuevoInstructoresEnfermedades.FechaDeteccion,
            "Notas": nuevoInstructoresEnfermedades.Notas
           ]
        
           AF.request(webService.getBaseURL() + "/api/InstructoresEnfermedades", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: InstructoresEnfermedades.self) { response in
                   switch response.result {
                   case .success(let instructoresEnfermedades):
                       completion(.success(instructoresEnfermedades))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


//
//  File18.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class InstructoresSeguroMedicoAPIService {
  
    private let webService = WebService()
        static let shared = InstructoresSeguroMedicoAPIService()
    
    func editarInstructoresSeguroMedico(instructoresSeguroMedico: InstructoresSeguroMedico, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/InstructoresSeguroMedico/\(instructoresSeguroMedico.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Fecha": formattedDate,
            "IdInstructor": instructoresSeguroMedico.IdInstructor,
            "IdSeguroMedico":instructoresSeguroMedico.IdSeguroMedico,
            "FechaIngreso": formattedDate,
            "Notas": instructoresSeguroMedico.Notas,
            "FechaVencimiento": formattedDate,
            "NumeroAfiliacionPoliza": instructoresSeguroMedico.NumeroAfiliacionPoliza,
            "IdEmpresa": instructoresSeguroMedico.IdEmpresa
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

    
    func eliminarInstructoresSeguroMedico(idInstructoresSeguroMedico: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/InstructoresSeguroMedico/\(idInstructoresSeguroMedico)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchInstructoresSeguroMedico(completion: @escaping (Result<[InstructoresSeguroMedico], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/InstructoresSeguroMedico?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [InstructoresSeguroMedico].self) { response in
                    switch response.result {
                    case .success(let instructoresSeguroMedico):
                        completion(.success(instructoresSeguroMedico))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarInstructoresSeguroMedico(nuevoInstructoresSeguroMedico: InstructoresSeguroMedico, completion: @escaping (Result<InstructoresSeguroMedico, Error>) -> Void) {
           let parameters: [String: Any] = [
            "Fecha": nuevoInstructoresSeguroMedico.Fecha,
            "IdInstructor": nuevoInstructoresSeguroMedico.IdInstructor,
            "IdSeguroMedico":nuevoInstructoresSeguroMedico.IdSeguroMedico,
            "FechaIngreso": nuevoInstructoresSeguroMedico.FechaIngreso,
            "Notas": nuevoInstructoresSeguroMedico.Notas,
            "FechaVencimiento": nuevoInstructoresSeguroMedico.FechaVencimiento,
            "NumeroAfiliacionPoliza": nuevoInstructoresSeguroMedico.NumeroAfiliacionPoliza,
            "IdEmpresa": nuevoInstructoresSeguroMedico.IdEmpresa
           ]
        
           AF.request(webService.getBaseURL() + "/api/InstructoresSeguroMedico", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: InstructoresSeguroMedico.self) { response in
                   switch response.result {
                   case .success(let instructoresSeguroMedico):
                       completion(.success(instructoresSeguroMedico))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


//
//  File2.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class InstructoresContactosAPIService {
  
    private let webService = WebService()
    static let shared = InstructoresContactosAPIService()
    
    func editarInstructoresContactos(instructoresContactos: InstructoresContactos, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/InstructoresContactos/\(instructoresContactos.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdInstructor": instructoresContactos.IdInstructor,
            "IdEmpresa":instructoresContactos.IdEmpresa,
            "NombreCompleto": instructoresContactos.NombreCompleto,
            "Telefono": instructoresContactos.Telefono,
            "Correo": instructoresContactos.Correo,
            "Relacion": instructoresContactos.Relacion,
            "Observaciones":instructoresContactos.Observaciones,
            "Edad":instructoresContactos.Edad,
            "Ocupacion":instructoresContactos.Ocupacion,
            "Notas":instructoresContactos.Notas,
            "Direccion":instructoresContactos.Direccion,
            "FechaAlta": formattedDate
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

    
    func eliminarInstructoresContactos(idInstructoresContactos: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/InstructoresContactos/\(idInstructoresContactos)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchInstructoresContactos(completion: @escaping (Result<[InstructoresContactos], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/InstructoresContactos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [InstructoresContactos].self) { response in
                    switch response.result {
                    case .success(let instructoresContactos):
                        completion(.success(instructoresContactos))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarInstructoresContactos(nuevoInstructoresContactos: InstructoresContactos, completion: @escaping (Result<InstructoresContactos, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdInstructor": nuevoInstructoresContactos.IdInstructor,
            "IdEmpresa":nuevoInstructoresContactos.IdEmpresa,
            "NombreCompleto": nuevoInstructoresContactos.NombreCompleto,
            "Telefono": nuevoInstructoresContactos.Telefono,
            "Correo": nuevoInstructoresContactos.Correo,
            "Relacion": nuevoInstructoresContactos.Relacion,
            "Observaciones":nuevoInstructoresContactos.Observaciones,
            "Edad":nuevoInstructoresContactos.Edad,
            "Ocupacion":nuevoInstructoresContactos.Ocupacion,
            "Notas":nuevoInstructoresContactos.Notas,
            "Direccion":nuevoInstructoresContactos.Direccion,
            "FechaAlta": nuevoInstructoresContactos.FechaAlta
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/InstructoresContactos", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: InstructoresContactos.self) { response in
                   switch response.result {
                   case .success(let instructoresContactos):
                       completion(.success(instructoresContactos))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


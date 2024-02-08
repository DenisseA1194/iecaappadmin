//
//  File16.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class InstructoresPerfilAPIService {
  
    private let webService = WebService()
        static let shared = InstructoresPerfilAPIService()
    
    func editarInstructoresPerfil(instructoresPerfil: InstructoresPerfil, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/InstructoresPerfil/\(instructoresPerfil.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Fecha": formattedDate,
            "IdInstructor": instructoresPerfil.IdInstructor,
            "IdSucursal":instructoresPerfil.IdSucursal,
            "IdTipoContrato": instructoresPerfil.IdTipoContrato,
            "DisponibilidadDesplazarse": instructoresPerfil.DisponibilidadDesplazarse,
            "IdEmpresa": instructoresPerfil.IdEmpresa
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

    
    func eliminarInstructoresPerfil(idInstructoresPerfil: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/InstructoresPerfil/\(idInstructoresPerfil)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchInstructoresPerfil(completion: @escaping (Result<[InstructoresPerfil], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/InstructoresPerfil?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [InstructoresPerfil].self) { response in
                    switch response.result {
                    case .success(let instructoresPerfil):
                        completion(.success(instructoresPerfil))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarInstructoresPerfil(nuevoInstructoresPerfil: InstructoresPerfil, completion: @escaping (Result<InstructoresPerfil, Error>) -> Void) {
           let parameters: [String: Any] = [
            "Fecha": nuevoInstructoresPerfil.Fecha,
            "IdInstructor": nuevoInstructoresPerfil.IdInstructor,
            "IdSucursal":nuevoInstructoresPerfil.IdSucursal,
            "IdTipoContrato": nuevoInstructoresPerfil.IdTipoContrato,
            "DisponibilidadDesplazarse": nuevoInstructoresPerfil.DisponibilidadDesplazarse,
            "IdEmpresa": nuevoInstructoresPerfil.IdEmpresa
           ]
        
           AF.request(webService.getBaseURL() + "/api/InstructoresPerfil", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: InstructoresPerfil.self) { response in
                   switch response.result {
                   case .success(let instructoresPerfil):
                       completion(.success(instructoresPerfil))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


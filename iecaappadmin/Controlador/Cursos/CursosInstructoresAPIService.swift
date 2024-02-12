//
//  CursosInstructores.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire



class CursosInstructoresAPIService {
  
    private let webService = WebService()
        static let shared = CursosInstructoresAPIService()
    
    func editarCursosInstructores(cursosInstructores: CursosInstructores, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CursosInstructores/\(cursosInstructores.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Fecha": formattedDate,
            "IdEmpresa": cursosInstructores.IdEmpresa,
            "IdCurso":cursosInstructores.IdCurso,
            "IdInstructor": cursosInstructores.IdInstructor,
            "IdModalidad": cursosInstructores.IdModalidad,
            "IdTipoPlataforma": cursosInstructores.IdTipoPlataforma,
            "Observaciones":cursosInstructores.Observaciones,
            "Notas": cursosInstructores.Notas,
            "CodigoCliente": cursosInstructores.CodigoCliente,
            "Status": cursosInstructores.Status,
            "FechaInicio": formattedDate,
            "FechaFinaliza": formattedDate
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

    
    func eliminarCursosInstructores(idCursosInstructores: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CursosInstructores/\(idCursosInstructores)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCursosInstructores(completion: @escaping (Result<[CursosInstructores], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CursosInstructores?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CursosInstructores].self) { response in
                    switch response.result {
                    case .success(let cursosInstructores):
                        completion(.success(cursosInstructores))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCursosInstructores(nuevoCursosInstructores: CursosInstructores, completion: @escaping (Result<CursosInstructores, Error>) -> Void) {
           let parameters: [String: Any] = [
            "Fecha": nuevoCursosInstructores.Fecha,
            "IdEmpresa": nuevoCursosInstructores.IdEmpresa,
            "IdCurso":nuevoCursosInstructores.IdCurso,
            "IdInstructor": nuevoCursosInstructores.IdInstructor,
            "IdModalidad": nuevoCursosInstructores.IdModalidad,
            "IdTipoPlataforma": nuevoCursosInstructores.IdTipoPlataforma,
            "Observaciones":nuevoCursosInstructores.Observaciones,
            "Notas": nuevoCursosInstructores.Notas,
            "CodigoCliente": nuevoCursosInstructores.CodigoCliente,
            "Status": nuevoCursosInstructores.Status,
            "FechaInicio": nuevoCursosInstructores.FechaInicio,
            "FechaFinaliza": nuevoCursosInstructores.FechaFinaliza
           ]
        
           AF.request(webService.getBaseURL() + "/api/CursosInstructores", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CursosInstructores.self) { response in
                   switch response.result {
                   case .success(let cursosInstructores):
                       completion(.success(cursosInstructores))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}



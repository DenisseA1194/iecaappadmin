//
//  CatalogoInstructoresStatus.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire

class CatalogoInstructoresStatusAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoInstructoresStatusAPIService()
    
    func editarCatalogoInstructoresStatus(catalogoInstructoresStatus: CatalogoInstructoresStatus, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoInstructoresStatus/\(catalogoInstructoresStatus.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoInstructoresStatus.Nombre,
            "Notas": catalogoInstructoresStatus.Notas,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoInstructoresStatus.IdEmpresa
            
         
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

    
    func eliminarCatalogoInstructoresStatus(idCatalogoInstructoresStatus: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoInstructoresStatus/\(idCatalogoInstructoresStatus)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoInstructoresStatus(completion: @escaping (Result<[CatalogoInstructoresStatus], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoInstructoresStatus?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoInstructoresStatus].self) { response in
                    switch response.result {
                    case .success(let catalogoInstructoresStatus):
                        completion(.success(catalogoInstructoresStatus))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoInstructoresStatus(nuevoCatalogoInstructoresStatus: CatalogoInstructoresStatus, completion: @escaping (Result<CatalogoInstructoresStatus, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoInstructoresStatus.Nombre,
               "Notas": nuevoCatalogoInstructoresStatus.Notas,
               "Fecha":nuevoCatalogoInstructoresStatus.Fecha,
               "IdEmpresa":nuevoCatalogoInstructoresStatus.IdEmpresa
             
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoInstructoresStatus", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoInstructoresStatus.self) { response in
                   switch response.result {
                   case .success(let catalogoInstructoresStatus):
                       completion(.success(catalogoInstructoresStatus))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


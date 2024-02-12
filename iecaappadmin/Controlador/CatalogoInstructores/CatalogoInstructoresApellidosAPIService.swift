//
//  CatalogoInstructoresApellidosAPIService.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire

class CatalogoInstructoresApellidosAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoInstructoresApellidosAPIService()
    
    func editarCatalogoInstructoresApellidos(catalogoInstructoresApellidos: CatalogoInstructoresApellidos, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoInstructoresApellidos/\(catalogoInstructoresApellidos.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Apellido": catalogoInstructoresApellidos.Apellido,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoInstructoresApellidos.IdEmpresa
            
         
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

    
    func eliminarCatalogoInstructoresApellidos(idCatalogoInstructoresApellidos: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoInstructoresApellidos/\(idCatalogoInstructoresApellidos)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoInstructoresApellidos(completion: @escaping (Result<[CatalogoInstructoresApellidos], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoInstructoresApellidos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoInstructoresApellidos].self) { response in
                    switch response.result {
                    case .success(let catalogoInstructoresApellidos):
                        completion(.success(catalogoInstructoresApellidos))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoInstructoresApellidos(nuevoCatalogoInstructoresApellidos: CatalogoInstructoresApellidos, completion: @escaping (Result<CatalogoInstructoresApellidos, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Apellido": nuevoCatalogoInstructoresApellidos.Apellido,
               "Fecha":nuevoCatalogoInstructoresApellidos.Fecha,
               "IdEmpresa":nuevoCatalogoInstructoresApellidos.IdEmpresa
             
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoInstructoresApellidos", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoInstructoresApellidos.self) { response in
                   switch response.result {
                   case .success(let catalogoInstructoresApellidos):
                       completion(.success(catalogoInstructoresApellidos))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

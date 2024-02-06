//
//  CatalogoInstructoresApellidosAPIService.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire

class CatalogoInstructoresApellidosAPIService {
  
    private let baseURL = "http://webservices.iecapp.com"
    static let shared = CatalogoInstructoresApellidosAPIService()
    
    func editarCatalogoInstructoresApellidos(catalogoInstructoresApellidos: CatalogoInstructoresApellidos, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/CatalogoInstructoresApellidos/\(catalogoInstructoresApellidos.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        let parameters: [String: Any] = [
            "Apellido": catalogoInstructoresApellidos.Apellido,
            "IdEmpresa":catalogoInstructoresApellidos.IdEmpresa,
            "Fecha":"2024-01-30T19:06:05.675Z",
            
         
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
           let url = baseURL + "/api/CatalogoInstructoresApellidos/\(idCatalogoInstructoresApellidos)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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
            AF.request(baseURL+"/api/CatalogoInstructoresApellidos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoInstructoresApellidos].self) { response in
                    switch response.result {
                    case .success(let sucursales):
                        completion(.success(sucursales))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoInstructoresApellidos(nuevoCatalogoInstructoresApellidos: CatalogoInstructoresApellidos, completion: @escaping (Result<CatalogoInstructoresApellidos, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Apellido": nuevoCatalogoInstructoresApellidos.Apellido,
               "IdEmpresa":nuevoCatalogoInstructoresApellidos.IdEmpresa,
               "Fecha":nuevoCatalogoInstructoresApellidos.Fecha
             
              
           ]
        
           AF.request(baseURL + "/api/CatalogoInstructoresApellidos", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoInstructoresApellidos.self) { response in
                   switch response.result {
                   case .success(let sucursal):
                       completion(.success(sucursal))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

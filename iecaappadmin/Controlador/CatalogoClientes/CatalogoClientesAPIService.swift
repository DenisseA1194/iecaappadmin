//
//  CatalogoClientes.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoClientesAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoClientesAPIService()
    
    func editarCatalogoClientes(catalogoClientes: CatalogoClientes, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoClientes/\(catalogoClientes.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoClientes.Nombre,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoClientes.IdEmpresa
            
         
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

    
    func eliminarCatalogoClientes(idCatalogoClientes: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoClientes/\(idCatalogoClientes)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoClientes(completion: @escaping (Result<[CatalogoClientes], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoClientes?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoClientes].self) { response in
                    switch response.result {
                    case .success(let catalogoClientes):
                        completion(.success(catalogoClientes))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoClientes(nuevoCatalogoClientes: CatalogoClientes, completion: @escaping (Result<CatalogoClientes, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoClientes.Nombre,
               "Fecha":nuevoCatalogoClientes.Fecha,
               "IdEmpresa":nuevoCatalogoClientes.IdEmpresa
             
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoClientes", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoClientes.self) { response in
                   switch response.result {
                   case .success(let catalogoClientes):
                       completion(.success(catalogoClientes))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


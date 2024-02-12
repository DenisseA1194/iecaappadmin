//
//  CatalogoClientesApellidos.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoClientesApellidosAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoClientesApellidosAPIService()
    
    func editarCatalogoClientesApellidos(catalogoClientesApellidos: CatalogoClientesApellidos, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoClientesApellidos/\(catalogoClientesApellidos.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Apellido": catalogoClientesApellidos.Apellido,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoClientesApellidos.IdEmpresa
            
         
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

    
    func eliminarCatalogoClientesApellidos(idCatalogoClientesApellidos: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoClientesApellidos/\(idCatalogoClientesApellidos)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoClientesApellidos(completion: @escaping (Result<[CatalogoClientesApellidos], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoClientesApellidos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoClientesApellidos].self) { response in
                    switch response.result {
                    case .success(let catalogoClientesApellidos):
                        completion(.success(catalogoClientesApellidos))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoClientesApellidos(nuevoCatalogoClientesApellidos: CatalogoClientesApellidos, completion: @escaping (Result<CatalogoClientesApellidos, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Apellido": nuevoCatalogoClientesApellidos.Apellido,
               "Fecha":nuevoCatalogoClientesApellidos.Fecha,
               "IdEmpresa":nuevoCatalogoClientesApellidos.IdEmpresa
             
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoClientesApellidos", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoClientesApellidos.self) { response in
                   switch response.result {
                   case .success(let catalogoClientesApellidos):
                       completion(.success(catalogoClientesApellidos))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}



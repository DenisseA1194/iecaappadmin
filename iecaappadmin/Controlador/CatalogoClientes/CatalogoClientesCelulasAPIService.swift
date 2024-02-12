//
//  CatalogoClientesCelulas.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoClientesCelulasAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoClientesCelulasAPIService()
    
    func editarCatalogoClientesCelulas(catalogoClientesCelulas: CatalogoClientesCelulas, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoClientesCelulas/\(catalogoClientesCelulas.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoClientesCelulas.Nombre,
            "Fecha": formattedDate,
            "IdSupervisor":catalogoClientesCelulas.IdSupervisor,
            "IdEmpresa":catalogoClientesCelulas.IdEmpresa
            
         
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

    
    func eliminarCatalogoClientesCelulas(idCatalogoClientesCelulas: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoClientesCelulas/\(idCatalogoClientesCelulas)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoClientesCelulas(completion: @escaping (Result<[CatalogoClientesCelulas], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoClientesCelulas?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoClientesCelulas].self) { response in
                    switch response.result {
                    case .success(let catalogoClientesCelulas):
                        completion(.success(catalogoClientesCelulas))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoClientesCelulas(nuevoCatalogoClientesCelulas: CatalogoClientesCelulas, completion: @escaping (Result<CatalogoClientesCelulas, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoClientesCelulas.Nombre,
               "Fecha":nuevoCatalogoClientesCelulas.Fecha,
               "IdSupervisor": nuevoCatalogoClientesCelulas.IdSupervisor,
               "IdEmpresa":nuevoCatalogoClientesCelulas.IdEmpresa
             
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoClientesCelulas", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoClientesCelulas.self) { response in
                   switch response.result {
                   case .success(let catalogoClientesCelulas):
                       completion(.success(catalogoClientesCelulas))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}



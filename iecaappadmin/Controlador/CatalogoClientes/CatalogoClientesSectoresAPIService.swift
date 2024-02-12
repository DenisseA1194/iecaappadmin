//
//  CatalogoClientesSectores.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoClientesSectoresAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoClientesSectoresAPIService()
    
    func editarCatalogoClientesSectores(catalogoClientesSectores: CatalogoClientesSectores, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoClientesSectores/\(catalogoClientesSectores.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoClientesSectores.Nombre,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoClientesSectores.IdEmpresa
            
         
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

    
    func eliminarCatalogoClientesSectores(idCatalogoClientesSectores: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoClientesSectores/\(idCatalogoClientesSectores)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoClientesSectores(completion: @escaping (Result<[CatalogoClientesSectores], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoClientesSectores?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoClientesSectores].self) { response in
                    switch response.result {
                    case .success(let catalogoClientesSectores):
                        completion(.success(catalogoClientesSectores))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoClientesSectores(nuevoCatalogoClientesSectores: CatalogoClientesSectores, completion: @escaping (Result<CatalogoClientesSectores, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoClientesSectores.Nombre,
               "Fecha":nuevoCatalogoClientesSectores.Fecha,
               "IdEmpresa":nuevoCatalogoClientesSectores.IdEmpresa
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoClientesSectores", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoClientesSectores.self) { response in
                   switch response.result {
                   case .success(let catalogoClientesSectores):
                       completion(.success(catalogoClientesSectores))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

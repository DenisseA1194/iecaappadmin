//
//  CatalogoClientesClasificaciones.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoClientesClasificacionesAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoClientesClasificacionesAPIService()
    
    func editarCatalogoClientesClasificaciones(catalogoClientesClasificaciones: CatalogoClientesClasificaciones, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoClientesClasificaciones/\(catalogoClientesClasificaciones.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoClientesClasificaciones.Nombre,
            "Fecha": formattedDate,
            "IdSupervisor": catalogoClientesClasificaciones.IdSupervisor,
            "IdEmpresa":catalogoClientesClasificaciones.IdEmpresa
            
         
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

    
    func eliminarCatalogoClientesClasificaciones(idCatalogoClientesClasificaciones: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoClientesClasificaciones/\(idCatalogoClientesClasificaciones)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoClientesClasificaciones(completion: @escaping (Result<[CatalogoClientesClasificaciones], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoClientesClasificaciones?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoClientesClasificaciones].self) { response in
                    switch response.result {
                    case .success(let catalogoClientesClasificaciones):
                        completion(.success(catalogoClientesClasificaciones))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoClientesClasificaciones(nuevoCatalogoClientesClasificaciones: CatalogoClientesClasificaciones, completion: @escaping (Result<CatalogoClientesClasificaciones, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoClientesClasificaciones.Nombre,
               "Fecha":nuevoCatalogoClientesClasificaciones.Fecha,
               "IdSupervisor": nuevoCatalogoClientesClasificaciones.IdSupervisor,
               "IdEmpresa":nuevoCatalogoClientesClasificaciones.IdEmpresa
             
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoClientesClasificaciones", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoClientesClasificaciones.self) { response in
                   switch response.result {
                   case .success(let catalogoClientesClasificaciones):
                       completion(.success(catalogoClientesClasificaciones))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}



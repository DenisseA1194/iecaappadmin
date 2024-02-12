//
//  CatalogoClientesDetalles.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoClientesDetallesAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoClientesDetallesAPIService()
    
    func editarCatalogoClientesDetalles(catalogoClientesDetalles: CatalogoClientesDetalles, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoClientesDetalles/\(catalogoClientesDetalles.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoClientesDetalles.Nombre,
            "Fecha": formattedDate,
            "IdCatalogoCliente":catalogoClientesDetalles.IdCatalogoCliente,
            "IdEmpresa":catalogoClientesDetalles.IdEmpresa
            
         
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

    
    func eliminarCatalogoClientesDetalles(idCatalogoClientesDetalles: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoClientesDetalles/\(idCatalogoClientesDetalles)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoClientesDetalles(completion: @escaping (Result<[CatalogoClientesDetalles], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoClientesDetalles?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoClientesDetalles].self) { response in
                    switch response.result {
                    case .success(let catalogoClientesDetalles):
                        completion(.success(catalogoClientesDetalles))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoClientesDetalles(nuevoCatalogoClientesDetalles: CatalogoClientesDetalles, completion: @escaping (Result<CatalogoClientesDetalles, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoClientesDetalles.Nombre,
               "Fecha":nuevoCatalogoClientesDetalles.Fecha,
               "IdCatalogoCliente":nuevoCatalogoClientesDetalles.IdCatalogoCliente,
               "IdEmpresa":nuevoCatalogoClientesDetalles.IdEmpresa
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoClientesDetalles", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoClientesDetalles.self) { response in
                   switch response.result {
                   case .success(let catalogoClientesDetalles):
                       completion(.success(catalogoClientesDetalles))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}



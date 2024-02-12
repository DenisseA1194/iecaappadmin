//
//  CatalogoClientesOcupaciones.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoClientesOcupacionesAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoClientesOcupacionesAPIService()
    
    func editarCatalogoClientesOcupaciones(catalogoClientesOcupaciones: CatalogoClientesOcupaciones, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoClientesOcupaciones/\(catalogoClientesOcupaciones.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoClientesOcupaciones.Nombre,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoClientesOcupaciones.IdEmpresa
            
         
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

    
    func eliminarCatalogoClientesOcupaciones(idCatalogoClientesOcupaciones: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoClientesOcupaciones/\(idCatalogoClientesOcupaciones)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoClientesOcupaciones(completion: @escaping (Result<[CatalogoClientesOcupaciones], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoClientesOcupaciones?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoClientesOcupaciones].self) { response in
                    switch response.result {
                    case .success(let catalogoClientesOcupaciones):
                        completion(.success(catalogoClientesOcupaciones))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoClientesOcupaciones(nuevoCatalogoClientesOcupaciones: CatalogoClientesOcupaciones, completion: @escaping (Result<CatalogoClientesOcupaciones, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoClientesOcupaciones.Nombre,
               "Fecha":nuevoCatalogoClientesOcupaciones.Fecha,
               "IdEmpresa":nuevoCatalogoClientesOcupaciones.IdEmpresa
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoClientesOcupaciones", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoClientesOcupaciones.self) { response in
                   switch response.result {
                   case .success(let catalogoClientesOcupaciones):
                       completion(.success(catalogoClientesOcupaciones))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

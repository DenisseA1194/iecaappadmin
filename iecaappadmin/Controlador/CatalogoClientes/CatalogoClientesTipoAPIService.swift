//
//  CatalogoClientesTipo.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoClientesTipoAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoClientesTipoAPIService()
    
    func editarCatalogoClientesTipo(catalogoClientesTipo: CatalogoClientesTipo, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoClientesTipo/\(catalogoClientesTipo.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoClientesTipo.Nombre,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoClientesTipo.IdEmpresa
            
         
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

    
    func eliminarCatalogoClientesTipo(idCatalogoClientesTipo: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoClientesTipo/\(idCatalogoClientesTipo)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoClientesTipo(completion: @escaping (Result<[CatalogoClientesTipo], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoClientesTipo?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoClientesTipo].self) { response in
                    switch response.result {
                    case .success(let catalogoClientesTipo):
                        completion(.success(catalogoClientesTipo))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoClientesTipo(nuevoCatalogoClientesTipo: CatalogoClientesTipo, completion: @escaping (Result<CatalogoClientesTipo, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoClientesTipo.Nombre,
               "Fecha":nuevoCatalogoClientesTipo.Fecha,
               "IdEmpresa":nuevoCatalogoClientesTipo.IdEmpresa
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoClientesTipo", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoClientesTipo.self) { response in
                   switch response.result {
                   case .success(let catalogoClientesTipo):
                       completion(.success(catalogoClientesTipo))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

//
//  CatalogoClientesEstadoCivil.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoClientesEstadoCivilAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoClientesEstadoCivilAPIService()
    
    func editarCatalogoClientesEstadoCivil(catalogoClientesEstadoCivil: CatalogoClientesEstadoCivil, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoClientesEstadoCivil/\(catalogoClientesEstadoCivil.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoClientesEstadoCivil.Nombre,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoClientesEstadoCivil.IdEmpresa
            
         
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

    
    func eliminarCatalogoClientesEstadoCivil(idCatalogoClientesEstadoCivil: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoClientesEstadoCivil/\(idCatalogoClientesEstadoCivil)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoClientesEstadoCivil(completion: @escaping (Result<[CatalogoClientesEstadoCivil], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoClientesEstadoCivil?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoClientesEstadoCivil].self) { response in
                    switch response.result {
                    case .success(let catalogoClientesEstadoCivil):
                        completion(.success(catalogoClientesEstadoCivil))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoClientesEstadoCivil(nuevoCatalogoClientesEstadoCivil: CatalogoClientesEstadoCivil, completion: @escaping (Result<CatalogoClientesEstadoCivil, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoClientesEstadoCivil.Nombre,
               "Fecha":nuevoCatalogoClientesEstadoCivil.Fecha,
               "IdEmpresa":nuevoCatalogoClientesEstadoCivil.IdEmpresa
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoClientesEstadoCivil", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoClientesEstadoCivil.self) { response in
                   switch response.result {
                   case .success(let catalogoClientesEstadoCivil):
                       completion(.success(catalogoClientesEstadoCivil))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

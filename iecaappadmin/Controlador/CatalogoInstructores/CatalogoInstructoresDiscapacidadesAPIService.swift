//
//  CatalogoInstructoresDiscapacidades.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire

class CatalogoInstructoresDiscapacidadesAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoInstructoresDiscapacidadesAPIService()
    
    func editarCatalogoInstructoresDiscapacidades(catalogoInstructoresDiscapacidades: CatalogoInstructoresDiscapacidades, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoInstructoresDiscapacidades/\(catalogoInstructoresDiscapacidades.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoInstructoresDiscapacidades.Nombre,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoInstructoresDiscapacidades.IdEmpresa
            
         
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

    
    func eliminarCatalogoInstructoresDiscapacidades(idCatalogoInstructoresDiscapacidades: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoInstructoresDiscapacidades/\(idCatalogoInstructoresDiscapacidades)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoInstructoresDiscapacidades(completion: @escaping (Result<[CatalogoInstructoresDiscapacidades], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoInstructoresDiscapacidades?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoInstructoresDiscapacidades].self) { response in
                    switch response.result {
                    case .success(let catalogoInstructoresDiscapacidades):
                        completion(.success(catalogoInstructoresDiscapacidades))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoInstructoresDiscapacidades(nuevoCatalogoInstructoresDiscapacidades: CatalogoInstructoresDiscapacidades, completion: @escaping (Result<CatalogoInstructoresDiscapacidades, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoInstructoresDiscapacidades.Nombre,
               "Fecha":nuevoCatalogoInstructoresDiscapacidades.Fecha,
               "IdEmpresa":nuevoCatalogoInstructoresDiscapacidades.IdEmpresa
             
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoInstructoresDiscapacidades", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoInstructoresDiscapacidades.self) { response in
                   switch response.result {
                   case .success(let catalogoInstructoresDiscapacidades):
                       completion(.success(catalogoInstructoresDiscapacidades))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


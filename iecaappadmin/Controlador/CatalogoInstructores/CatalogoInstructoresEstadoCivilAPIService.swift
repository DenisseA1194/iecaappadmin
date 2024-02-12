//
//  CatalogoInstructoresEstadoCivil.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire

class CatalogoInstructoresEstadoCivilAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoInstructoresEstadoCivilAPIService()
    
    func editarCatalogoInstructoresEstadoCivil(catalogoInstructoresEstadoCivil: CatalogoInstructoresEstadoCivil, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoInstructoresEstadoCivil/\(catalogoInstructoresEstadoCivil.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoInstructoresEstadoCivil.Nombre,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoInstructoresEstadoCivil.IdEmpresa
            
         
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

    
    func eliminarCatalogoInstructoresEstadoCivil(idCatalogoInstructoresEstadoCivil: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoInstructoresEstadoCivil/\(idCatalogoInstructoresEstadoCivil)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoInstructoresEstadoCivil(completion: @escaping (Result<[CatalogoInstructoresEstadoCivil], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoInstructoresEstadoCivil?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoInstructoresEstadoCivil].self) { response in
                    switch response.result {
                    case .success(let catalogoInstructoresEstadoCivil):
                        completion(.success(catalogoInstructoresEstadoCivil))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoInstructoresEstadoCivil(nuevoCatalogoInstructoresEstadoCivil: CatalogoInstructoresEstadoCivil, completion: @escaping (Result<CatalogoInstructoresEstadoCivil, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoInstructoresEstadoCivil.Nombre,
               "Fecha":nuevoCatalogoInstructoresEstadoCivil.Fecha,
               "IdEmpresa":nuevoCatalogoInstructoresEstadoCivil.IdEmpresa
             
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoInstructoresEstadoCivil", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoInstructoresEstadoCivil.self) { response in
                   switch response.result {
                   case .success(let catalogoInstructoresEstadoCivil):
                       completion(.success(catalogoInstructoresEstadoCivil))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


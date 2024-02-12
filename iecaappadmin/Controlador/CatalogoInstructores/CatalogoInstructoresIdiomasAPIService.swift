//
//  CatalogoInstructoresIdiomas.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire

class CatalogoInstructoresIdiomasAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoInstructoresIdiomasAPIService()
    
    func editarCatalogoInstructoresIdiomas(catalogoInstructoresIdiomas: CatalogoInstructoresIdiomas, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoInstructoresIdiomas/\(catalogoInstructoresIdiomas.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoInstructoresIdiomas.Nombre,
            "Nivel": catalogoInstructoresIdiomas.Nivel,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoInstructoresIdiomas.IdEmpresa
            
         
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

    
    func eliminarCatalogoInstructoresIdiomas(idCatalogoInstructoresIdiomas: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoInstructoresIdiomas/\(idCatalogoInstructoresIdiomas)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoInstructoresIdiomas(completion: @escaping (Result<[CatalogoInstructoresIdiomas], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoInstructoresIdiomas?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoInstructoresIdiomas].self) { response in
                    switch response.result {
                    case .success(let catalogoInstructoresIdiomas):
                        completion(.success(catalogoInstructoresIdiomas))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoInstructoresIdiomas(nuevoCatalogoInstructoresIdiomas: CatalogoInstructoresIdiomas, completion: @escaping (Result<CatalogoInstructoresIdiomas, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoInstructoresIdiomas.Nombre,
               "Nivel": nuevoCatalogoInstructoresIdiomas.Nivel,
               "Fecha":nuevoCatalogoInstructoresIdiomas.Fecha,
               "IdEmpresa":nuevoCatalogoInstructoresIdiomas.IdEmpresa
             
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoInstructoresIdiomas", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoInstructoresIdiomas.self) { response in
                   switch response.result {
                   case .success(let catalogoInstructoresIdiomas):
                       completion(.success(catalogoInstructoresIdiomas))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


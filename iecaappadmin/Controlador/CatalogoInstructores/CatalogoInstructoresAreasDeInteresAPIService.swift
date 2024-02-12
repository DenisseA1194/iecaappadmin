//
//  APIServiceCatalogoInstructoresAreasDeInteres.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire

class CatalogoInstructoresAreasDeInteresAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoInstructoresAreasDeInteresAPIService()
    
    func editarCatalogoInstructoresAreasDeInteres(catalogoInstructoresAreasDeInteres: CatalogoInstructoresAreasDeInteres, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoInstructoresAreasDeInteres/\(catalogoInstructoresAreasDeInteres.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoInstructoresAreasDeInteres.Nombre,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoInstructoresAreasDeInteres.IdEmpresa
            
         
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

    
    func eliminarCatalogoInstructoresAreasDeInteres(idCatalogoInstructoresAreasDeInteres: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoInstructoresAreasDeInteres/\(idCatalogoInstructoresAreasDeInteres)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoInstructoresAreasDeInteres(completion: @escaping (Result<[CatalogoInstructoresAreasDeInteres], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoInstructoresAreasDeInteres?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoInstructoresAreasDeInteres].self) { response in
                    switch response.result {
                    case .success(let catalogoInstructoresAreasDeInteres):
                        completion(.success(catalogoInstructoresAreasDeInteres))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoInstructoresAreasDeInteres(nuevoCatalogoInstructoresAreasDeInteres: CatalogoInstructoresAreasDeInteres, completion: @escaping (Result<CatalogoInstructoresAreasDeInteres, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoInstructoresAreasDeInteres.Nombre,
               "Fecha":nuevoCatalogoInstructoresAreasDeInteres.Fecha,
               "IdEmpresa":nuevoCatalogoInstructoresAreasDeInteres.IdEmpresa
             
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoInstructoresAreasDeInteres", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoInstructoresAreasDeInteres.self) { response in
                   switch response.result {
                   case .success(let catalogoInstructoresAreasDeInteres):
                       completion(.success(catalogoInstructoresAreasDeInteres))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

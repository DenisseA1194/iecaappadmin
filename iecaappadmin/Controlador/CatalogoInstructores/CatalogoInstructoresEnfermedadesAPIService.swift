//
//  CatalogoInstructoresEnfermedades.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire

class CatalogoInstructoresEnfermedadesAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoInstructoresEnfermedadesAPIService()
    
    func editarCatalogoInstructoresEnfermedades(catalogoInstructoresEnfermedades: CatalogoInstructoresEnfermedades, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoInstructoresEnfermedades/\(catalogoInstructoresEnfermedades.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoInstructoresEnfermedades.Nombre,
            "Notas": catalogoInstructoresEnfermedades.Notas,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoInstructoresEnfermedades.IdEmpresa
            
         
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

    
    func eliminarCatalogoInstructoresEnfermedades(idCatalogoInstructoresEnfermedades: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoInstructoresEnfermedades/\(idCatalogoInstructoresEnfermedades)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoInstructoresEnfermedades(completion: @escaping (Result<[CatalogoInstructoresEnfermedades], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoInstructoresEnfermedades?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoInstructoresEnfermedades].self) { response in
                    switch response.result {
                    case .success(let catalogoInstructoresEnfermedades):
                        completion(.success(catalogoInstructoresEnfermedades))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoInstructoresEnfermedades(nuevoCatalogoInstructoresEnfermedades: CatalogoInstructoresEnfermedades, completion: @escaping (Result<CatalogoInstructoresEnfermedades, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoInstructoresEnfermedades.Nombre,
               "Notas": nuevoCatalogoInstructoresEnfermedades.Notas,
               "Fecha":nuevoCatalogoInstructoresEnfermedades.Fecha,
               "IdEmpresa":nuevoCatalogoInstructoresEnfermedades.IdEmpresa
             
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoInstructoresEnfermedades", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoInstructoresEnfermedades.self) { response in
                   switch response.result {
                   case .success(let catalogoInstructoresEnfermedades):
                       completion(.success(catalogoInstructoresEnfermedades))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


//
//  CatalogoInstructoresEquiposHerramientas.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire

class CatalogoInstructoresEquiposHerramientasAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoInstructoresEquiposHerramientasAPIService()
    
    func editarCatalogoInstructoresEquiposHerramientas(catalogoInstructoresEquiposHerramientas: CatalogoInstructoresEquiposHerramientas, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoInstructoresEquiposHerramientas/\(catalogoInstructoresEquiposHerramientas.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoInstructoresEquiposHerramientas.Nombre,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoInstructoresEquiposHerramientas.IdEmpresa
            
         
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

    
    func eliminarCatalogoInstructoresEquiposHerramientas(idCatalogoInstructoresEquiposHerramientas: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoInstructoresEquiposHerramientas/\(idCatalogoInstructoresEquiposHerramientas)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoInstructoresEquiposHerramientas(completion: @escaping (Result<[CatalogoInstructoresEquiposHerramientas], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoInstructoresEquiposHerramientas?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoInstructoresEquiposHerramientas].self) { response in
                    switch response.result {
                    case .success(let catalogoInstructoresEquiposHerramientas):
                        completion(.success(catalogoInstructoresEquiposHerramientas))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoInstructoresEquiposHerramientas(nuevoCatalogoInstructoresEquiposHerramientas: CatalogoInstructoresEquiposHerramientas, completion: @escaping (Result<CatalogoInstructoresEquiposHerramientas, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoInstructoresEquiposHerramientas.Nombre,
               "Fecha":nuevoCatalogoInstructoresEquiposHerramientas.Fecha,
               "IdEmpresa":nuevoCatalogoInstructoresEquiposHerramientas.IdEmpresa
             
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoInstructoresEquiposHerramientas", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoInstructoresEquiposHerramientas.self) { response in
                   switch response.result {
                   case .success(let catalogoInstructoresEquiposHerramientas):
                       completion(.success(catalogoInstructoresEquiposHerramientas))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


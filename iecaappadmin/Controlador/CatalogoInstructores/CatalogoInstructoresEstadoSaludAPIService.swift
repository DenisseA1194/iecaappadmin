//
//  CatalogoInstructoresEstadoSalud.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire

class CatalogoInstructoresEstadoSaludAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoInstructoresEstadoSaludAPIService()
    
    func editarCatalogoInstructoresEstadoSalud(catalogoInstructoresEstadoSalud: CatalogoInstructoresEstadoSalud, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoInstructoresEstadoSalud/\(catalogoInstructoresEstadoSalud.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoInstructoresEstadoSalud.Nombre,
            "Notas": catalogoInstructoresEstadoSalud.Notas,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoInstructoresEstadoSalud.IdEmpresa
            
         
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

    
    func eliminarCatalogoInstructoresEstadoSalud(idCatalogoInstructoresEstadoSalud: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoInstructoresEstadoSalud/\(idCatalogoInstructoresEstadoSalud)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoInstructoresEstadoSalud(completion: @escaping (Result<[CatalogoInstructoresEstadoSalud], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoInstructoresEstadoSalud?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoInstructoresEstadoSalud].self) { response in
                    switch response.result {
                    case .success(let catalogoInstructoresEstadoSalud):
                        completion(.success(catalogoInstructoresEstadoSalud))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoInstructoresEstadoSalud(nuevoCatalogoInstructoresEstadoSalud: CatalogoInstructoresEstadoSalud, completion: @escaping (Result<CatalogoInstructoresEstadoSalud, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoInstructoresEstadoSalud.Nombre,
               "Notas": nuevoCatalogoInstructoresEstadoSalud.Notas,
               "Fecha":nuevoCatalogoInstructoresEstadoSalud.Fecha,
               "IdEmpresa":nuevoCatalogoInstructoresEstadoSalud.IdEmpresa
             
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoInstructoresEstadoSalud", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoInstructoresEstadoSalud.self) { response in
                   switch response.result {
                   case .success(let catalogoInstructoresEstadoSalud):
                       completion(.success(catalogoInstructoresEstadoSalud))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


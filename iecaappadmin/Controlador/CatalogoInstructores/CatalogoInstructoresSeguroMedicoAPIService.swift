//
//  CatalogoInstructoresSeguroMedico.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire

class CatalogoInstructoresSeguroMedicoAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoInstructoresSeguroMedicoAPIService()
    
    func editarCatalogoInstructoresSeguroMedico(catalogoInstructoresSeguroMedico: CatalogoInstructoresSeguroMedico, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoInstructoresSeguroMedico/\(catalogoInstructoresSeguroMedico.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoInstructoresSeguroMedico.Nombre,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoInstructoresSeguroMedico.IdEmpresa
            
         
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

    
    func eliminarCatalogoInstructoresSeguroMedico(idCatalogoInstructoresSeguroMedico: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoInstructoresSeguroMedico/\(idCatalogoInstructoresSeguroMedico)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoInstructoresSeguroMedico(completion: @escaping (Result<[CatalogoInstructoresSeguroMedico], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoInstructoresSeguroMedico?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoInstructoresSeguroMedico].self) { response in
                    switch response.result {
                    case .success(let catalogoInstructoresSeguroMedico):
                        completion(.success(catalogoInstructoresSeguroMedico))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoInstructoresSeguroMedico(nuevoCatalogoInstructoresSeguroMedico: CatalogoInstructoresSeguroMedico, completion: @escaping (Result<CatalogoInstructoresSeguroMedico, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoInstructoresSeguroMedico.Nombre,
               "Fecha":nuevoCatalogoInstructoresSeguroMedico.Fecha,
               "IdEmpresa":nuevoCatalogoInstructoresSeguroMedico.IdEmpresa
             
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoInstructoresSeguroMedico", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoInstructoresSeguroMedico.self) { response in
                   switch response.result {
                   case .success(let catalogoInstructoresSeguroMedico):
                       completion(.success(catalogoInstructoresSeguroMedico))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


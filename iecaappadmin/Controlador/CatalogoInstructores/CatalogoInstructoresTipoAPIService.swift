//
//  CatalogoInstructoresTipo.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire

class CatalogoInstructoresTipoAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoInstructoresTipoAPIService()
    
    func editarCatalogoInstructoresTipo(catalogoInstructoresTipo: CatalogoInstructoresTipo, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoInstructoresTipo/\(catalogoInstructoresTipo.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoInstructoresTipo.Nombre,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoInstructoresTipo.IdEmpresa
            
         
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

    
    func eliminarCatalogoInstructoresTipo(idCatalogoInstructoresTipo: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoInstructoresTipo/\(idCatalogoInstructoresTipo)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoInstructoresTipo(completion: @escaping (Result<[CatalogoInstructoresTipo], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoInstructoresTipo?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoInstructoresTipo].self) { response in
                    switch response.result {
                    case .success(let catalogoInstructoresTipo):
                        completion(.success(catalogoInstructoresTipo))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoInstructoresTipo(nuevoCatalogoInstructoresTipo: CatalogoInstructoresTipo, completion: @escaping (Result<CatalogoInstructoresTipo, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoInstructoresTipo.Nombre,
               "Fecha":nuevoCatalogoInstructoresTipo.Fecha,
               "IdEmpresa":nuevoCatalogoInstructoresTipo.IdEmpresa
             
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoInstructoresTipo", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoInstructoresTipo.self) { response in
                   switch response.result {
                   case .success(let catalogoInstructoresTipo):
                       completion(.success(catalogoInstructoresTipo))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


//
//  APIService.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire

class CatalogoInstructoresCursosAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoInstructoresCursosAPIService()
    
    func editarCatalogoInstructoresCursos(catalogoInstructoresCursos: CatalogoInstructoresCursos, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoInstructoresCursos/\(catalogoInstructoresCursos.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoInstructoresCursos.Nombre,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoInstructoresCursos.IdEmpresa
            
         
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

    
    func eliminarCatalogoInstructoresCursos(idCatalogoInstructoresCursos: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoInstructoresCursos/\(idCatalogoInstructoresCursos)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoInstructoresCursos(completion: @escaping (Result<[CatalogoInstructoresCursos], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoInstructoresCursos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoInstructoresCursos].self) { response in
                    switch response.result {
                    case .success(let catalogoInstructoresCursos):
                        completion(.success(catalogoInstructoresCursos))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoInstructoresCursos(nuevoCatalogoInstructoresCursos: CatalogoInstructoresCursos, completion: @escaping (Result<CatalogoInstructoresCursos, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoInstructoresCursos.Nombre,
               "Fecha":nuevoCatalogoInstructoresCursos.Fecha,
               "IdEmpresa":nuevoCatalogoInstructoresCursos.IdEmpresa
             
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoInstructoresCursos", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoInstructoresCursos.self) { response in
                   switch response.result {
                   case .success(let catalogoInstructoresCursos):
                       completion(.success(catalogoInstructoresCursos))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


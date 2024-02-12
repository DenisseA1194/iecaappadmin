//
//  CatalogoInstructoresInstituciones.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire

class CatalogoInstructoresInstitucionesAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoInstructoresInstitucionesAPIService()
    
    func editarCatalogoInstructoresInstituciones(catalogoInstructoresInstituciones: CatalogoInstructoresInstituciones, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoInstructoresInstituciones/\(catalogoInstructoresInstituciones.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoInstructoresInstituciones.Nombre,
            "Notas": catalogoInstructoresInstituciones.Notas,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoInstructoresInstituciones.IdEmpresa
            
         
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

    
    func eliminarCatalogoInstructoresInstituciones(idCatalogoInstructoresInstituciones: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoInstructoresInstituciones/\(idCatalogoInstructoresInstituciones)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoInstructoresInstituciones(completion: @escaping (Result<[CatalogoInstructoresInstituciones], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoInstructoresInstituciones?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoInstructoresInstituciones].self) { response in
                    switch response.result {
                    case .success(let catalogoInstructoresInstituciones):
                        completion(.success(catalogoInstructoresInstituciones))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoInstructoresInstituciones(nuevoCatalogoInstructoresInstituciones: CatalogoInstructoresInstituciones, completion: @escaping (Result<CatalogoInstructoresInstituciones, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoInstructoresInstituciones.Nombre,
               "Notas": nuevoCatalogoInstructoresInstituciones.Notas,
               "Fecha":nuevoCatalogoInstructoresInstituciones.Fecha,
               "IdEmpresa":nuevoCatalogoInstructoresInstituciones.IdEmpresa
             
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoInstructoresInstituciones", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoInstructoresInstituciones.self) { response in
                   switch response.result {
                   case .success(let catalogoInstructoresInstituciones):
                       completion(.success(catalogoInstructoresInstituciones))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


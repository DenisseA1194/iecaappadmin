//
//  CatalogoInstructoresTiposDocumentos.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire

class CatalogoInstructoresTiposDocumentosAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoInstructoresTiposDocumentosAPIService()
    
    func editarCatalogoInstructoresTiposDocumentos(catalogoInstructoresTiposDocumentos: CatalogoInstructoresTiposDocumentos, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoInstructoresTiposDocumentos/\(catalogoInstructoresTiposDocumentos.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoInstructoresTiposDocumentos.Nombre,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoInstructoresTiposDocumentos.IdEmpresa,
            "Activo":catalogoInstructoresTiposDocumentos.Activo
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

    
    func eliminarCatalogoInstructoresTiposDocumentos(idCatalogoInstructoresTiposDocumentos: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoInstructoresTiposDocumentos/\(idCatalogoInstructoresTiposDocumentos)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoInstructoresTiposDocumentos(completion: @escaping (Result<[CatalogoInstructoresTiposDocumentos], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoInstructoresTiposDocumentos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoInstructoresTiposDocumentos].self) { response in
                    switch response.result {
                    case .success(let catalogoInstructoresTiposDocumentos):
                        completion(.success(catalogoInstructoresTiposDocumentos))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoInstructoresTiposDocumentos(nuevoCatalogoInstructoresTiposDocumentos: CatalogoInstructoresTiposDocumentos, completion: @escaping (Result<CatalogoInstructoresTiposDocumentos, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoInstructoresTiposDocumentos.Nombre,
               "Fecha":nuevoCatalogoInstructoresTiposDocumentos.Fecha,
               "IdEmpresa":nuevoCatalogoInstructoresTiposDocumentos.IdEmpresa,
               "Activo":nuevoCatalogoInstructoresTiposDocumentos.Activo
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoInstructoresTiposDocumentos", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoInstructoresTiposDocumentos.self) { response in
                   switch response.result {
                   case .success(let catalogoInstructoresTiposDocumentos):
                       completion(.success(catalogoInstructoresTiposDocumentos))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


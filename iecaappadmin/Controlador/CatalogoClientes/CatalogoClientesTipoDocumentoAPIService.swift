//
//  CatalogoClientesTipoDocumento.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoClientesTipoDocumentoAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoClientesTipoDocumentoAPIService()
    
    func editarCatalogoClientesTipoDocumento(catalogoClientesTipoDocumento: CatalogoClientesTipoDocumento, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoClientesTipoDocumento/\(catalogoClientesTipoDocumento.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoClientesTipoDocumento.Nombre,
            "Fecha": formattedDate,
            "Activo":catalogoClientesTipoDocumento.Activo,
            "IdEmpresa":catalogoClientesTipoDocumento.IdEmpresa
            
         
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

    
    func eliminarCatalogoClientesTipoDocumento(idCatalogoClientesTipoDocumento: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoClientesTipoDocumento/\(idCatalogoClientesTipoDocumento)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoClientesTipoDocumento(completion: @escaping (Result<[CatalogoClientesTipoDocumento], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoClientesTipoDocumento?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoClientesTipoDocumento].self) { response in
                    switch response.result {
                    case .success(let catalogoClientesTipoDocumento):
                        completion(.success(catalogoClientesTipoDocumento))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoClientesTipoDocumento(nuevoCatalogoClientesTipoDocumento: CatalogoClientesTipoDocumento, completion: @escaping (Result<CatalogoClientesTipoDocumento, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoClientesTipoDocumento.Nombre,
               "Fecha":nuevoCatalogoClientesTipoDocumento.Fecha,
               "Activo":nuevoCatalogoClientesTipoDocumento.Activo,
               "IdEmpresa":nuevoCatalogoClientesTipoDocumento.IdEmpresa
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoClientesTipoDocumento", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoClientesTipoDocumento.self) { response in
                   switch response.result {
                   case .success(let catalogoClientesTipoDocumento):
                       completion(.success(catalogoClientesTipoDocumento))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

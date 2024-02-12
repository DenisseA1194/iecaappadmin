//
//  APIServiceCatalogoInstructoresBancos.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire

class CatalogoInstructoresBancosAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoInstructoresBancosAPIService()
    
    func editarCatalogoInstructoresBancos(catalogoInstructoresBancos: CatalogoInstructoresBancos, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoInstructoresBancos/\(catalogoInstructoresBancos.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoInstructoresBancos.Nombre,
            "Notas": catalogoInstructoresBancos.Notas,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoInstructoresBancos.IdEmpresa
            
         
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

    
    func eliminarCatalogoInstructoresBancos(idCatalogoInstructoresBancos: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoInstructoresBancos/\(idCatalogoInstructoresBancos)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoInstructoresBancos(completion: @escaping (Result<[CatalogoInstructoresBancos], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoInstructoresBancos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoInstructoresBancos].self) { response in
                    switch response.result {
                    case .success(let catalogoInstructoresBancos):
                        completion(.success(catalogoInstructoresBancos))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoInstructoresBancos(nuevoCatalogoInstructoresBancos: CatalogoInstructoresBancos, completion: @escaping (Result<CatalogoInstructoresBancos, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoInstructoresBancos.Nombre,
               "Notas": nuevoCatalogoInstructoresBancos.Notas,
               "Fecha":nuevoCatalogoInstructoresBancos.Fecha,
               "IdEmpresa":nuevoCatalogoInstructoresBancos.IdEmpresa
             
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoInstructoresBancos", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoInstructoresBancos.self) { response in
                   switch response.result {
                   case .success(let catalogoInstructoresBancos):
                       completion(.success(catalogoInstructoresBancos))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

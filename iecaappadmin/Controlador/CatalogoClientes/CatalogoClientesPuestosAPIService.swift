//
//  CatalogoClientesPuestos.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoClientesPuestosAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoClientesPuestosAPIService()
    
    func editarCatalogoClientesPuestos(catalogoClientesPuestos: CatalogoClientesPuestos, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoClientesPuestos/\(catalogoClientesPuestos.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoClientesPuestos.Nombre,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoClientesPuestos.IdEmpresa
            
         
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

    
    func eliminarCatalogoClientesPuestos(idCatalogoClientesPuestos: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoClientesPuestos/\(idCatalogoClientesPuestos)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoClientesPuestos(completion: @escaping (Result<[CatalogoClientesPuestos], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoClientesPuestos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoClientesPuestos].self) { response in
                    switch response.result {
                    case .success(let catalogoClientesPuestos):
                        completion(.success(catalogoClientesPuestos))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoClientesPuestos(nuevoCatalogoClientesPuestos: CatalogoClientesPuestos, completion: @escaping (Result<CatalogoClientesPuestos, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoClientesPuestos.Nombre,
               "Fecha":nuevoCatalogoClientesPuestos.Fecha,
               "IdEmpresa":nuevoCatalogoClientesPuestos.IdEmpresa
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoClientesPuestos", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoClientesPuestos.self) { response in
                   switch response.result {
                   case .success(let catalogoClientesPuestos):
                       completion(.success(catalogoClientesPuestos))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

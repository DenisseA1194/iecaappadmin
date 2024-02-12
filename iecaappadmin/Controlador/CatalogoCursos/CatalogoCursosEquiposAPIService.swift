//
//  CatalogoCursosEquipos.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoCursosEquiposAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoCursosEquiposAPIService()
    
    func editarCatalogoCursosEquipos(catalogoCursosEquipos: CatalogoCursosEquipos, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoCursosEquipos/\(catalogoCursosEquipos.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdEmpresa":catalogoCursosEquipos.IdEmpresa,
            "Link":catalogoCursosEquipos.Link,
            "Fecha": formattedDate,
            "Nombre": catalogoCursosEquipos.Nombre,
            "Notas": catalogoCursosEquipos.Notas,
            "Observaciones": catalogoCursosEquipos.Observaciones,
            "Marca": catalogoCursosEquipos.Marca,
            "Modelo": catalogoCursosEquipos.Modelo,
            "Status":catalogoCursosEquipos.Status
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

    
    func eliminarCatalogoCursosEquipos(idCatalogoCursosEquipos: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoCursosEquipos/\(idCatalogoCursosEquipos)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoCursosEquipos(completion: @escaping (Result<[CatalogoCursosEquipos], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoCursosEquipos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoCursosEquipos].self) { response in
                    switch response.result {
                    case .success(let catalogoCursosEquipos):
                        completion(.success(catalogoCursosEquipos))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoCursosEquipos(nuevoCatalogoCursosEquipos: CatalogoCursosEquipos, completion: @escaping (Result<CatalogoCursosEquipos, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdEmpresa":nuevoCatalogoCursosEquipos.IdEmpresa,
            "Link":nuevoCatalogoCursosEquipos.Link,
            "Fecha": nuevoCatalogoCursosEquipos.Fecha,
            "Nombre": nuevoCatalogoCursosEquipos.Nombre,
            "Notas": nuevoCatalogoCursosEquipos.Notas,
            "Observaciones": nuevoCatalogoCursosEquipos.Observaciones,
            "Marca": nuevoCatalogoCursosEquipos.Marca,
            "Modelo": nuevoCatalogoCursosEquipos.Modelo,
            "Status":nuevoCatalogoCursosEquipos.Status
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoCursosEquipos", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoCursosEquipos.self) { response in
                   switch response.result {
                   case .success(let catalogoCursosEquipos):
                       completion(.success(catalogoCursosEquipos))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

//
//  CatalogoCursosProgramas.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoCursosProgramasAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoCursosProgramasAPIService()
    private let baseURL = "http://webservices.iecapp.com"
    func editarCatalogoCursosProgramas(catalogoCursosProgramas: CatalogoCursosProgramas, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/CatalogoCursosProgramas/\(catalogoCursosProgramas.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Id":catalogoCursosProgramas.Id,
            "IdEmpresa": catalogoCursosProgramas.IdEmpresa,
            "Fecha": catalogoCursosProgramas.Fecha,
            "Nombre": catalogoCursosProgramas.Nombre,
            "Notas": catalogoCursosProgramas.Notas,
            "Observaciones": catalogoCursosProgramas.Observaciones,
            "Status": catalogoCursosProgramas.Status,
            "Borrado": catalogoCursosProgramas.Borrado
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

    
    func eliminarCatalogoCursosProgramas(idCatalogoCursosProgramas: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = baseURL + "/api/CatalogoCursosProgramas/\(idCatalogoCursosProgramas)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoCursosProgramas(completion: @escaping (Result<[CatalogoCursosProgramas], Error>) -> Void) {
            AF.request(baseURL+"/api/CatalogoCursosProgramas?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoCursosProgramas].self) { response in
                    switch response.result {
                    case .success(let catalogoCursosProgramas):
                        completion(.success(catalogoCursosProgramas))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoCursosProgramas(nuevoCatalogoCursosProgramas: CatalogoCursosProgramas, completion: @escaping (Result<CatalogoCursosProgramas, Error>) -> Void) {
           let parameters: [String: Any] = [
            "Id":nuevoCatalogoCursosProgramas.Id,
            "IdEmpresa": nuevoCatalogoCursosProgramas.IdEmpresa,
            "Fecha": nuevoCatalogoCursosProgramas.Fecha,
            "Nombre": nuevoCatalogoCursosProgramas.Nombre,
            "Notas": nuevoCatalogoCursosProgramas.Notas,
            "Observaciones": nuevoCatalogoCursosProgramas.Observaciones,
            "Status": nuevoCatalogoCursosProgramas.Status,
            "Borrado": nuevoCatalogoCursosProgramas.Borrado
           ]
        
           AF.request(baseURL + "/api/CatalogoCursosProgramas", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoCursosProgramas.self) { response in
                   switch response.result {
                   case .success(let catalogoCursosProgramas):
                       completion(.success(catalogoCursosProgramas))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

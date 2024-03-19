//
//  CatalogoCursosTemas.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoCursosTemasAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoCursosTemasAPIService()
    private let baseURL = "http://webservices.iecapp.com"
    func editarCatalogoCursosTemas(catalogoCursosTemas: CatalogoCursosTemas, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/CatalogoCursosTemas/\(catalogoCursosTemas.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Id": catalogoCursosTemas.Id,
            "IdEmpresa":catalogoCursosTemas.IdEmpresa,
            "Fecha": formattedDate,
            "Nombre": catalogoCursosTemas.Nombre,
            "Notas": catalogoCursosTemas.Notas,
            "Observaciones": catalogoCursosTemas.Observaciones,
            "Link":catalogoCursosTemas.Link,
            "Status":catalogoCursosTemas.Status
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

    
    func eliminarCatalogoCursosTemas(idCatalogoCursosTemas: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = baseURL + "/api/CatalogoCursosTemas/\(idCatalogoCursosTemas)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoCursosTemas(completion: @escaping (Result<[CatalogoCursosTemas], Error>) -> Void) {
            AF.request(baseURL + "/api/CatalogoCursosTemas?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoCursosTemas].self) { response in
                    switch response.result {
                    case .success(let catalogoCursosTemas):
                        completion(.success(catalogoCursosTemas))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoCursosTemas(nuevoCatalogoCursosTemas: CatalogoCursosTemas, completion: @escaping (Result<CatalogoCursosTemas, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdEmpresa":nuevoCatalogoCursosTemas.IdEmpresa,
            "Fecha": nuevoCatalogoCursosTemas.Fecha,
            "Nombre": nuevoCatalogoCursosTemas.Nombre,
            "Notas": nuevoCatalogoCursosTemas.Notas,
            "Observaciones": nuevoCatalogoCursosTemas.Observaciones,
            "Link": nuevoCatalogoCursosTemas.Link,
            "Status":nuevoCatalogoCursosTemas.Status
           ]
        
           AF.request(baseURL + "/api/CatalogoCursosTemas", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoCursosTemas.self) { response in
                   switch response.result {
                   case .success(let catalogoCursosTemas):
                       completion(.success(catalogoCursosTemas))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

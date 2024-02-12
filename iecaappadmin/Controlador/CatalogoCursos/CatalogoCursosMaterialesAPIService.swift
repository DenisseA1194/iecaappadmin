//
//  CatalogoCursosMateriales.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoCursosMaterialesAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoCursosMaterialesAPIService()
    
    func editarCatalogoCursosMateriales(catalogoCursosMateriales: CatalogoCursosMateriales, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoCursosMateriales/\(catalogoCursosMateriales.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdEmpresa":catalogoCursosMateriales.IdEmpresa,
            "Fecha": formattedDate,
            "Nombre": catalogoCursosMateriales.Nombre,
            "Notas": catalogoCursosMateriales.Notas,
            "Observaciones": catalogoCursosMateriales.Observaciones,
            "Link": catalogoCursosMateriales.Link,
            "Status":catalogoCursosMateriales.Status
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

    
    func eliminarCatalogoCursosMateriales(idCatalogoCursosMateriales: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoCursosMateriales/\(idCatalogoCursosMateriales)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoCursosMateriales(completion: @escaping (Result<[CatalogoCursosMateriales], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoCursosMateriales?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoCursosMateriales].self) { response in
                    switch response.result {
                    case .success(let catalogoCursosMateriales):
                        completion(.success(catalogoCursosMateriales))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoCursosMateriales(nuevoCatalogoCursosMateriales: CatalogoCursosMateriales, completion: @escaping (Result<CatalogoCursosMateriales, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdEmpresa":nuevoCatalogoCursosMateriales.IdEmpresa,
            "Fecha": nuevoCatalogoCursosMateriales.Fecha,
            "Nombre": nuevoCatalogoCursosMateriales.Nombre,
            "Notas": nuevoCatalogoCursosMateriales.Notas,
            "Observaciones": nuevoCatalogoCursosMateriales.Observaciones,
            "Link": nuevoCatalogoCursosMateriales.Link,
            "Status":nuevoCatalogoCursosMateriales.Status
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoCursosMateriales", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoCursosMateriales.self) { response in
                   switch response.result {
                   case .success(let catalogoCursosMateriales):
                       completion(.success(catalogoCursosMateriales))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

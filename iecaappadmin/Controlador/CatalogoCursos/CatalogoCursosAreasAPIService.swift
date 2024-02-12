//
//  CatalogoCursosAreas.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoCursosAreasAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoCursosAreasAPIService()
    
    func editarCatalogoCursosAreas(catalogoCursosAreas: CatalogoCursosAreas, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoCursosAreas/\(catalogoCursosAreas.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdEmpresa":catalogoCursosAreas.IdEmpresa,
            "Fecha": formattedDate,
            "Nombre": catalogoCursosAreas.Nombre,
            "Notas": catalogoCursosAreas.Notas,
            "Observaciones": catalogoCursosAreas.Observaciones,
            "Status":catalogoCursosAreas.Status
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

    
    func eliminarCatalogoCursosAreas(idCatalogoCursosAreas: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoCursosAreas/\(idCatalogoCursosAreas)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoCursosAreas(completion: @escaping (Result<[CatalogoCursosAreas], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoCursosAreas?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoCursosAreas].self) { response in
                    switch response.result {
                    case .success(let catalogoCursosAreas):
                        completion(.success(catalogoCursosAreas))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoCursosAreas(nuevoCatalogoCursosAreas: CatalogoCursosAreas, completion: @escaping (Result<CatalogoCursosAreas, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdEmpresa":nuevoCatalogoCursosAreas.IdEmpresa,
            "Fecha": nuevoCatalogoCursosAreas.Fecha,
            "Nombre": nuevoCatalogoCursosAreas.Nombre,
            "Notas": nuevoCatalogoCursosAreas.Notas,
            "Observaciones": nuevoCatalogoCursosAreas.Observaciones,
            "Status":nuevoCatalogoCursosAreas.Status
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoCursosAreas", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoCursosAreas.self) { response in
                   switch response.result {
                   case .success(let catalogoCursosAreas):
                       completion(.success(catalogoCursosAreas))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

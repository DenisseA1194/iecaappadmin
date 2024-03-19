//
//  CatalogoCursosModalidades.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoCursosModalidadesAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoCursosModalidadesAPIService()
    private let baseURL = "http://webservices.iecapp.com"
    
    func editarCatalogoCursosModalidades(catalogoCursosModalidades: CatalogoCursosModalidades, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/CatalogoCursosModalidades/\(catalogoCursosModalidades.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdEmpresa":catalogoCursosModalidades.IdEmpresa,
            "Fecha": formattedDate,
            "Nombre": catalogoCursosModalidades.Nombre,
            "Notas": catalogoCursosModalidades.Notas,
            "Observaciones": catalogoCursosModalidades.Observaciones,
            "Status":catalogoCursosModalidades.Status
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

    
    func eliminarCatalogoCursosModalidades(idCatalogoCursosModalidades: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = baseURL + "/api/CatalogoCursosModalidades/\(idCatalogoCursosModalidades)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoCursosModalidades(completion: @escaping (Result<[CatalogoCursosModalidades], Error>) -> Void) {
            AF.request(baseURL + "/api/CatalogoCursosModalidades?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoCursosModalidades].self) { response in
                    switch response.result {
                    case .success(let catalogoCursosModalidades):
                        completion(.success(catalogoCursosModalidades))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoCursosModalidades(nuevoCatalogoCursosModalidades: CatalogoCursosModalidades, completion: @escaping (Result<CatalogoCursosModalidades, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdEmpresa":nuevoCatalogoCursosModalidades.IdEmpresa,
            "Fecha": nuevoCatalogoCursosModalidades.Fecha,
            "Nombre": nuevoCatalogoCursosModalidades.Nombre,
            "Notas": nuevoCatalogoCursosModalidades.Notas,
            "Observaciones": nuevoCatalogoCursosModalidades.Observaciones,
            "Status":nuevoCatalogoCursosModalidades.Status
           ]
        
           AF.request(baseURL + "/api/CatalogoCursosModalidades", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoCursosModalidades.self) { response in
                   switch response.result {
                   case .success(let catalogoCursosModalidades):
                       completion(.success(catalogoCursosModalidades))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

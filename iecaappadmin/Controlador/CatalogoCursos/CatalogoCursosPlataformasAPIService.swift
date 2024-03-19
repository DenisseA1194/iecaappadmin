//
//  CatalogoCursosPlataformas.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoCursosPlataformasAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoCursosPlataformasAPIService()
    private let baseURL = "http://webservices.iecapp.com"
    
    func editarCatalogoCursosPlataformas(catalogoCursosPlataformas: CatalogoCursosPlataformas, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/CatalogoCursosPlataformas/\(catalogoCursosPlataformas.Id)"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdEmpresa":catalogoCursosPlataformas.IdEmpresa,
            "Fecha": formattedDate,
            "Nombre": catalogoCursosPlataformas.Nombre,
            "Notas": catalogoCursosPlataformas.Notas,
            "Observaciones": catalogoCursosPlataformas.Observaciones,
            "Marca": catalogoCursosPlataformas.Marca,
            "LinkAcceso": catalogoCursosPlataformas.LinkAcceso,
            "Proveedor": catalogoCursosPlataformas.Proveedor,
            "Sincrona": catalogoCursosPlataformas.Sincrona,
            "Asincrona": catalogoCursosPlataformas.Asincrona,
            "Status":catalogoCursosPlataformas.Status
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

    
    func eliminarCatalogoCursosPlataformas(idCatalogoCursosPlataformas: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoCursosPlataformas/\(idCatalogoCursosPlataformas)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoCursosPlataformas(completion: @escaping (Result<[CatalogoCursosPlataformas], Error>) -> Void) {
            AF.request(baseURL+"/api/CatalogoCursosPlataformas?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoCursosPlataformas].self) { response in
                    switch response.result {
                    case .success(let catalogoCursosPlataformas):
                        completion(.success(catalogoCursosPlataformas))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoCursosPlataformas(nuevoCatalogoCursosPlataformas: CatalogoCursosPlataformas, completion: @escaping (Result<CatalogoCursosPlataformas, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdEmpresa":nuevoCatalogoCursosPlataformas.IdEmpresa,
            "Fecha": nuevoCatalogoCursosPlataformas.Fecha,
            "Nombre": nuevoCatalogoCursosPlataformas.Nombre,
            "Notas": nuevoCatalogoCursosPlataformas.Notas,
            "Observaciones": nuevoCatalogoCursosPlataformas.Observaciones,
            "Marca": nuevoCatalogoCursosPlataformas.Marca,
            "LinkAcceso": nuevoCatalogoCursosPlataformas.LinkAcceso,
            "Proveedor": nuevoCatalogoCursosPlataformas.Proveedor,
            "Sincrona": nuevoCatalogoCursosPlataformas.Sincrona,
            "Asincrona": nuevoCatalogoCursosPlataformas.Asincrona,
            "Status":nuevoCatalogoCursosPlataformas.Status
           ]
        
           AF.request(baseURL + "/api/CatalogoCursosPlataformas", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoCursosPlataformas.self) { response in
                   switch response.result {
                   case .success(let catalogoCursosPlataformas):
                       completion(.success(catalogoCursosPlataformas))
                      
                      
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

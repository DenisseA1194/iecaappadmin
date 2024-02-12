//
//  CatalogoCursosActividades.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoCursosActividadesAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoCursosActividadesAPIService()
    
    func editarCatalogoCursosActividades(catalogoCursosActividades: CatalogoCursosActividades, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoCursosActividades/\(catalogoCursosActividades.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdEmpresa":catalogoCursosActividades.IdEmpresa,
            "Fecha": formattedDate,
            "Nombre": catalogoCursosActividades.Nombre,
            "Notas": catalogoCursosActividades.Notas,
            "Observaciones": catalogoCursosActividades.Observaciones,
            "Status":catalogoCursosActividades.Status
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

    
    func eliminarCatalogoCursosActividades(idCatalogoCursosActividades: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoCursosActividades/\(idCatalogoCursosActividades)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoCursosActividades(completion: @escaping (Result<[CatalogoCursosActividades], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoCursosActividades?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoCursosActividades].self) { response in
                    switch response.result {
                    case .success(let catalogoCursosActividades):
                        completion(.success(catalogoCursosActividades))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoCursosActividades(nuevoCatalogoCursosActividades: CatalogoCursosActividades, completion: @escaping (Result<CatalogoCursosActividades, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdEmpresa":nuevoCatalogoCursosActividades.IdEmpresa,
            "Fecha": nuevoCatalogoCursosActividades.Fecha,
            "Nombre": nuevoCatalogoCursosActividades.Nombre,
            "Notas": nuevoCatalogoCursosActividades.Notas,
            "Observaciones": nuevoCatalogoCursosActividades.Observaciones,
            "Status":nuevoCatalogoCursosActividades.Status
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoCursosActividades", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoCursosActividades.self) { response in
                   switch response.result {
                   case .success(let catalogoCursosActividades):
                       completion(.success(catalogoCursosActividades))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


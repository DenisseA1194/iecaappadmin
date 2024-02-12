//
//  CatalogoCursosTipoBibliografia.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoCursosTipoBibliografiaAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoCursosTipoBibliografiaAPIService()
    
    func editarCatalogoCursosTipoBibliografia(catalogoCursosTipoBibliografia: CatalogoCursosTipoBibliografia, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoCursosTipoBibliografia/\(catalogoCursosTipoBibliografia.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdEmpresa":catalogoCursosTipoBibliografia.IdEmpresa,
            "Fecha": formattedDate,
            "Nombre": catalogoCursosTipoBibliografia.Nombre,
            "Notas": catalogoCursosTipoBibliografia.Notas,
            "Observaciones": catalogoCursosTipoBibliografia.Observaciones,
            "Status":catalogoCursosTipoBibliografia.Status
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

    
    func eliminarCatalogoCursosTipoBibliografia(idCatalogoCursosTipoBibliografia: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoCursosTipoBibliografia/\(idCatalogoCursosTipoBibliografia)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoCursosTipoBibliografia(completion: @escaping (Result<[CatalogoCursosTipoBibliografia], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoCursosTipoBibliografia?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoCursosTipoBibliografia].self) { response in
                    switch response.result {
                    case .success(let catalogoCursosTipoBibliografia):
                        completion(.success(catalogoCursosTipoBibliografia))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoCursosTipoBibliografia(nuevoCatalogoCursosTipoBibliografia: CatalogoCursosTipoBibliografia, completion: @escaping (Result<CatalogoCursosTipoBibliografia, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdEmpresa":nuevoCatalogoCursosTipoBibliografia.IdEmpresa,
            "Fecha": nuevoCatalogoCursosTipoBibliografia.Fecha,
            "Nombre": nuevoCatalogoCursosTipoBibliografia.Nombre,
            "Notas": nuevoCatalogoCursosTipoBibliografia.Notas,
            "Observaciones": nuevoCatalogoCursosTipoBibliografia.Observaciones,
            "Status":nuevoCatalogoCursosTipoBibliografia.Status
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoCursosTipoBibliografia", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoCursosTipoBibliografia.self) { response in
                   switch response.result {
                   case .success(let catalogoCursosTipoBibliografia):
                       completion(.success(catalogoCursosTipoBibliografia))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

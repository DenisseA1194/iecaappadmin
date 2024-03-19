//
//  CatalogoCursosCampoDeFormacion.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoCursosCampoDeFormacionAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoCursosCampoDeFormacionAPIService()
    private let baseURL = "http://webservices.iecapp.com"
    
    func editarCatalogoCursosCampoDeFormacion(catalogoCursosCampoDeFormacion: CatalogoCursosCampoDeFormacion, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/CatalogoCursosCampoDeFormacion/\(catalogoCursosCampoDeFormacion.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdEmpresa":catalogoCursosCampoDeFormacion.IdEmpresa,
            "Fecha": formattedDate,
            "Nombre": catalogoCursosCampoDeFormacion.Nombre,
            "Notas": catalogoCursosCampoDeFormacion.Notas,
            "Status":catalogoCursosCampoDeFormacion.Status
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

    
    func eliminarCatalogoCursosCampoDeFormacion(idCatalogoCursosCampoDeFormacion: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoCursosCampoDeFormacion/\(idCatalogoCursosCampoDeFormacion)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoCursosCampoDeFormacion(completion: @escaping (Result<[CatalogoCursosCampoDeFormacion], Error>) -> Void) {
            AF.request(baseURL + "/api/CatalogoCursosCampoDeFormacion?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoCursosCampoDeFormacion].self) { response in
                    switch response.result {
                    case .success(let catalogoCursosCampoDeFormacion):
                        completion(.success(catalogoCursosCampoDeFormacion))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoCursosCampoDeFormacion(nuevoCatalogoCursosCampoDeFormacion: CatalogoCursosCampoDeFormacion, completion: @escaping (Result<CatalogoCursosCampoDeFormacion, Error>) -> Void) {
           let parameters: [String: Any] = [
            "Id":nuevoCatalogoCursosCampoDeFormacion.Id,
            "IdEmpresa":nuevoCatalogoCursosCampoDeFormacion.IdEmpresa,
            "Fecha": nuevoCatalogoCursosCampoDeFormacion.Fecha,
            "Nombre": nuevoCatalogoCursosCampoDeFormacion.Nombre,
            "Notas": nuevoCatalogoCursosCampoDeFormacion.Notas,
            "Status":nuevoCatalogoCursosCampoDeFormacion.Status,
            "Borrado": nuevoCatalogoCursosCampoDeFormacion.Borrado
           ]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                print("JSON a enviar:")
                print(jsonString)
            }
        
           AF.request(baseURL + "/api/CatalogoCursosCampoDeFormacion", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoCursosCampoDeFormacion.self) { response in
                   switch response.result {
                   case .success(let catalogoCursosCampoDeFormacion):
                       completion(.success(catalogoCursosCampoDeFormacion))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

//
//  CatalogoCursosTipoConfidencialidad.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoCursosTipoConfidencialidadAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoCursosTipoConfidencialidadAPIService()
    
    func editarCatalogoCursosTipoConfidencialidad(catalogoCursosTipoConfidencialidad: CatalogoCursosTipoConfidencialidad, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoCursosTipoConfidencialidad/\(catalogoCursosTipoConfidencialidad.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdEmpresa":catalogoCursosTipoConfidencialidad.IdEmpresa,
            "Fecha": formattedDate,
            "Nombre": catalogoCursosTipoConfidencialidad.Nombre,
            "Notas": catalogoCursosTipoConfidencialidad.Notas,
            "Observaciones": catalogoCursosTipoConfidencialidad.Observaciones,
            "Status":catalogoCursosTipoConfidencialidad.Status
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

    
    func eliminarCatalogoCursosTipoConfidencialidad(idCatalogoCursosTipoConfidencialidad: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoCursosTipoConfidencialidad/\(idCatalogoCursosTipoConfidencialidad)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoCursosTipoConfidencialidad(completion: @escaping (Result<[CatalogoCursosTipoConfidencialidad], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoCursosTipoConfidencialidad?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoCursosTipoConfidencialidad].self) { response in
                    switch response.result {
                    case .success(let catalogoCursosTipoConfidencialidad):
                        completion(.success(catalogoCursosTipoConfidencialidad))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoCursosTipoConfidencialidad(nuevoCatalogoCursosTipoConfidencialidad: CatalogoCursosTipoConfidencialidad, completion: @escaping (Result<CatalogoCursosTipoConfidencialidad, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdEmpresa":nuevoCatalogoCursosTipoConfidencialidad.IdEmpresa,
            "Fecha": nuevoCatalogoCursosTipoConfidencialidad.Fecha,
            "Nombre": nuevoCatalogoCursosTipoConfidencialidad.Nombre,
            "Notas": nuevoCatalogoCursosTipoConfidencialidad.Notas,
            "Observaciones": nuevoCatalogoCursosTipoConfidencialidad.Observaciones,
            "Status":nuevoCatalogoCursosTipoConfidencialidad.Status
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoCursosTipoConfidencialidad", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoCursosTipoConfidencialidad.self) { response in
                   switch response.result {
                   case .success(let catalogoCursosTipoConfidencialidad):
                       completion(.success(catalogoCursosTipoConfidencialidad))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

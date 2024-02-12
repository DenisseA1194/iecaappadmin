//
//  CatalogoCursosInstrumentosEvaluacion.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoCursosInstrumentosEvaluacionAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoCursosInstrumentosEvaluacionAPIService()
    
    func editarCatalogoCursosInstrumentosEvaluacion(catalogoCursosInstrumentosEvaluacion: CatalogoCursosInstrumentosEvaluacion, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoCursosInstrumentosEvaluacion/\(catalogoCursosInstrumentosEvaluacion.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdEmpresa":catalogoCursosInstrumentosEvaluacion.IdEmpresa,
            "Fecha": formattedDate,
            "Nombre": catalogoCursosInstrumentosEvaluacion.Nombre
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

    
    func eliminarCatalogoCursosInstrumentosEvaluacion(idCatalogoCursosInstrumentosEvaluacion: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoCursosInstrumentosEvaluacion/\(idCatalogoCursosInstrumentosEvaluacion)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoCursosInstrumentosEvaluacion(completion: @escaping (Result<[CatalogoCursosInstrumentosEvaluacion], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoCursosInstrumentosEvaluacion?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoCursosInstrumentosEvaluacion].self) { response in
                    switch response.result {
                    case .success(let catalogoCursosInstrumentosEvaluacion):
                        completion(.success(catalogoCursosInstrumentosEvaluacion))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoCursosInstrumentosEvaluacion(nuevoCatalogoCursosInstrumentosEvaluacion: CatalogoCursosInstrumentosEvaluacion, completion: @escaping (Result<CatalogoCursosInstrumentosEvaluacion, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdEmpresa":nuevoCatalogoCursosInstrumentosEvaluacion.IdEmpresa,
            "Fecha": nuevoCatalogoCursosInstrumentosEvaluacion.Fecha,
            "Nombre": nuevoCatalogoCursosInstrumentosEvaluacion.Nombre
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoCursosInstrumentosEvaluacion", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoCursosInstrumentosEvaluacion.self) { response in
                   switch response.result {
                   case .success(let catalogoCursosInstrumentosEvaluacion):
                       completion(.success(catalogoCursosInstrumentosEvaluacion))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

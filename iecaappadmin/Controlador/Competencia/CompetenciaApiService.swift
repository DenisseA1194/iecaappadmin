//
//  CatalogoCursosActividades.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CompetenciaAPIService {
  
    private let webService = WebService()
    static let shared = CompetenciaAPIService()
    private let baseURL = "http://webservices.iecapp.com"
    
    func editarCompetencia(competencia: Competencia, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/CatalogoCursosCompetencias?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Id":competencia.Id,
            "IdEmpresa": competencia.IdEmpresa,
            "Fecha": competencia.Fecha,
            "Nombre": competencia.Nombre,
            "Notas": competencia.Notas,
            "Observaciones": competencia.Observaciones,
            "Borrado": competencia.Borrado,
            "Status": competencia.Status
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

    
    func eliminarCompetencia(idCompetencia: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoCursosCompetencias/\(idCompetencia)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCompetencias(completion: @escaping (Result<[Competencia], Error>) -> Void) {
            let ruta = baseURL + "/api/CatalogoCursosCompetencias?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
            AF.request(ruta)
                .validate()
                .responseDecodable(of: [Competencia].self) { response in
                    switch response.result {
                    case .success(let competencia):
                        completion(.success(competencia))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCompetencia(nuevaCompetencia: Competencia, completion: @escaping (Result<Competencia, Error>) -> Void) {
           let parameters: [String: Any] = [
            "Id":nuevaCompetencia.Id,
            "IdEmpresa": nuevaCompetencia.IdEmpresa,
            "Fecha": nuevaCompetencia.Fecha,
            "Nombre": nuevaCompetencia.Nombre,
            "Notas": nuevaCompetencia.Notas,
            "Observaciones": nuevaCompetencia.Observaciones,
            "Borrado": nuevaCompetencia.Borrado,
            "Status": nuevaCompetencia.Status,
           ]
        
           AF.request(baseURL + "/api/CatalogoCursosCompetencias", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: Competencia.self) { response in
                   switch response.result {
                   case .success(let competencias):
                       completion(.success(competencias))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


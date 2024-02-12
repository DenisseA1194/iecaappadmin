//
//  CursosCompetenciasaDesarrollar.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire



class CursosCompetenciasaDesarrollarAPIService {
  
    private let webService = WebService()
        static let shared = CursosCompetenciasaDesarrollarAPIService()
    
    func editarCursosCompetenciasaDesarrollar(cursosCompetenciasaDesarrollar: CursosCompetenciasaDesarrollar, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CursosCompetenciasaDesarrollar/\(cursosCompetenciasaDesarrollar.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": cursosCompetenciasaDesarrollar.Nombre,
            "Fecha": formattedDate,
            "IdEmpresa":cursosCompetenciasaDesarrollar.IdEmpresa
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

    
    func eliminarCursosCompetenciasaDesarrollar(idCursosCompetenciasaDesarrollar: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CursosCompetenciasaDesarrollar/\(idCursosCompetenciasaDesarrollar)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCursosCompetenciasaDesarrollar(completion: @escaping (Result<[CursosCompetenciasaDesarrollar], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CursosCompetenciasaDesarrollar?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CursosCompetenciasaDesarrollar].self) { response in
                    switch response.result {
                    case .success(let cursosCompetenciasaDesarrollar):
                        completion(.success(cursosCompetenciasaDesarrollar))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCursosCompetenciasaDesarrollar(nuevoCursosCompetenciasaDesarrollar: CursosCompetenciasaDesarrollar, completion: @escaping (Result<CursosCompetenciasaDesarrollar, Error>) -> Void) {
           let parameters: [String: Any] = [
            "Nombre": nuevoCursosCompetenciasaDesarrollar.Nombre,
            "Fecha": nuevoCursosCompetenciasaDesarrollar.Fecha,
            "IdEmpresa":nuevoCursosCompetenciasaDesarrollar.IdEmpresa
           ]
        
           AF.request(webService.getBaseURL() + "/api/CursosCompetenciasaDesarrollar", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CursosCompetenciasaDesarrollar.self) { response in
                   switch response.result {
                   case .success(let cursosCompetenciasaDesarrollar):
                       completion(.success(cursosCompetenciasaDesarrollar))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}



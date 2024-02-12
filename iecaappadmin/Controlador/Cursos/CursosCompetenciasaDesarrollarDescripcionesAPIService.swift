//
//  CursosCompetenciasaDesarrollarDescripciones.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire



class CursosCompetenciasaDesarrollarDescripcionesAPIService {
  
    private let webService = WebService()
        static let shared = CursosCompetenciasaDesarrollarDescripcionesAPIService()
    
    func editarCursosCompetenciasaDesarrollarDescripciones(cursosCompetenciasaDesarrollarDescripciones: CursosCompetenciasaDesarrollarDescripciones, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CursosCompetenciasaDesarrollarDescripciones/\(cursosCompetenciasaDesarrollarDescripciones.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": cursosCompetenciasaDesarrollarDescripciones.Nombre,
            "Fecha": formattedDate,
            "IdEmpresa":cursosCompetenciasaDesarrollarDescripciones.IdEmpresa,
            "IdCursosCompetenciasaDesarrollar": cursosCompetenciasaDesarrollarDescripciones.IdCursosCompetenciasaDesarrollar,
            "Notas": cursosCompetenciasaDesarrollarDescripciones.Notas,
            "Observaciones":cursosCompetenciasaDesarrollarDescripciones.Observaciones
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

    
    func eliminarCursosCompetenciasaDesarrollarDescripciones(idCursosCompetenciasaDesarrollarDescripciones: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CursosCompetenciasaDesarrollarDescripciones/\(idCursosCompetenciasaDesarrollarDescripciones)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCursosCompetenciasaDesarrollarDescripciones(completion: @escaping (Result<[CursosCompetenciasaDesarrollarDescripciones], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CursosCompetenciasaDesarrollarDescripciones?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CursosCompetenciasaDesarrollarDescripciones].self) { response in
                    switch response.result {
                    case .success(let cursosCompetenciasaDesarrollarDescripciones):
                        completion(.success(cursosCompetenciasaDesarrollarDescripciones))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCursosCompetenciasaDesarrollarDescripciones(nuevoCursosCompetenciasaDesarrollarDescripciones: CursosCompetenciasaDesarrollarDescripciones, completion: @escaping (Result<CursosCompetenciasaDesarrollarDescripciones, Error>) -> Void) {
           let parameters: [String: Any] = [
            "Nombre": nuevoCursosCompetenciasaDesarrollarDescripciones.Nombre,
            "Fecha": nuevoCursosCompetenciasaDesarrollarDescripciones.Fecha,
            "IdEmpresa":nuevoCursosCompetenciasaDesarrollarDescripciones.IdEmpresa,
            "IdCursosCompetenciasaDesarrollar": nuevoCursosCompetenciasaDesarrollarDescripciones.IdCursosCompetenciasaDesarrollar,
            "Notas": nuevoCursosCompetenciasaDesarrollarDescripciones.Notas,
            "Observaciones":nuevoCursosCompetenciasaDesarrollarDescripciones.Observaciones
           ]
        
           AF.request(webService.getBaseURL() + "/api/CursosCompetenciasaDesarrollarDescripciones", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CursosCompetenciasaDesarrollarDescripciones.self) { response in
                   switch response.result {
                   case .success(let cursosCompetenciasaDesarrollarDescripciones):
                       completion(.success(cursosCompetenciasaDesarrollarDescripciones))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}






//
//  CursosCompetencias.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire



class CursosCompetenciasAPIService {
  
    private let webService = WebService()
        static let shared = CursosCompetenciasAPIService()
    
    func editarCursosCompetencias(cursosCompetencias: CursosCompetencias, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CursosCompetencias/\(cursosCompetencias.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdEmpresa": cursosCompetencias.IdEmpresa,
            "Nombre":cursosCompetencias.Nombre,
            "Fecha": formattedDate,
            "IdCompetencia": cursosCompetencias.IdCompetencia,
            "IdCompetenciaDetalle": cursosCompetencias.IdCompetenciaDetalle,
            "Observaciones": cursosCompetencias.Observaciones,
            "IdCurso":cursosCompetencias.IdCurso,
            "Notas": cursosCompetencias.Notas
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

    
    func eliminarCursosCompetencias(idCursosCompetencias: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CursosCompetencias/\(idCursosCompetencias)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCursosCompetencias(completion: @escaping (Result<[CursosCompetencias], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CursosCompetencias?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CursosCompetencias].self) { response in
                    switch response.result {
                    case .success(let cursosCompetencias):
                        completion(.success(cursosCompetencias))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCursosCompetencias(nuevoCursosCompetencias: CursosCompetencias, completion: @escaping (Result<CursosCompetencias, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdEmpresa": nuevoCursosCompetencias.IdEmpresa,
            "Nombre":nuevoCursosCompetencias.Nombre,
            "Fecha": nuevoCursosCompetencias.Fecha,
            "IdCompetencia": nuevoCursosCompetencias.IdCompetencia,
            "IdCompetenciaDetalle": nuevoCursosCompetencias.IdCompetenciaDetalle,
            "Observaciones": nuevoCursosCompetencias.Observaciones,
            "IdCurso":nuevoCursosCompetencias.IdCurso,
            "Notas": nuevoCursosCompetencias.Notas
           ]
        
           AF.request(webService.getBaseURL() + "/api/CursosCompetencias", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CursosCompetencias.self) { response in
                   switch response.result {
                   case .success(let cursosCompetencias):
                       completion(.success(cursosCompetencias))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}



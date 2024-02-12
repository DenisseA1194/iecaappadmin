//
//  CursosEvaluaciones.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire



class CursosEvaluacionesAPIService {
  
    private let webService = WebService()
        static let shared = CursosEvaluacionesAPIService()
    
    func editarCursosEvaluaciones(cursosEvaluaciones: CursosEvaluaciones, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CursosEvaluaciones/\(cursosEvaluaciones.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Fecha": formattedDate,
            "IdEmpresa": cursosEvaluaciones.IdEmpresa,
            "IdCurso":cursosEvaluaciones.IdCurso,
            "IdLista": cursosEvaluaciones.IdLista,
            "Status": cursosEvaluaciones.Status,
            "Observaciones": cursosEvaluaciones.Observaciones,
            "Notas":cursosEvaluaciones.Notas,
            "Link": cursosEvaluaciones.Link
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

    
    func eliminarCursosEvaluaciones(idCursosEvaluaciones: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CursosEvaluaciones/\(idCursosEvaluaciones)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCursosEvaluaciones(completion: @escaping (Result<[CursosEvaluaciones], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/cursosEvaluaciones?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CursosEvaluaciones].self) { response in
                    switch response.result {
                    case .success(let cursosEvaluaciones):
                        completion(.success(cursosEvaluaciones))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCursosEvaluaciones(nuevoCursosEvaluaciones: CursosEvaluaciones, completion: @escaping (Result<CursosEvaluaciones, Error>) -> Void) {
           let parameters: [String: Any] = [
            "Fecha": nuevoCursosEvaluaciones.Fecha,
            "IdEmpresa": nuevoCursosEvaluaciones.IdEmpresa,
            "IdCurso":nuevoCursosEvaluaciones.IdCurso,
            "IdLista": nuevoCursosEvaluaciones.IdLista,
            "Status": nuevoCursosEvaluaciones.Status,
            "Observaciones": nuevoCursosEvaluaciones.Observaciones,
            "Notas":nuevoCursosEvaluaciones.Notas,
            "Link": nuevoCursosEvaluaciones.Link
           ]
        
           AF.request(webService.getBaseURL() + "/api/CursosEvaluaciones", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CursosEvaluaciones.self) { response in
                   switch response.result {
                   case .success(let cursosEvaluaciones):
                       completion(.success(cursosEvaluaciones))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}



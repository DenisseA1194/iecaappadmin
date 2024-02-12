//
//  CursosEquipos.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire



class CursosEquiposAPIService {
  
    private let webService = WebService()
        static let shared = CursosEquiposAPIService()
    
    func editarCursosEquipos(cursosEquipos: CursosEquipos, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CursosEquipos/\(cursosEquipos.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": cursosEquipos.Nombre,
            "IdCurso": cursosEquipos.IdCurso,
            "IdEquipo":cursosEquipos.IdEquipo,
            "Fecha": formattedDate,
            "Link": cursosEquipos.Link,
            "Notas": cursosEquipos.Notas,
            "Observaciones":cursosEquipos.Observaciones,
            "IdEmpresa": cursosEquipos.IdEmpresa
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

    
    func eliminarCursosEquipos(idCursosEquipos: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CursosEquipos/\(idCursosEquipos)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCursosEquipos(completion: @escaping (Result<[CursosEquipos], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CursosEquipos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CursosEquipos].self) { response in
                    switch response.result {
                    case .success(let cursosEquipos):
                        completion(.success(cursosEquipos))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCursosEquipos(nuevoCursosEquipos: CursosEquipos, completion: @escaping (Result<CursosEquipos, Error>) -> Void) {
           let parameters: [String: Any] = [
            "Nombre": nuevoCursosEquipos.Nombre,
            "IdCurso": nuevoCursosEquipos.IdCurso,
            "IdEquipo":nuevoCursosEquipos.IdEquipo,
            "Fecha": nuevoCursosEquipos.Fecha,
            "Link": nuevoCursosEquipos.Link,
            "Notas": nuevoCursosEquipos.Notas,
            "Observaciones":nuevoCursosEquipos.Observaciones,
            "IdEmpresa": nuevoCursosEquipos.IdEmpresa
           ]
        
           AF.request(webService.getBaseURL() + "/api/CursosEquipos", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CursosEquipos.self) { response in
                   switch response.result {
                   case .success(let cursosEquipos):
                       completion(.success(cursosEquipos))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}



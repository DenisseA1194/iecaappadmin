//
//  CursosCreadores.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire


class CursosCreadoresAPIService {
  
    private let webService = WebService()
        static let shared = CursosCreadoresAPIService()
    
    func editarCursosCreadores(cursosCreadores: CursosCreadores, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CursosCreadores/\(cursosCreadores.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdCurso": cursosCreadores.IdCurso,
            "IdCreador":cursosCreadores.IdCreador,
            "Notas": cursosCreadores.Notas,
            "Observaciones": cursosCreadores.Observaciones,
            "Version": cursosCreadores.Version,
            "LinkDocs":cursosCreadores.LinkDocs,
            "Fecha": formattedDate,
            "IdEmpresa": cursosCreadores.IdEmpresa
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

    
    func eliminarCursosCreadores(idCursosCreadores: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CursosCreadores/\(idCursosCreadores)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCursosCreadores(completion: @escaping (Result<[CursosCreadores], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CursosCreadores?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CursosCreadores].self) { response in
                    switch response.result {
                    case .success(let cursosCreadores):
                        completion(.success(cursosCreadores))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCursosCreadores(nuevoCursosCreadores: CursosCreadores, completion: @escaping (Result<CursosCreadores, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdCurso": nuevoCursosCreadores.IdCurso,
            "IdCreador":nuevoCursosCreadores.IdCreador,
            "Notas": nuevoCursosCreadores.Notas,
            "Observaciones": nuevoCursosCreadores.Observaciones,
            "Version": nuevoCursosCreadores.Version,
            "LinkDocs":nuevoCursosCreadores.LinkDocs,
            "Fecha": nuevoCursosCreadores.Fecha,
            "IdEmpresa": nuevoCursosCreadores.IdEmpresa
           ]
        
           AF.request(webService.getBaseURL() + "/api/CursosCreadores", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CursosCreadores.self) { response in
                   switch response.result {
                   case .success(let cursosCreadores):
                       completion(.success(cursosCreadores))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}



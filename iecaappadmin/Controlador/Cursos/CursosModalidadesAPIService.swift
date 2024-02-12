//
//  CursosModalidades.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire



class CursosModalidadesAPIService {
  
    private let webService = WebService()
        static let shared = CursosModalidadesAPIService()
    
    func editarCursosModalidades(cursosModalidades: CursosModalidades, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CursosModalidades/\(cursosModalidades.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdCurso": cursosModalidades.IdCurso,
            "IdModalidad":cursosModalidades.IdModalidad,
            "Notas": cursosModalidades.Notas,
            "Observaciones": cursosModalidades.Observaciones,
            "Fecha": formattedDate,
            "IdEmpresa": cursosModalidades.IdEmpresa
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

    
    func eliminarCursosModalidades(idCursosModalidades: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CursosModalidades/\(idCursosModalidades)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCursosModalidades(completion: @escaping (Result<[CursosModalidades], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CursosModalidades?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CursosModalidades].self) { response in
                    switch response.result {
                    case .success(let cursosModalidades):
                        completion(.success(cursosModalidades))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCursosModalidades(nuevoCursosModalidades: CursosModalidades, completion: @escaping (Result<CursosModalidades, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdCurso": nuevoCursosModalidades.IdCurso,
            "IdModalidad":nuevoCursosModalidades.IdModalidad,
            "Notas": nuevoCursosModalidades.Notas,
            "Observaciones": nuevoCursosModalidades.Observaciones,
            "Fecha": nuevoCursosModalidades.Fecha,
            "IdEmpresa": nuevoCursosModalidades.IdEmpresa
           ]
        
           AF.request(webService.getBaseURL() + "/api/CursosModalidades", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CursosModalidades.self) { response in
                   switch response.result {
                   case .success(let cursosModalidades):
                       completion(.success(cursosModalidades))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}



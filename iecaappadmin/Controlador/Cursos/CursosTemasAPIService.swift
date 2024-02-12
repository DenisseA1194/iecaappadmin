//
//  CursosTemas.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire



class CursosTemasAPIService {
  
    private let webService = WebService()
        static let shared = CursosTemasAPIService()
    
    func editarCursosTemas(cursosTemas: CursosTemas, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CursosTemas/\(cursosTemas.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Fecha": formattedDate,
            "IdEmpresa": cursosTemas.IdEmpresa,
            "Notas":cursosTemas.Notas,
            "Observaciones": cursosTemas.Observaciones,
            "IdCurso": cursosTemas.IdCurso,
            "IdTema": cursosTemas.IdTema,
            "Horas":cursosTemas.Horas
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

    
    func eliminarCursosTemas(idCursosTemas: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CursosTemas/\(idCursosTemas)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCursosTemas(completion: @escaping (Result<[CursosTemas], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CursosTemas?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CursosTemas].self) { response in
                    switch response.result {
                    case .success(let cursosTemas):
                        completion(.success(cursosTemas))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCursosTemas(nuevoCursosTemas: CursosTemas, completion: @escaping (Result<CursosTemas, Error>) -> Void) {
           let parameters: [String: Any] = [
            "Fecha": nuevoCursosTemas.Fecha,
            "IdEmpresa": nuevoCursosTemas.IdEmpresa,
            "Notas":nuevoCursosTemas.Notas,
            "Observaciones": nuevoCursosTemas.Observaciones,
            "IdCurso": nuevoCursosTemas.IdCurso,
            "IdTema": nuevoCursosTemas.IdTema,
            "Horas":nuevoCursosTemas.Horas
           ]
        
           AF.request(webService.getBaseURL() + "/api/CursosTemas", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CursosTemas.self) { response in
                   switch response.result {
                   case .success(let cursosTemas):
                       completion(.success(cursosTemas))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


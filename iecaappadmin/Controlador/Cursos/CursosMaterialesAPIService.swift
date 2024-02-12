//
//  CursosMateriales.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire



class CursosMaterialesAPIService {
  
    private let webService = WebService()
        static let shared = CursosMaterialesAPIService()
    
    func editarCursosMateriales(cursosMateriales: CursosMateriales, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CursosMateriales/\(cursosMateriales.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": cursosMateriales.Nombre,
            "IdCurso":cursosMateriales.IdCurso,
            "IdMaterial": cursosMateriales.IdMaterial,
            "Fecha": formattedDate,
            "Notas": cursosMateriales.Notas,
            "Observaciones": cursosMateriales.Observaciones,
            "IdEmpresa":cursosMateriales.IdEmpresa
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

    
    func eliminarCursosMateriales(idCursosMateriales: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CursosMateriales/\(idCursosMateriales)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCursosMateriales(completion: @escaping (Result<[CursosMateriales], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CursosMateriales?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CursosMateriales].self) { response in
                    switch response.result {
                    case .success(let cursosMateriales):
                        completion(.success(cursosMateriales))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCursosMateriales(nuevoCursosMateriales: CursosMateriales, completion: @escaping (Result<CursosMateriales, Error>) -> Void) {
           let parameters: [String: Any] = [
            "Nombre": nuevoCursosMateriales.Nombre,
            "IdCurso":nuevoCursosMateriales.IdCurso,
            "IdMaterial": nuevoCursosMateriales.IdMaterial,
            "Fecha": nuevoCursosMateriales.Fecha,
            "Notas": nuevoCursosMateriales.Notas,
            "Observaciones": nuevoCursosMateriales.Observaciones,
            "IdEmpresa":nuevoCursosMateriales.IdEmpresa
           ]
        
           AF.request(webService.getBaseURL() + "/api/CursosMateriales", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CursosMateriales.self) { response in
                   switch response.result {
                   case .success(let cursosMateriales):
                       completion(.success(cursosMateriales))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}



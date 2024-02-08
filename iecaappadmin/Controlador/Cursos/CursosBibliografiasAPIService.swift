//
//  CursosBibliografias.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire



class CursosBiografiasAPIService {
  
    private let webService = WebService()
        static let shared = CursosBiografiasAPIService()
    
    func editarCursosBiografias(cursosBiografias: CursosBiografias, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CursosBiografias/\(cursosBiografias.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": cursosBiografias.Nombre,
            "IdCurso":cursosBiografias.IdCurso,
            "IdActividad": cursosBiografias.IdActividad,
            "Notas": cursosBiografias.Notas,
            "Autor": cursosBiografias.Autor,
            "Observaciones":cursosBiografias.Observaciones,
            "Fecha": formattedDate,
            "IdEmpresa": cursosBiografias.IdEmpresa,
            "Link": cursosBiografias.Link,
            "IdTipoBibliografia": cursosBiografias.IdTipoBibliografia
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

    
    func eliminarCursosBiografias(idCursosBiografias: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CursosBiografias/\(idCursosBiografias)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCursosBiografias(completion: @escaping (Result<[CursosBiografias], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CursosBiografias?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CursosBiografias].self) { response in
                    switch response.result {
                    case .success(let cursosBiografias):
                        completion(.success(cursosBiografias))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCursosBiografias(nuevoCursosBiografias: CursosBiografias, completion: @escaping (Result<CursosBiografias, Error>) -> Void) {
           let parameters: [String: Any] = [
            "Nombre": nuevoCursosBiografias.Nombre,
            "IdCurso":nuevoCursosBiografias.IdCurso,
            "IdActividad": nuevoCursosBiografias.IdActividad,
            "Notas": nuevoCursosBiografias.Notas,
            "Autor": nuevoCursosBiografias.Autor,
            "Observaciones":nuevoCursosBiografias.Observaciones,
            "Fecha": nuevoCursosBiografias.Fecha,
            "IdEmpresa": nuevoCursosBiografias.IdEmpresa,
            "Link": nuevoCursosBiografias.Link,
            "IdTipoBibliografia": nuevoCursosBiografias.IdTipoBibliografia
           ]
        
           AF.request(webService.getBaseURL() + "/api/CursosBiografias", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CursosBiografias.self) { response in
                   switch response.result {
                   case .success(let cursosBiografias):
                       completion(.success(cursosBiografias))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}



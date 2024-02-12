//
//  CursosDocumentacion.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire



class CursosDocumentacionAPIService {
  
    private let webService = WebService()
        static let shared = CursosDocumentacionAPIService()
    
    func editarCursosDocumentacion(cursosDocumentacion: CursosDocumentacion, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CursosDocumentacion/\(cursosDocumentacion.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdCurso": cursosDocumentacion.IdCurso,
            "IdEmpresa":cursosDocumentacion.IdEmpresa,
            "Nombre": cursosDocumentacion.Nombre,
            "Fecha": formattedDate,
            "LinkDocumento": cursosDocumentacion.LinkDocumento,
            "Notas": cursosDocumentacion.Notas,
            "Referencias":cursosDocumentacion.Referencias
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

    
    func eliminarCursosDocumentacion(idCursosDocumentacion: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CursosDocumentacion/\(idCursosDocumentacion)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCursosDocumentacion(completion: @escaping (Result<[CursosDocumentacion], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CursosDocumentacion?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CursosDocumentacion].self) { response in
                    switch response.result {
                    case .success(let cursosDocumentacion):
                        completion(.success(cursosDocumentacion))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCursosDocumentacion(nuevoCursosDocumentacion: CursosDocumentacion, completion: @escaping (Result<CursosDocumentacion, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdCurso": nuevoCursosDocumentacion.IdCurso,
            "IdEmpresa":nuevoCursosDocumentacion.IdEmpresa,
            "Nombre": nuevoCursosDocumentacion.Nombre,
            "Fecha": nuevoCursosDocumentacion.Fecha,
            "LinkDocumento": nuevoCursosDocumentacion.LinkDocumento,
            "Notas": nuevoCursosDocumentacion.Notas,
            "Referencias":nuevoCursosDocumentacion.Referencias
           ]
        
           AF.request(webService.getBaseURL() + "/api/CursosDocumentacion", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CursosDocumentacion.self) { response in
                   switch response.result {
                   case .success(let cursosDocumentacion):
                       completion(.success(cursosDocumentacion))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}



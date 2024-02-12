//
//  CursosTipoCliente.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire



class CursosTipoClienteAPIService {
  
    private let webService = WebService()
        static let shared = CursosTipoClienteAPIService()
    
    func editarCursosTipoCliente(cursosTipoCliente: CursosTipoCliente, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CursosTipoCliente/\(cursosTipoCliente.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdCurso": cursosTipoCliente.IdCurso,
            "IdTipoCliente":cursosTipoCliente.IdTipoCliente,
            "Observaciones": cursosTipoCliente.Observaciones,
            "Notas": cursosTipoCliente.Notas,
            "Status": cursosTipoCliente.Status,
            "Fecha": formattedDate,
            "IdEmpresa":cursosTipoCliente.IdEmpresa
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

    
    func eliminarCursosTipoCliente(idCursosTipoCliente: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CursosTipoCliente/\(idCursosTipoCliente)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCursosTipoCliente(completion: @escaping (Result<[CursosTipoCliente], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CursosTipoCliente?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CursosTipoCliente].self) { response in
                    switch response.result {
                    case .success(let cursosTipoCliente):
                        completion(.success(cursosTipoCliente))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCursosTipoCliente(nuevoCursosTipoCliente: CursosTipoCliente, completion: @escaping (Result<CursosTipoCliente, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdCurso": nuevoCursosTipoCliente.IdCurso,
            "IdTipoCliente":nuevoCursosTipoCliente.IdTipoCliente,
            "Observaciones": nuevoCursosTipoCliente.Observaciones,
            "Notas": nuevoCursosTipoCliente.Notas,
            "Status": nuevoCursosTipoCliente.Status,
            "Fecha": nuevoCursosTipoCliente.Fecha,
            "IdEmpresa":nuevoCursosTipoCliente.IdEmpresa
           ]
        
           AF.request(webService.getBaseURL() + "/api/CursosTipoCliente", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CursosTipoCliente.self) { response in
                   switch response.result {
                   case .success(let cursosTipoCliente):
                       completion(.success(cursosTipoCliente))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}



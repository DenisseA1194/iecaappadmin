//
//  CursosAutorizaciones.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire



class CursosAutorizacionesAPIService {
  
    private let webService = WebService()
        static let shared = CursosAutorizacionesAPIService()
    
    func editarCursosAutorizaciones(cursosAutorizaciones: CursosAutorizaciones, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CursosAutorizaciones/\(cursosAutorizaciones.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdCurso": cursosAutorizaciones.IdCurso,
            "IdUsuario":cursosAutorizaciones.IdUsuario,
            "FechaOperacion": formattedDate,
            "Elabora": cursosAutorizaciones.Elabora,
            "Revisa": cursosAutorizaciones.Revisa,
            "Valida": cursosAutorizaciones.Valida,
            "Aprueba":cursosAutorizaciones.Aprueba,
            "Autoriza": cursosAutorizaciones.Autoriza,
            "Notas": cursosAutorizaciones.Notas,
            "Observaciones": cursosAutorizaciones.Observaciones,
            "Fecha": formattedDate,
            "IdEmpresa":cursosAutorizaciones.IdEmpresa
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

    
    func eliminarCursosAutorizaciones(idCursosAutorizaciones: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CursosAutorizaciones/\(idCursosAutorizaciones)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCursosAutorizaciones(completion: @escaping (Result<[CursosAutorizaciones], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CursosAutorizaciones?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CursosAutorizaciones].self) { response in
                    switch response.result {
                    case .success(let cursosAutorizaciones):
                        completion(.success(cursosAutorizaciones))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCursosAutorizaciones(nuevoCursosAutorizaciones: CursosAutorizaciones, completion: @escaping (Result<CursosAutorizaciones, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdCurso": nuevoCursosAutorizaciones.IdCurso,
            "IdUsuario":nuevoCursosAutorizaciones.IdUsuario,
            "FechaOperacion": nuevoCursosAutorizaciones.FechaOperacion,
            "Elabora": nuevoCursosAutorizaciones.Elabora,
            "Revisa": nuevoCursosAutorizaciones.Revisa,
            "Valida": nuevoCursosAutorizaciones.Valida,
            "Aprueba":nuevoCursosAutorizaciones.Aprueba,
            "Autoriza": nuevoCursosAutorizaciones.Autoriza,
            "Notas": nuevoCursosAutorizaciones.Notas,
            "Observaciones": nuevoCursosAutorizaciones.Observaciones,
            "Fecha": nuevoCursosAutorizaciones.Fecha,
            "IdEmpresa":nuevoCursosAutorizaciones.IdEmpresa
           ]
        
           AF.request(webService.getBaseURL() + "/api/CursosAutorizaciones", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CursosAutorizaciones.self) { response in
                   switch response.result {
                   case .success(let cursosAutorizaciones):
                       completion(.success(cursosAutorizaciones))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}



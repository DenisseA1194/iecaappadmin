//
//  File20.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class CursosActividadesAPIService {
  
    private let webService = WebService()
        static let shared = CursosActividadesAPIService()
    
    func editarCursosActividades(cursosActividades: CursosActividades, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CursosActividades/\(cursosActividades.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdEmpresa": cursosActividades.IdEmpresa,
            "Nombre":cursosActividades.Nombre,
            "Fecha": formattedDate,
            "Notas": cursosActividades.Notas,
            "Observaciones": cursosActividades.Observaciones,
            "IdCurso":cursosActividades.IdCurso,
            "IdActividad": cursosActividades.IdActividad,
            "Link": cursosActividades.Link
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

    
    func eliminarCursosActividades(idCursosActividades: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CursosActividades/\(idCursosActividades)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCursosActividades(completion: @escaping (Result<[CursosActividades], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CursosActividades?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CursosActividades].self) { response in
                    switch response.result {
                    case .success(let cursosActividades):
                        completion(.success(cursosActividades))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCursosActividades(nuevoCursosActividades: CursosActividades, completion: @escaping (Result<CursosActividades, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdEmpresa": nuevoCursosActividades.IdEmpresa,
            "Nombre":nuevoCursosActividades.Nombre,
            "Fecha": nuevoCursosActividades.Fecha,
            "Notas": nuevoCursosActividades.Notas,
            "Observaciones": nuevoCursosActividades.Observaciones,
            "IdCurso":nuevoCursosActividades.IdCurso,
            "IdActividad": nuevoCursosActividades.IdActividad,
            "Link": nuevoCursosActividades.Link
           ]
        
           AF.request(webService.getBaseURL() + "/api/CursosActividades", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CursosActividades.self) { response in
                   switch response.result {
                   case .success(let cursosActividades):
                       completion(.success(cursosActividades))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


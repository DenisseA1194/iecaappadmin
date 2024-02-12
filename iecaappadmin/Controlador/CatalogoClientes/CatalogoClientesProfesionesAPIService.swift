//
//  CatalogoClientesProfesiones.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoClientesProfesionesAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoClientesProfesionesAPIService()
    
    func editarCatalogoClientesProfesiones(catalogoClientesProfesiones: CatalogoClientesProfesiones, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoClientesProfesiones/\(catalogoClientesProfesiones.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoClientesProfesiones.Nombre,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoClientesProfesiones.IdEmpresa
            
         
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

    
    func eliminarCatalogoClientesProfesiones(idCatalogoClientesProfesiones: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoClientesProfesiones/\(idCatalogoClientesProfesiones)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoClientesProfesiones(completion: @escaping (Result<[CatalogoClientesProfesiones], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoClientesProfesiones?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoClientesProfesiones].self) { response in
                    switch response.result {
                    case .success(let catalogoClientesProfesiones):
                        completion(.success(catalogoClientesProfesiones))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoClientesProfesiones(nuevoCatalogoClientesProfesiones: CatalogoClientesProfesiones, completion: @escaping (Result<CatalogoClientesProfesiones, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoClientesProfesiones.Nombre,
               "Fecha":nuevoCatalogoClientesProfesiones.Fecha,
               "IdEmpresa":nuevoCatalogoClientesProfesiones.IdEmpresa
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoClientesProfesiones", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoClientesProfesiones.self) { response in
                   switch response.result {
                   case .success(let catalogoClientesProfesiones):
                       completion(.success(catalogoClientesProfesiones))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

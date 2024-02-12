//
//  CatalogoClientesDepartamentos.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoClientesDepartamentosAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoClientesDepartamentosAPIService()
    
    func editarCatalogoClientesDepartamentos(catalogoClientesDepartamentos: CatalogoClientesDepartamentos, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoClientesDepartamentos/\(catalogoClientesDepartamentos.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoClientesDepartamentos.Nombre,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoClientesDepartamentos.IdEmpresa
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

    
    func eliminarCatalogoClientesDepartamentos(idCatalogoClientesDepartamentos: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoClientesDepartamentos/\(idCatalogoClientesDepartamentos)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoClientesDepartamentos(completion: @escaping (Result<[CatalogoClientesDepartamentos], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoClientesDepartamentos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoClientesDepartamentos].self) { response in
                    switch response.result {
                    case .success(let catalogoClientesDepartamentos):
                        completion(.success(catalogoClientesDepartamentos))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoClientesDepartamentos(nuevoCatalogoClientesDepartamentos: CatalogoClientesDepartamentos, completion: @escaping (Result<CatalogoClientesDepartamentos, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoClientesDepartamentos.Nombre,
               "Fecha":nuevoCatalogoClientesDepartamentos.Fecha,
               "IdEmpresa":nuevoCatalogoClientesDepartamentos.IdEmpresa
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoClientesDepartamentos", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoClientesDepartamentos.self) { response in
                   switch response.result {
                   case .success(let catalogoClientesDepartamentos):
                       completion(.success(catalogoClientesDepartamentos))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


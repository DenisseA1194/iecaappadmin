//
//  CatalogoClientesGradoDeEstudios.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoClientesGradoDeEstudiosAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoClientesGradoDeEstudiosAPIService()
    
    func editarCatalogoClientesGradoDeEstudios(catalogoClientesGradoDeEstudios: CatalogoClientesGradoDeEstudios, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoClientesGradoDeEstudios/\(catalogoClientesGradoDeEstudios.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoClientesGradoDeEstudios.Nombre,
            "Fecha": formattedDate,
            "IdSupervisor":catalogoClientesGradoDeEstudios.IdSupervisor,
            "IdEmpresa":catalogoClientesGradoDeEstudios.IdEmpresa
            
         
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

    
    func eliminarCatalogoClientesGradoDeEstudios(idCatalogoClientesGradoDeEstudios: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoClientesGradoDeEstudios/\(idCatalogoClientesGradoDeEstudios)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoClientesGradoDeEstudios(completion: @escaping (Result<[CatalogoClientesGradoDeEstudios], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoClientesGradoDeEstudios?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoClientesGradoDeEstudios].self) { response in
                    switch response.result {
                    case .success(let catalogoClientesGradoDeEstudios):
                        completion(.success(catalogoClientesGradoDeEstudios))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoClientesGradoDeEstudios(nuevoCatalogoClientesGradoDeEstudios: CatalogoClientesGradoDeEstudios, completion: @escaping (Result<CatalogoClientesGradoDeEstudios, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoClientesGradoDeEstudios.Nombre,
               "Fecha":nuevoCatalogoClientesGradoDeEstudios.Fecha,
               "IdSupervisor":nuevoCatalogoClientesGradoDeEstudios.IdSupervisor,
               "IdEmpresa":nuevoCatalogoClientesGradoDeEstudios.IdEmpresa
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoClientesGradoDeEstudios", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoClientesGradoDeEstudios.self) { response in
                   switch response.result {
                   case .success(let catalogoClientesGradoDeEstudios):
                       completion(.success(catalogoClientesGradoDeEstudios))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

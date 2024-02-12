//
//  CatalogoInstructoresTitulos.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire

class CatalogoInstructoresTitulosAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoInstructoresTitulosAPIService()
    
    func editarCatalogoInstructoresTitulos(catalogoInstructoresTitulos: CatalogoInstructoresTitulos, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoInstructoresTitulos/\(catalogoInstructoresTitulos.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoInstructoresTitulos.Nombre,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoInstructoresTitulos.IdEmpresa
            
         
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

    
    func eliminarCatalogoInstructoresTitulos(idCatalogoInstructoresTitulos: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoInstructoresTitulos/\(idCatalogoInstructoresTitulos)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoInstructoresTitulos(completion: @escaping (Result<[CatalogoInstructoresTitulos], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoInstructoresTitulos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoInstructoresTitulos].self) { response in
                    switch response.result {
                    case .success(let catalogoInstructoresTitulos):
                        completion(.success(catalogoInstructoresTitulos))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoInstructoresTitulos(nuevoCatalogoInstructoresTitulos: CatalogoInstructoresTitulos, completion: @escaping (Result<CatalogoInstructoresTitulos, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoInstructoresTitulos.Nombre,
               "Fecha":nuevoCatalogoInstructoresTitulos.Fecha,
               "IdEmpresa":nuevoCatalogoInstructoresTitulos.IdEmpresa
             
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoInstructoresTitulos", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoInstructoresTitulos.self) { response in
                   switch response.result {
                   case .success(let catalogoInstructoresTitulos):
                       completion(.success(catalogoInstructoresTitulos))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


//
//  CatalogoClientesMediosDeCaptacion.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoClientesMediosDeCaptacionAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoClientesMediosDeCaptacionAPIService()
    
    func editarCatalogoClientesMediosDeCaptacion(catalogoClientesMediosDeCaptacion: CatalogoClientesMediosDeCaptacion, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoClientesMediosDeCaptacion/\(catalogoClientesMediosDeCaptacion.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoClientesMediosDeCaptacion.Nombre,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoClientesMediosDeCaptacion.IdEmpresa
            
         
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

    
    func eliminarCatalogoClientesMediosDeCaptacion(idCatalogoClientesMediosDeCaptacion: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoClientesMediosDeCaptacion/\(idCatalogoClientesMediosDeCaptacion)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoClientesMediosDeCaptacion(completion: @escaping (Result<[CatalogoClientesMediosDeCaptacion], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoClientesMediosDeCaptacion?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoClientesMediosDeCaptacion].self) { response in
                    switch response.result {
                    case .success(let catalogoClientesMediosDeCaptacion):
                        completion(.success(catalogoClientesMediosDeCaptacion))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoClientesMediosDeCaptacion(nuevoCatalogoClientesMediosDeCaptacion: CatalogoClientesMediosDeCaptacion, completion: @escaping (Result<CatalogoClientesMediosDeCaptacion, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoClientesMediosDeCaptacion.Nombre,
               "Fecha":nuevoCatalogoClientesMediosDeCaptacion.Fecha,
               "IdEmpresa":nuevoCatalogoClientesMediosDeCaptacion.IdEmpresa
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoClientesMediosDeCaptacion", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoClientesMediosDeCaptacion.self) { response in
                   switch response.result {
                   case .success(let catalogoClientesMediosDeCaptacion):
                       completion(.success(catalogoClientesMediosDeCaptacion))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

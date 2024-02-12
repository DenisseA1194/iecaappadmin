//
//  CatalogoInstructoresTipoContrato.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//
import Foundation
import Alamofire

class CatalogoInstructoresTipoContratoAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoInstructoresTipoContratoAPIService()
    
    func editarCatalogoInstructoresTipoContrato(catalogoInstructoresTipoContrato: CatalogoInstructoresTipoContrato, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoInstructoresTipoContrato/\(catalogoInstructoresTipoContrato.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoInstructoresTipoContrato.Nombre,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoInstructoresTipoContrato.IdEmpresa
            
         
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

    
    func eliminarCatalogoInstructoresTipoContrato(idCatalogoInstructoresTipoContrato: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoInstructoresTipoContrato/\(idCatalogoInstructoresTipoContrato)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoInstructoresTipoContrato(completion: @escaping (Result<[CatalogoInstructoresTipoContrato], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoInstructoresTipoContrato?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoInstructoresTipoContrato].self) { response in
                    switch response.result {
                    case .success(let catalogoInstructoresTipoContrato):
                        completion(.success(catalogoInstructoresTipoContrato))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoInstructoresTipoContrato(nuevoCatalogoInstructoresTipoContrato: CatalogoInstructoresTipoContrato, completion: @escaping (Result<CatalogoInstructoresTipoContrato, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoInstructoresTipoContrato.Nombre,
               "Fecha":nuevoCatalogoInstructoresTipoContrato.Fecha,
               "IdEmpresa":nuevoCatalogoInstructoresTipoContrato.IdEmpresa
             
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoInstructoresTipoContrato", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoInstructoresTipoContrato.self) { response in
                   switch response.result {
                   case .success(let catalogoInstructoresTipoContrato):
                       completion(.success(catalogoInstructoresTipoContrato))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


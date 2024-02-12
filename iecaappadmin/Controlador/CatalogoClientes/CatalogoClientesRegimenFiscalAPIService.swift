//
//  CatalogoClientesRegimenFiscal.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoClientesRegimenFiscalAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoClientesRegimenFiscalAPIService()
    
    func editarCatalogoClientesRegimenFiscal(catalogoClientesRegimenFiscal: CatalogoClientesRegimenFiscal, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoClientesRegimenFiscal/\(catalogoClientesRegimenFiscal.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdEmpresa":catalogoClientesRegimenFiscal.IdEmpresa,
            "C_RegimenFiscal": catalogoClientesRegimenFiscal.C_RegimenFiscal,
            "Descripcion": catalogoClientesRegimenFiscal.Descripcion,
            "Fisica":catalogoClientesRegimenFiscal.Fisica,
            "Moral":catalogoClientesRegimenFiscal.Moral
            
         
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

    
    func eliminarCatalogoClientesRegimenFiscal(idCatalogoClientesRegimenFiscal: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoClientesRegimenFiscal/\(idCatalogoClientesRegimenFiscal)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoClientesRegimenFiscal(completion: @escaping (Result<[CatalogoClientesRegimenFiscal], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoClientesRegimenFiscal?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoClientesRegimenFiscal].self) { response in
                    switch response.result {
                    case .success(let catalogoClientesRegimenFiscal):
                        completion(.success(catalogoClientesRegimenFiscal))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoClientesRegimenFiscal(nuevoCatalogoClientesRegimenFiscal: CatalogoClientesRegimenFiscal, completion: @escaping (Result<CatalogoClientesRegimenFiscal, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdEmpresa":nuevoCatalogoClientesRegimenFiscal.IdEmpresa,
            "C_RegimenFiscal": nuevoCatalogoClientesRegimenFiscal.C_RegimenFiscal,
            "Descripcion": nuevoCatalogoClientesRegimenFiscal.Descripcion,
            "Fisica":nuevoCatalogoClientesRegimenFiscal.Fisica,
            "Moral":nuevoCatalogoClientesRegimenFiscal.Moral
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoClientesRegimenFiscal", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoClientesRegimenFiscal.self) { response in
                   switch response.result {
                   case .success(let catalogoClientesRegimenFiscal):
                       completion(.success(catalogoClientesRegimenFiscal))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

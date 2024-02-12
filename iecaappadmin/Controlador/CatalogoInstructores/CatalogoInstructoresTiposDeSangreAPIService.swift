//
//  CatalogoInstructoresTiposDeSangre.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//
import Foundation
import Alamofire

class CatalogoInstructoresTiposDeSangreAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoInstructoresTiposDeSangreAPIService()
    
    func editarCatalogoInstructoresTiposDeSangre(catalogoInstructoresTiposDeSangre: CatalogoInstructoresTiposDeSangre, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoInstructoresTiposDeSangre/\(catalogoInstructoresTiposDeSangre.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoInstructoresTiposDeSangre.Nombre,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoInstructoresTiposDeSangre.IdEmpresa
            
         
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

    
    func eliminarCatalogoInstructoresTiposDeSangre(idCatalogoInstructoresTiposDeSangre: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoInstructoresTiposDeSangre/\(idCatalogoInstructoresTiposDeSangre)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoInstructoresTiposDeSangre(completion: @escaping (Result<[CatalogoInstructoresTiposDeSangre], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoInstructoresTiposDeSangre?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoInstructoresTiposDeSangre].self) { response in
                    switch response.result {
                    case .success(let catalogoInstructoresTiposDeSangre):
                        completion(.success(catalogoInstructoresTiposDeSangre))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoInstructoresTiposDeSangre(nuevoCatalogoInstructoresTiposDeSangre: CatalogoInstructoresTiposDeSangre, completion: @escaping (Result<CatalogoInstructoresTiposDeSangre, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoInstructoresTiposDeSangre.Nombre,
               "Fecha":nuevoCatalogoInstructoresTiposDeSangre.Fecha,
               "IdEmpresa":nuevoCatalogoInstructoresTiposDeSangre.IdEmpresa
             
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoInstructoresTiposDeSangre", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoInstructoresTiposDeSangre.self) { response in
                   switch response.result {
                   case .success(let catalogoInstructoresTiposDeSangre):
                       completion(.success(catalogoInstructoresTiposDeSangre))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


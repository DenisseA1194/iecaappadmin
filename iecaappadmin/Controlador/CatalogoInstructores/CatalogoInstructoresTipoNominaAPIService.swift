//
//  CatalogoInstructoresTipoNomina.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//
import Foundation
import Alamofire

class CatalogoInstructoresTipoNominaAPIService {
  
    private let webService = WebService()
    static let shared = CatalogoInstructoresTipoNominaAPIService()
    
    func editarCatalogoInstructoresTipoNomina(catalogoInstructoresTipoNomina: CatalogoInstructoresTipoNomina, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoInstructoresTipoNomina/\(catalogoInstructoresTipoNomina.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Nombre": catalogoInstructoresTipoNomina.Nombre,
            "Fecha": formattedDate,
            "IdEmpresa":catalogoInstructoresTipoNomina.IdEmpresa
            
         
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

    
    func eliminarCatalogoInstructoresTipoNomina(idCatalogoInstructoresTipoNomina: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/CatalogoInstructoresTipoNomina/\(idCatalogoInstructoresTipoNomina)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchCatalogoInstructoresTipoNomina(completion: @escaping (Result<[CatalogoInstructoresTipoNomina], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/CatalogoInstructoresTipoNomina?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [CatalogoInstructoresTipoNomina].self) { response in
                    switch response.result {
                    case .success(let catalogoInstructoresTipoNomina):
                        completion(.success(catalogoInstructoresTipoNomina))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarCatalogoInstructoresTipoNomina(nuevoCatalogoInstructoresTipoNomina: CatalogoInstructoresTipoNomina, completion: @escaping (Result<CatalogoInstructoresTipoNomina, Error>) -> Void) {
           let parameters: [String: Any] = [
               "Nombre": nuevoCatalogoInstructoresTipoNomina.Nombre,
               "Fecha":nuevoCatalogoInstructoresTipoNomina.Fecha,
               "IdEmpresa":nuevoCatalogoInstructoresTipoNomina.IdEmpresa
             
              
           ]
        
           AF.request(webService.getBaseURL() + "/api/CatalogoInstructoresTipoNomina", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: CatalogoInstructoresTipoNomina.self) { response in
                   switch response.result {
                   case .success(let catalogoInstructoresTipoNomina):
                       completion(.success(catalogoInstructoresTipoNomina))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


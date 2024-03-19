//
//  CatalogoCursosEspecialidades.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 06/02/24.
//

import Foundation
import Alamofire

class CatalogoCursosEspecialidadesAPIService {
    
    private let webService = WebService()
    static let shared = CatalogoCursosEspecialidadesAPIService()
    private let baseURL = "http://webservices.iecapp.com"
    
    func fetchCatalogoCursosEspecialidades(idArea: String, completion: @escaping (Result<[CatalogoCursosEspecialidades], Error>) -> Void) {
     
        AF.request(baseURL+"/api/CatalogoCursosEspecialidades?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C&idArea=\(idArea)")
            .validate()
            .responseDecodable(of: [CatalogoCursosEspecialidades].self) { response in
                switch response.result {
                case .success(let catalogoCursosEspecialidades):
                  
                    completion(.success(catalogoCursosEspecialidades))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        
        
    }
    
    func editarCatalogoCursosEspecialidades(catalogoCursosEspecialidades: CatalogoCursosEspecialidades, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/CatalogoCursosEspecialidades/\(catalogoCursosEspecialidades.Id)"
        
        // Obtener la fecha actual
        let currentDate = Date()
        
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "Id": catalogoCursosEspecialidades.Id,
            "IdEmpresa":catalogoCursosEspecialidades.IdEmpresa,
            "IdArea":catalogoCursosEspecialidades.IdArea,
            "Fecha": formattedDate,
            "Nombre": catalogoCursosEspecialidades.Nombre,
            "Notas": catalogoCursosEspecialidades.Notas,
            "Observaciones": catalogoCursosEspecialidades.Observaciones,
            "Status":catalogoCursosEspecialidades.Status,
            "Borrado":catalogoCursosEspecialidades.Borrado
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
    
    
    func eliminarCatalogoCursosEspecialidades(idCatalogoCursosEspecialidades: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/CatalogoCursosEspecialidades/\(idCatalogoCursosEspecialidades)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
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
    
   
    
    func agregarCatalogoCursosEspecialidades(nuevoCatalogoCursosEspecialidades: CatalogoCursosEspecialidades, completion: @escaping (Result<CatalogoCursosEspecialidades, Error>) -> Void) {
        let parameters: [String: Any] = [
            "Id": nuevoCatalogoCursosEspecialidades.Id,
            "IdEmpresa":nuevoCatalogoCursosEspecialidades.IdEmpresa,
            "IdArea":nuevoCatalogoCursosEspecialidades.IdArea,
            "Fecha": nuevoCatalogoCursosEspecialidades.Fecha,
            "Nombre": nuevoCatalogoCursosEspecialidades.Nombre,
            "Notas": nuevoCatalogoCursosEspecialidades.Notas,
            "Observaciones": nuevoCatalogoCursosEspecialidades.Observaciones,
            "Status":nuevoCatalogoCursosEspecialidades.Status,
            "Borrado":nuevoCatalogoCursosEspecialidades.Borrado
        ]
        
        AF.request(baseURL + "/api/CatalogoCursosEspecialidades", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
            .validate()
            .responseDecodable(of: CatalogoCursosEspecialidades.self) { response in
                switch response.result {
                case .success(let catalogoCursosEspecialidades):
                    completion(.success(catalogoCursosEspecialidades))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

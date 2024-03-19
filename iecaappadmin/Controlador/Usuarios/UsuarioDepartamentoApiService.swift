//  UsuarioDepartamentoViewModel.swift
//  iecaappadmin
//
//  Created by Omar on 04/03/24.
//

import SwiftUI
import Foundation
import Alamofire

class UsuarioDepartamentoAPIService {
    
    private let baseURL = "http://webservices.iecapp.com"
    static let shared = UsuarioDepartamentoAPIService()
    
    func editarUsuario(usuario: UsuarioDepartamento, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/UsuariosDepartamentos/\(usuario.Id)"
        print(url)
        let parameters: [String: Any] = [
            "Id": usuario.Id,
            "Nombre": usuario.Nombre,
            "Fecha": usuario.Fecha,
            "IdEmpresa": usuario.IdEmpresa,
            "borrado": usuario.Borrado,
            "Notas": usuario.Notas
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
    
    func eliminarUsuario(idUsuario: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL + "/api/UsuarioDepartamento/\(idUsuario)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
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
    
    func fetchUsuarios(completion: @escaping (Result<[UsuarioDepartamento], Error>) -> Void) {
        AF.request(baseURL+"/api/UsuariosDepartamentos?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
            .validate()
            .responseDecodable(of: [UsuarioDepartamento].self) { response in
                switch response.result {
                case .success(let usuarios):
                    completion(.success(usuarios))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func agregarUsuario(usuario: UsuarioDepartamento, completion: @escaping (Result<UsuarioDepartamento, Error>) -> Void) {
        let parameters: [String: Any] = [
            "Id": usuario.Id,
            "Nombre": usuario.Nombre,
            "Fecha": usuario.Fecha,
            "IdEmpresa": usuario.IdEmpresa,
            "borrado": usuario.Borrado,
            "Notas": usuario.Notas
        
        ]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print("JSON a enviar:")
            print(jsonString)
        }
        
        AF.request(baseURL + "/api/UsuariosDepartamentos", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
            .validate()
            .responseDecodable(of: UsuarioDepartamento.self) { response in
                switch response.result {
                case .success(let usuario):
                    completion(.success(usuario))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

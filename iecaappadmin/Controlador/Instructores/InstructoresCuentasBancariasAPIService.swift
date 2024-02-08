//
//  File4.swift
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class InstructoresCuentasBancariasAPIService {
  
    private let webService = WebService()
        static let shared = InstructoresCuentasBancariasAPIService()
    
    func editarInstructoresCuentasBancarias(instructoresCuentasBancarias: InstructoresCuentasBancarias, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/InstructoresCuentasBancarias/\(instructoresCuentasBancarias.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdInstructor": instructoresCuentasBancarias.IdInstructor,
            "NumeroCuenta":instructoresCuentasBancarias.NumeroCuenta,
            "NumeroTarjeta": instructoresCuentasBancarias.NumeroTarjeta,
            "CuentaClabe": instructoresCuentasBancarias.CuentaClabe,
            "Sucursal": instructoresCuentasBancarias.Sucursal,
            "Notas": instructoresCuentasBancarias.Notas,
            "Fecha": formattedDate,
            "IdEmpresa":instructoresCuentasBancarias.IdEmpresa,
            "Activo":instructoresCuentasBancarias.Activo,
            "IdBanco":instructoresCuentasBancarias.IdBanco
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

    
    func eliminarInstructoresCuentasBancarias(idInstructoresCuentasBancarias: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/InstructoresCuentasBancarias/\(idInstructoresCuentasBancarias)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchInstructoresCuentasBancarias(completion: @escaping (Result<[InstructoresCuentasBancarias], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/InstructoresCuentasBancarias?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [InstructoresCuentasBancarias].self) { response in
                    switch response.result {
                    case .success(let instructoresCuentasBancaria):
                        completion(.success(instructoresCuentasBancaria))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarInstructoresCuentasBancarias(nuevoInstructoresCuentasBancarias: InstructoresCuentasBancarias, completion: @escaping (Result<InstructoresCuentasBancarias, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdInstructor": nuevoInstructoresCuentasBancarias.IdInstructor,
            "NumeroCuenta":nuevoInstructoresCuentasBancarias.NumeroCuenta,
            "NumeroTarjeta": nuevoInstructoresCuentasBancarias.NumeroTarjeta,
            "CuentaClabe": nuevoInstructoresCuentasBancarias.CuentaClabe,
            "Sucursal": nuevoInstructoresCuentasBancarias.Sucursal,
            "Notas": nuevoInstructoresCuentasBancarias.Notas,
            "Fecha": nuevoInstructoresCuentasBancarias.Fecha,
            "IdEmpresa":nuevoInstructoresCuentasBancarias.IdEmpresa,
            "Activo":nuevoInstructoresCuentasBancarias.Activo,
            "IdBanco":nuevoInstructoresCuentasBancarias.IdBanco
           ]
        
           AF.request(webService.getBaseURL() + "/api/InstructoresCuentasBancarias", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: InstructoresCuentasBancarias.self) { response in
                   switch response.result {
                   case .success(let instructoresCuentasBancarias):
                       completion(.success(instructoresCuentasBancarias))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


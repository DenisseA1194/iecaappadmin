
//  iecaappadmin
//
//  Created by Denisse Alejandra Martinez Mendiola on 02/02/24.
//

import Foundation
import Alamofire



class ClientesDatosCreditoAPIService {
  
    private let webService = WebService()
        static let shared = ClientesDatosCreditoAPIService()
    
    func editarClientesDatosCredito(clientesDatosCredito: ClientesDatosCredito, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = webService.getBaseURL() + "/api/ClientesDatosCredito/\(clientesDatosCredito.Id)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        
        // Obtener la fecha actual
        let currentDate = Date()
               
        // Formatear la fecha actual utilizando DateFormatterManager
        let formattedDate = DateFormatterManager.shared.format(date: currentDate)
        
        let parameters: [String: Any] = [
            "IdCliente": clientesDatosCredito.IdCliente,
            "FechaAlta": formattedDate,
            "IdEmpresa":clientesDatosCredito.IdEmpresa,
            "Activo": clientesDatosCredito.Activo,
            "Notas": clientesDatosCredito.Notas,
            "ListaDePrecios": clientesDatosCredito.ListaDePrecios,
            "Descuento":clientesDatosCredito.Descuento,
            "PlazoDias": clientesDatosCredito.PlazoDias,
            "TasaInteres": clientesDatosCredito.TasaInteres,
            "NumeroDePagos": clientesDatosCredito.NumeroDePagos,
            "Modalidad":clientesDatosCredito.Modalidad
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

    
    func eliminarClientesDatosCredito(idClientesDatosCredito: String, completion: @escaping (Result<Void, Error>) -> Void) {
           let url = webService.getBaseURL() + "/api/ClientesDatosCredito/\(idClientesDatosCredito)?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
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

        func fetchClientesDatosCredito(completion: @escaping (Result<[ClientesDatosCredito], Error>) -> Void) {
            AF.request(webService.getBaseURL()+"/api/ClientesDatosCredito?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C")
                .validate()
                .responseDecodable(of: [ClientesDatosCredito].self) { response in
                    switch response.result {
                    case .success(let clientesDatosCredito):
                        completion(.success(clientesDatosCredito))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func agregarClientesDatosCredito(nuevoClientesDatosCredito: ClientesDatosCredito, completion: @escaping (Result<ClientesDatosCredito, Error>) -> Void) {
           let parameters: [String: Any] = [
            "IdCliente": nuevoClientesDatosCredito.IdCliente,
            "FechaAlta": nuevoClientesDatosCredito.FechaAlta,
            "IdEmpresa":nuevoClientesDatosCredito.IdEmpresa,
            "Activo": nuevoClientesDatosCredito.Activo,
            "Notas": nuevoClientesDatosCredito.Notas,
            "ListaDePrecios": nuevoClientesDatosCredito.ListaDePrecios,
            "Descuento":nuevoClientesDatosCredito.Descuento,
            "PlazoDias": nuevoClientesDatosCredito.PlazoDias,
            "TasaInteres": nuevoClientesDatosCredito.TasaInteres,
            "NumeroDePagos": nuevoClientesDatosCredito.NumeroDePagos,
            "Modalidad":nuevoClientesDatosCredito.Modalidad
           ]
        
           AF.request(webService.getBaseURL() + "/api/ClientesDatosCredito", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
               .validate()
               .responseDecodable(of: ClientesDatosCredito.self) { response in
                   switch response.result {
                   case .success(let clientesDatosCredito):
                       completion(.success(clientesDatosCredito))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}


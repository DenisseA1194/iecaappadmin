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
    private let baseURL = "http://webservices.iecapp.com"
    
    static let shared = CatalogoClientesRegimenFiscalAPIService()
    
    func fetchCatalogoClientesRegimenFiscal(completion: @escaping (Result<[CatalogoClientesRegimenFiscal], Error>) -> Void) {
        let url = baseURL+"/api/CatalogoClientesRegimenFiscal?idEmpresa=4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        print(url)
        AF.request(url)
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
    
}

//  ZonasViewModel.swift

import Foundation
import Alamofire

class CatalogoClientesRegimenFiscalViewModel: ObservableObject {
    
    @Published var regimenesFiscales: [CatalogoClientesRegimenFiscal] = []


    func fetch() {
        CatalogoClientesRegimenFiscalAPIService.shared.fetchCatalogoClientesRegimenFiscal { [weak self] result in
            switch result {
            case .success(let catalogosClientesRegimenFiscales):
                DispatchQueue.main.async {
                    self?.regimenesFiscales = catalogosClientesRegimenFiscales
                }
            case .failure(let error):
                print("Error al obtener datos de la API:", error)
            }
        }
    }
    

    
   
}


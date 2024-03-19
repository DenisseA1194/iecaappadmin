import Foundation
import Alamofire

class AreaViewModel: ObservableObject {
    
    @Published var areas: [Area] = []

    func editarArea(area: Area) {
        AreaAPIService.shared.editarArea(area: area) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    if let index = self?.areas.firstIndex(where: { $0.Id == area.Id }) {
                        self?.areas[index] = area
                    }
                    self?.actualizarListaAreas()
                }
            case .failure(let error):
                self?.actualizarListaAreas()
                print("Error al editar el área:", error)
            }
        }
    }
    
    func eliminarArea(area: Area) {
        guard let index = areas.firstIndex(where: { $0.Id == area.Id }) else {
            return
        }

        AreaAPIService.shared.eliminarArea(idArea: area.Id) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.areas.remove(at: index)
                }
            case .failure(let error):
                print("Error al eliminar el área:", error)
            }
        }
    }

    func fetchAreas() {
        AreaAPIService.shared.fetchAreas { [weak self] result in
            switch result {
            case .success(let areas):
                DispatchQueue.main.async {
                    self?.areas = areas
                }
            case .failure(let error):
                print("Error al obtener datos de la API:", error)
            }
        }
    }
    
    func agregarNuevaArea(nuevaArea: Area) {
           AreaAPIService.shared.agregarArea(area: nuevaArea) { [weak self] result in
               switch result {
               case .success(let area):
                   DispatchQueue.main.async {
                       self?.areas.append(area)
                       self?.actualizarListaAreas()
                   }
               case .failure(let error):
                   self?.actualizarListaAreas()
                   print("Error al agregar el área:", error)
               }
           }
       }

    
    func actualizarListaAreas() {
        fetchAreas()
    }
}

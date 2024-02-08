//
//  SucursalesView.swift
//  iecaappadmin
//
//  Created by Omar on 06/02/24.
//

import SwiftUI
import Alamofire

struct SucursalesView: View {
    
    enum SortingOption: String, CaseIterable {
          case nombre = "Nombre"
          case direccion = "Dirección"
          
          
          var keyPath: KeyPath<Sucursal, String> {
              switch self {
              case .nombre: return \.Nombre
              case .direccion: return \.Direccion
             
              }
          }
      }
    
    
    @StateObject private var viewModel = SucursalesViewModel()
    @Binding var showSignInView: Bool
    @State private var isAddingNewSucursal = false
    @State private var isEditingSucursal = false
    
    @State private var searchText = ""
    @State private var selectedSortingOption: SortingOption = .nombre

    var sortedSucursales: [Sucursal] {
           if searchText.isEmpty {
               return viewModel.sucursales.sorted(by: { $0[keyPath: selectedSortingOption.keyPath] < $1[keyPath: selectedSortingOption.keyPath] }) ?? []
           } else {
               let filtered = viewModel.sucursales.filter { sucursal in
                   return sucursal.Nombre.lowercased().contains(searchText.lowercased())
               }
               return filtered.sorted(by: { $0[keyPath: selectedSortingOption.keyPath] < $1[keyPath: selectedSortingOption.keyPath] }) ?? []
           }
       }

      var body: some View {
          NavigationView {
              List {
                  
                  SearchBar(searchText: $searchText)
                 
                  ForEach(sortedSucursales) { sucursal in
                      SucursalCellView(sucursal: sucursal, viewModel: viewModel)
                          .listRowSeparator(.hidden) // Oculta el separador predeterminado
                                             Divider() // Agrega un Divider entre celdas
                                                 .background(Color.gray) // Cambia el color del Divider según tus preferencias
                                                 .padding(.horizontal, 16)
                  }
//                  .onDelete { indexSet in
//                          // Aquí puedes llamar a la función para eliminar la sucursal en tu ViewModel
//                          viewModel.eliminarSucursal(sucursal: viewModel.sucursales[indexSet.first!])
////                      viewModel.eliminarSucursal(sucursal: sucursal)
//                      }
                  .swipeActions{
                    
                     
                          Button(action: {
                                                         // Acción del segundo botón
                                                         print("Segundo botón presionado")
                                                     }) {
                                                         Label("Eliminar", systemImage: "trash")
                                                             .tint(.red)
                                                     }
                      
                      
//                      Menu {
//                          Button("Editar") {
//                              // Acción para editar
//                              print("Editar")
//                          }.tint(.blue)
//                          Button("Eliminar") {
//                              // Acción para eliminar
//                              print("Eliminar")
//                          }.tint(.red)
//                      } label: {
//                          Label("Más opciones", systemImage: "ellipsis.circle")
//                              .tint(.gray)  // Puedes establecer un color diferente si es necesario
//                      }
                      
                     

                  }
                
                  
                  Button(action: {
                      isAddingNewSucursal.toggle()
                  }) {
                      Text("Agregar Sucursal")
                  }
              } .toolbar {
                  ToolbarItem(placement: .navigationBarTrailing) {
                      Menu("Ordenar por") {
                          ForEach(SortingOption.allCases, id: \.self) { option in
                              Button(action: {
                                  selectedSortingOption = option
                              }) {
                                  Label(option.rawValue, systemImage: "arrow.up.arrow.down")
                              }
                          }
                      }
                  }
              }
              
              
              .onAppear {
                  viewModel.fetchSucursales()
              }
              .navigationTitle("Sucursales")
              .sheet(isPresented: $isAddingNewSucursal) {
                  // Formulario para agregar nueva sucursal
                  AgregarSucursalView(isAddingNewSucursal: $isAddingNewSucursal, sucursalViewModel: viewModel)
              }
          }
      }
  }

struct SearchBar: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            TextField("Buscar", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 8)
            }
        }
    }
}
    
    struct SucursalCellView: View {
        let sucursal: Sucursal
        @ObservedObject var viewModel: SucursalesViewModel
        @State private var isPresentingEditForm = false

            var body: some View {
                HStack {
                    VStack(alignment: .leading) {
                        Text(sucursal.Nombre)
                        Text(sucursal.Direccion)
                        Text(sucursal.Ciudad)
                        
                    }
                    Spacer()
                    HStack {
                                   Button(action: {
                                       isPresentingEditForm.toggle()
                                   }) {
//                                       Image(systemName: "pencil")
                                   }
                                   .foregroundColor(.blue)
                                   .sheet(isPresented: $isPresentingEditForm) {
                                       // Formulario para editar sucursal
                                       EditarSucursalView(sucursal: sucursal, sucursalViewModel: viewModel, isPresented: $isPresentingEditForm)
                                   }
                               }
                }
                .padding(8)
            }
    }

    struct SucursalListView_Previews: PreviewProvider {
        static var previews: some View {
            SucursalesView(showSignInView: .constant(false))
        }
    }
struct EditarSucursalView: View {
    let sucursal: Sucursal
    @ObservedObject var sucursalViewModel: SucursalesViewModel
    @Binding var isPresented: Bool

    // Agregar propiedades para editar la sucursal
    @State private var nuevoNombre = ""
    @State private var nuevaDireccion = ""
    @State private var nuevaCiudad = ""
    @State private var nuevaRegion = ""
    
    init(sucursal: Sucursal, sucursalViewModel: SucursalesViewModel, isPresented: Binding<Bool>) {
           self.sucursal = sucursal
           self.sucursalViewModel = sucursalViewModel
           self._isPresented = isPresented
           // Asignar los valores iniciales
           _nuevoNombre = State(initialValue: sucursal.Nombre)
           _nuevaDireccion = State(initialValue: sucursal.Direccion)
           _nuevaCiudad = State(initialValue: sucursal.Ciudad)
           _nuevaRegion = State(initialValue: sucursal.Region)
       }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Editar Sucursal")) {
                    
                    TextField("Nombre", text: $nuevoNombre)
                    TextField("Dirección", text: $nuevaDireccion)
                    TextField("Ciudad", text: $nuevaCiudad)
                    TextField("Region", text: $nuevaRegion)
                    
                }

                Section {
                    Button("Guardar Cambios") {
                        editarSucursal()
                    }
                }
            }
            .navigationTitle("Editar Sucursal")
            .navigationBarItems(trailing: Button("Cerrar") {
                isPresented.toggle()
            })
        }
    }

    private func editarSucursal() {
        // Agregar lógica para enviar los cambios al servidor, actualizar datos, etc.
        // Aquí simplemente simulamos editar la sucursal en el ViewModel para fines de demostración.
        let sucursalEditada = Sucursal(
            Id: sucursal.Id,
            Nombre: nuevoNombre.isEmpty ? sucursal.Nombre : nuevoNombre,
            Direccion: nuevaDireccion.isEmpty ? sucursal.Direccion : nuevaDireccion,
            Ciudad: nuevaCiudad.isEmpty ? sucursal.Ciudad : nuevaCiudad,
            Region: nuevaRegion.isEmpty ? sucursal.Region : nuevaRegion,
            Latitud: 0,
            Longitud: 0,
            Fecha: "",
            IdRazonSocial: "00000000-0000-0000-0000-000000000000",
            IdSucursalTipo: "00000000-0000-0000-0000-000000000000",
            IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
           
        )

        sucursalViewModel.editarSucursal(sucursal: sucursalEditada)
        isPresented.toggle()
    }
}



struct AgregarSucursalView: View {
    @Binding var isAddingNewSucursal: Bool
    @ObservedObject var sucursalViewModel: SucursalesViewModel
    @State private var nuevaSucursalNombre = ""
    @State private var nuevaSucursalDireccion = ""
    @State private var nuevaSucursalCiudad = ""
    @State private var nuevaSucursalRegion = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Nombre sucursal", text: $nuevaSucursalNombre)
                    .padding()
                TextField("Direccion", text: $nuevaSucursalDireccion)
                    .padding()
                TextField("Ciudad", text: $nuevaSucursalCiudad)
                    .padding()
                TextField("Region", text: $nuevaSucursalRegion)
                    .padding()
                
                
                Button("Agregar") {
                    agregarNuevaSucursal()
                }
                .padding()
            }
            .navigationTitle("Agregar Sucursal")
            .navigationBarItems(trailing: Button("Cerrar") {
                isAddingNewSucursal.toggle()
            })
        }
    }
    
    private func agregarNuevaSucursal() {
        // Agregar lógica para enviar la nueva sucursal al servidor, actualizar datos, etc.
        // Aquí simplemente simulamos agregar la sucursal al ViewModel para fines de demostración.
        let nuevaSucursal = Sucursal(
            Id: "00000000-0000-0000-0000-000000000000",
            Nombre: ""+nuevaSucursalNombre+"",
            Direccion: ""+nuevaSucursalDireccion+"", // Proporciona valores adecuados para las demás propiedades
            Ciudad: ""+nuevaSucursalCiudad+"",
            Region: ""+nuevaSucursalRegion+"",
            Latitud: 0,
            Longitud: 0,
            Fecha: "",
            IdRazonSocial: "00000000-0000-0000-0000-000000000000",
            IdSucursalTipo: "00000000-0000-0000-0000-000000000000",
            IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        )
        
        print(nuevaSucursal)
        
        //           sucursalViewModel.sucursales.append(nuevaSucursal)
        //           isAddingNewSucursal.toggle()
        
        sucursalViewModel.agregarNuevaSucursal(nuevaSucursal: nuevaSucursal)
        isAddingNewSucursal.toggle()
    }
    
    
}

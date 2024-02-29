//
//  ClientesView.swift
//  iecaappadmin
//
//  Created by Omar on 06/02/24.
//

import SwiftUI
import Alamofire

struct ClientesView: View {
    
    enum SortingOption: String, CaseIterable {
          case nombre = "Nombre"
          case direccion = "Dirección"
          
          
          var keyPath: KeyPath<Cliente, String> {
              switch self {
              case .nombre: return \.Nombre
              case .direccion: return \.IdApellidoMaterno
             
              }
          }
      }
    
    
    @StateObject private var viewModel = ClientesViewModel()
    @Binding var showSignInView: Bool
    @State private var isAddingNewClientes = false
    @State private var isEditingCliente = false
    
    @State private var searchText = ""
    @State private var selectedSortingOption: SortingOption = .nombre

    var sortedCliente: [Cliente] {
           if searchText.isEmpty {
               return viewModel.clientes.sorted(by: { $0[keyPath: selectedSortingOption.keyPath] < $1[keyPath: selectedSortingOption.keyPath] }) ?? []
           } else {
               let filtered = viewModel.clientes.filter { cliente in
                   return cliente.Nombre.lowercased().contains(searchText.lowercased())
               }
               return filtered.sorted(by: { $0[keyPath: selectedSortingOption.keyPath] < $1[keyPath: selectedSortingOption.keyPath] }) ?? []
           }
       }

      var body: some View {
          NavigationView {
              List {
                  
                 // SearchBar(searchText: $searchText)
                 
                  ForEach(sortedCliente) { cliente in
                      ClienteCellView(cliente: cliente, viewModel: viewModel)
                          .listRowSeparator(.hidden)
                                             Divider()
                                                 .background(Color.gray)
                                                 .padding(.horizontal, 16)
                  }

                  .swipeActions{

                          Button(action: {
                                                         
                                                         print("Segundo botón presionado")
                                                     }) {
                                                         Label("Eliminar", systemImage: "trash")
                                                             .tint(.red)
                                                     }
                  }
                
                  
                  Button(action: {
                      isAddingNewClientes.toggle()
                  }) {
                      Text("Agregar Cliente")
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
                  viewModel.fetchClientes()
              }
              .navigationTitle("Clientes")
              .sheet(isPresented: $isAddingNewClientes) {
                  AgregarClienteView(isAddingNewClientes: $isAddingNewClientes, clientesViewModel: viewModel)
              }
          }
      }
  }

struct SearchBarClientes: View {
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
    
    struct ClienteCellView: View {
        let cliente: Cliente
        @ObservedObject var viewModel: ClientesViewModel
        @State private var isPresentingEditForm = false

            var body: some View {
                HStack {
                    VStack(alignment: .leading) {
                        Text(cliente.Nombre)
                        Text(cliente.NombreComercial)
                        Text(cliente.Observaciones)
                            .lineLimit(1)
                    }
                    .frame(maxWidth: .infinity)
                    Spacer()
                    HStack {
                                   Button(action: {
                                       isPresentingEditForm.toggle()
                                   }) {
//                                       Image(systemName: "pencil")
                                   }
                                   .foregroundColor(.blue)
                                   .sheet(isPresented: $isPresentingEditForm) {
                                     
                                       EditarClienteView(cliente: cliente, clientesViewModel: viewModel, isPresented: $isPresentingEditForm)
                                   }
                               }
                }
                .padding(8)
            }
    }

//    struct ClienteListView_Previews: PreviewProvider {
//        static var previews: some View {
//            SucursalesView(showSignInView: .constant(false))
//        }
//    }
struct EditarClienteView: View {
    let cliente: Cliente
    @ObservedObject var clientesViewModel: ClientesViewModel
    @Binding var isPresented: Bool

    @State private var nuevoNombre = ""
    @State private var nuevaDireccion = ""
    @State private var nuevaCiudad = ""
    @State private var nuevaRegion = ""
    
    init(cliente: Cliente, clientesViewModel: ClientesViewModel, isPresented: Binding<Bool>) {
           self.cliente = cliente
           self.clientesViewModel = clientesViewModel
           self._isPresented = isPresented
         
           _nuevoNombre = State(initialValue: cliente.Nombre)
           _nuevaDireccion = State(initialValue: cliente.CodigoRegistro)
           _nuevaCiudad = State(initialValue: cliente.NombreComercial)
           _nuevaRegion = State(initialValue: cliente.Observaciones)
       }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Editar Cliente")) {
                    
                    TextField("Nombre", text: $nuevoNombre)
                    TextField("Dirección", text: $nuevaDireccion)
                    TextField("Ciudad", text: $nuevaCiudad)
                    TextField("Region", text: $nuevaRegion)
                    
                }

                Section {
                    Button("Guardar Cambios") {
                        editarCliente()
                    }
                }
            }
            .navigationTitle("Editar Cliente")
            .navigationBarItems(trailing: Button("Cerrar") {
                isPresented.toggle()
            })
        }
    }

    private func editarCliente() {
        
        let ClienteEditado = Cliente(
            Id: cliente.Id,
            IdCliente: cliente.IdCliente,
            IdEmpresa: cliente.IdEmpresa,
            IdTipo: cliente.IdTipo,
            EsPersonaFisica: cliente.EsPersonaFisica,
            Nombre: cliente.Nombre,
            IdApellidoPaterno: cliente.IdApellidoPaterno,
            IdApellidoMaterno: cliente.IdApellidoMaterno,
            NombreComercial: cliente.NombreComercial,
            IdPropietario: cliente.IdPropietario,
            IdCelula: cliente.IdCelula,
            IdSector: cliente.IdSector,
            IdMedioCaptacion: cliente.IdMedioCaptacion,
            IdPlataforma: cliente.IdPlataforma,
            IdSucursal: cliente.IdSucursal,
            IdClasificacion: cliente.IdClasificacion,
            Fecha: cliente.Fecha,
            Status: cliente.Status,
            Observaciones: cliente.Observaciones,
            CodigoRegistro: cliente.CodigoRegistro,
            Latitud: cliente.Latitud,
            Longitud: cliente.Longitud
           
        )

        clientesViewModel.editarClientes(cliente: ClienteEditado)
        isPresented.toggle()
    }
}



struct AgregarClienteView: View {
    @Binding var isAddingNewClientes: Bool
    @ObservedObject var clientesViewModel: ClientesViewModel
    @State private var nuevoClientesNombre = ""
    @State private var nuevaClientesDireccion = ""
    @State private var nuevaClientesCiudad = ""
    @State private var nuevoClientesRegion = ""
    let opciones = ["Persona fisica", "Persona moral"]
    @State private var seleccion = 0
        

    
    var body: some View {
        NavigationView {
            VStack {
                
                TextField("Nombre ", text: $nuevoClientesNombre)
                    .padding()
                TextField("Apellido materno", text: $nuevaClientesDireccion)
                    .padding()
                TextField("Apellido paterno", text: $nuevaClientesCiudad)
                    .padding()
                TextField("Nombre Comercial", text: $nuevoClientesRegion)
                    .padding()
                TextField("Observaciones", text: $nuevoClientesRegion)
                    .padding()
                TextField("Codigo de registro", text: $nuevoClientesRegion)
                    .padding()
                
                HStack{
                    Text("Tipo de contribuyente")
                        .padding()
                    Picker("Tipo de contribuyente:", selection: $seleccion) {
                                   ForEach(0 ..< opciones.count) {
                                       Text(opciones[$0])
                                   }
                               }
                               .pickerStyle(.menu)
                               
                              
                }
                
                
                         
                
                Button("Agregar") {
                    agregarNuevoCliente()
                }
                .padding()
            }
            .navigationTitle("Agregar Cliente")
            .navigationBarItems(trailing: Button("Cerrar") {
                isAddingNewClientes.toggle()
            })
        }
    }
    
    private func agregarNuevoCliente() {
        
        let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd" // Define el formato de la fecha que deseas obtener
           
           let currentDate = Date()
      
        let nuevoCliente = Cliente(
            Id: "00000000-0000-0000-0000-000000000000",
            IdCliente: "00000000-0000-0000-0000-000000000000",
            IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
            IdTipo: "00000000-0000-0000-0000-000000000000",
            EsPersonaFisica: false,
            Nombre: "",
            IdApellidoPaterno: "00000000-0000-0000-0000-000000000000",
            IdApellidoMaterno: "00000000-0000-0000-0000-000000000000",
            NombreComercial: "",
            IdPropietario: "00000000-0000-0000-0000-000000000000",
            IdCelula: "00000000-0000-0000-0000-000000000000",
            IdSector: "00000000-0000-0000-0000-000000000000",
            IdMedioCaptacion: "00000000-0000-0000-0000-000000000000",
            IdPlataforma: "00000000-0000-0000-0000-000000000000",
            IdSucursal: "00000000-0000-0000-0000-000000000000",
            IdClasificacion: "00000000-0000-0000-0000-000000000000",
            Fecha: "",
            Status: "",
            Observaciones: "",
            CodigoRegistro: "",
            Latitud: 0,
            Longitud: 0
        )
        
        print(nuevoCliente)
        
        clientesViewModel.agregarNuevoCliente(nuevoCliente:nuevoCliente)
        isAddingNewClientes.toggle()
    }
    
    
}



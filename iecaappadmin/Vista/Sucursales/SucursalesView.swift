//
//  SucursalesView.swift
//  iecaappadmin
//
//  Created by Omar on 06/02/24.
//

import SwiftUI
import Alamofire

struct SucursalesView: View {
    
    @State private var _Nombre = ""
    @State private var _Direccion = ""
    @State private var _Ciudad = ""
    @State private var _Telefono = ""
    @State private var _Numero = ""
    @State private var _Correo = ""
    @State private var _Pais = ""
    @State private var _IdTitular = ""
    @State private var _IdRazonSocial = ""
    @State private var _IdZona = ""
    @State private var _IdTipo = ""
    @State private var _Notas = ""
    @State private var _IdSucursal = ""
    @State private var buttonText = "Agregar"
    @State private var regimenFiscal = RegimenFiscal.otro // Valor por defecto
    @StateObject var viewModel = SucursalesViewModel()
    @StateObject var viewModelSucursalTipo = SucursalTipoViewModel()
    @State var seleccionSucursal: Int = 0
    @State var seleccionSucursalTipo: Int = 0
   
    
    enum RegimenFiscal: String, CaseIterable, Identifiable {
        case regimen1 = "Sucursal 1"
        case regimen2 = "Razon sociales 2"
        case regimen3 = "Razon sociales 3"
        case regimen4 = "Razon sociales 4"
        case regimen5 = "Razon sociales 5"
        case regimen6 = "Razon sociales 6"
        case otro = "Otro"
        
        var id: String { self.rawValue }
    }
    
    
    var body: some View {
        NavigationView {
           
            Form {
                Section(header: Text("Selecciona una Sucursal")) {
                    Picker("Sucursales", selection: $seleccionSucursal) {
                        
                        let i = 0
                        ForEach([0] + viewModel.sucursales.indices.map { $0 + 1 }, id: \.self) { index in
                            if index == 0 {
                                Text("") // Agregar texto vacío al principio
                                    .tag(0)
                            } else {
                                Text(viewModel.sucursales[index - 1].Nombre)
                                    .tag(index)
                            }
                        }
                    }.onChange(of: seleccionSucursal) { index in
                        // Aquí puedes acceder a los campos de la razón social seleccionada
                        print(index)
                        if index != 0 {
                            let sucursalSeleccionada = viewModel.sucursales[index-1]
                            print(sucursalSeleccionada.Nombre)
                            _Nombre = sucursalSeleccionada.Nombre
                            _Direccion = sucursalSeleccionada.Direccion
                            _Ciudad = sucursalSeleccionada.Ciudad
                            _Telefono = sucursalSeleccionada.Telefono
                            _Numero = sucursalSeleccionada.Numero
                            _Correo = sucursalSeleccionada.Ciudad
                            _Pais = sucursalSeleccionada.Pais
                            _IdTitular = sucursalSeleccionada.IdTitular
                            _IdRazonSocial = sucursalSeleccionada.IdRazonSocial
                            _IdZona = sucursalSeleccionada.IdZona
                            _Notas = sucursalSeleccionada.Notas
                            _IdSucursal = sucursalSeleccionada.Id
                            
                            buttonText = "Actualizar"
                        }else{
//                            LimpiarForm()
                        }
                        
                        // Asigna otros campos según sea necesario
                    }.onAppear {
                        // Llama a tu función para recuperar las razones sociales
                        viewModel.fetchSucursales()
                        viewModelSucursalTipo.fetchSucursales()
                        seleccionSucursal = 0
                    }.toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                
                            }) {
                                
                                Image(systemName: "plus")
                                
                            }
                        }
                    }
                }
                Section(header: Text("Sucursales")) {
                    TextField("Nombre", text: $_Nombre)
                    TextField("Dirección", text: $_Direccion)
                    TextField("Ciudad", text: $_Ciudad)
                    TextField("Teléfono", text: $_Telefono)
                        .keyboardType(.numberPad)
                    TextField("Identificador/Número", text: $_Numero)
                        .keyboardType(.numberPad)
                    TextField("Correo", text: $_Correo)
                    TextField("País", text: $_Pais)
                    Picker("Titular", selection: $regimenFiscal) {
                        
                        ForEach(RegimenFiscal.allCases) { regimen in
                            Text(regimen.rawValue)
                        }
                    }
                    Picker("Razon social", selection: $regimenFiscal) {
                        
                        ForEach(RegimenFiscal.allCases) { regimen in
                            Text(regimen.rawValue)
                        }
                    }
                    Picker("Zona", selection: $regimenFiscal) {
                        
                        ForEach(RegimenFiscal.allCases) { regimen in
                            Text(regimen.rawValue)
                        }
                    }
                    Picker("Tipo", selection: $seleccionSucursalTipo) {
                        
                        let i = 0
                        ForEach([0] + viewModelSucursalTipo.SucursalTipo.indices.map { $0 + 1 }, id: \.self) { index in
                            if index == 0 {
                                Text("") // Agregar texto vacío al principio
                                    .tag(0)
                            } else {
                                Text(viewModelSucursalTipo.SucursalTipo[index - 1].Nombre)
                                    .tag(index)
                            }
                        }
                     
                    }.onAppear {
                        // Llama a tu función para recuperar las razones sociales
//                        viewModel.fetchSucursales()
                        viewModelSucursalTipo.fetchSucursales()
                        seleccionSucursalTipo = 0
                    }
                    
                }
                
//                // Sección para los pickers
//                Section(header: Text("Selección")) {
//                    // Se deben agregar los pickers correspondientes aquí
//                }
                
                Section(header: Text("Notas")) {
                    TextEditor(text: $_Notas)
                        .frame(minHeight: 200)
                }
                HStack{
                    Spacer()
                    Image("logo") // Reemplaza "tu_imagen" con el nombre de tu imagen en el catálogo de activos
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                               .frame(width: 200, height: 200) // Ajusta el tamaño según sea necesario
                               .clipShape(Circle()) // Opcional: recorta la imagen en forma de círculo
                               .overlay(Circle().stroke(Color.blue, lineWidth: 4)) // Opcional: agrega un borde alrededor de la imagen
                               .shadow(radius: 10)
                    Spacer()
                }
                
                Section {
                    Button(action: {
                        if buttonText == "Agregar"{
                         
                        }else{
                            let sucursal = Sucursal(   Id: _IdSucursal,
                                                       Nombre: _Nombre,
                                                       Direccion: _Direccion,
                                                       Ciudad: _Ciudad,
                                                       Telefono: _Telefono,
                                                       Numero: _Numero,
                                                       Correo: _Correo,
                                                       Pais: _Pais,
                                                       IdTitular: _IdTitular,
                                                       IdRazonSocial: _IdRazonSocial,
                                                       IdZona: _IdZona,
                                                       Tipo: _IdTipo,
                                                       Notas: _Notas,
                                                       borrado: false,
                                                       Fecha: "2024-01-30T19:06:05.675Z"
                                                               )
                            viewModel.editarSucursal(sucursal: sucursal)
                        }
                        
//                                               LimpiarForm()
                        }) {
                            Text(buttonText)
                                .frame(maxWidth: .infinity) // Asegura que el texto ocupe todo el ancho disponible
                                .multilineTextAlignment(.center) // Centra el texto
                        }
                }
            }
            .navigationTitle("Sucursales")
        }
    }
    
    
}

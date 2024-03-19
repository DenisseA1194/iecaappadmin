//
//  TipoSucursalView.swift
//  iecaappadmin
//
//  Created by Omar on 26/02/24.
//

import SwiftUI

struct TipoSucursalView: View {
    @Binding var presentSideMenu: Bool
    @Binding var showSignInView: Bool
    @State private var _Nombre = ""
    @State private var _Notas = ""
    @State private var _Id = ""
    @State private var _Virtual = false
    @StateObject var viewModelSucursalTipo = SucursalTipoViewModel()
    @State var seleccionSucursalTipo: Int = 0
    @State private var buttonText = "Agregar"
    @State private var isSearching = false
    
    @State private var imageUrl: String?
    @State private var urlImagenFirebase: String? = ""
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var image: Image?
    @State private var showAlert = false
    @State private var showAlertAgregarModificar = false
    @State private var avisoText = ""
    
    func limpiarFormulario() {
        _Nombre = ""
        _Notas = ""
        _Id = ""
        _Virtual = false
        buttonText = "Agregar"
    }
    
    func validarNombreSucursalTipo() -> Bool {
        // Verificar si el campo de nombre no está vacío
        guard !_Nombre.isEmpty else {
            // Si el campo está vacío, retornar falso
            return false
        }
        
        // Si el campo no está vacío, retornar verdadero
        return true
    }
    
    var body: some View {
//        HStack {
//
//            Button(action: {
//                presentSideMenu.toggle()
//            }) {
//                Image("hamburguesa")
//                    .foregroundColor(.blue)
//                    .imageScale(.large)
//            }
//            .padding()
//            Spacer()
//        }
        NavigationView {
            Form {
                Section() {
                    Picker("Tipo Sucursal", selection: $seleccionSucursalTipo) {
                        
                        let i = 0
                        ForEach([0] + viewModelSucursalTipo.sucursalesTipo.indices.map { $0 + 1 }, id: \.self) { index in
                            if index == 0 {
                                Text("")
                                    .tag(0)
                            } else {
                                Text(viewModelSucursalTipo.sucursalesTipo[index - 1].Nombre)
                                    .tag(index)
                            }
                        }
                    }.onChange(of: seleccionSucursalTipo) { index in
                        
                        print(index)
                        if index != 0 {
                            let titularSeleccionada = viewModelSucursalTipo.sucursalesTipo[index-1]
                            //                            let titularSeleccionada = viewModelPuesto.puesto[seleccionPuesto]
                            _Id = titularSeleccionada.Id
                            _Nombre = titularSeleccionada.Nombre
                            _Notas = titularSeleccionada.Notas
                            _Virtual = titularSeleccionada.Virtual
                            
                            buttonText = "Actualizar"
                        }else{
                            //                            limpiarFormulario()
                            
                        }
                     
                    }.onAppear {
                       
                        viewModelSucursalTipo.fetchSucursalesTipo()
                      
                        
                    }.toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                showAlert.toggle()
                                limpiarFormulario()
                            }) {
                                
                                Image(systemName: "plus")
                                
                            }
                        }
                    }.alert(isPresented: $showAlert) {
                        Alert(title: Text("Aviso"), message: Text("Agrega una nueva sucursal"), dismissButton: .default(Text("Aceptar")))
                    }
                }
                
                Section() {
                    TextField("Nombre", text: $_Nombre)
                    VStack(alignment: .leading) {
                        Text("Notas:") // Etiqueta para el TextEditor
                            .font(.headline)
                            .padding(.top)
                        
                        TextEditor(text: $_Notas)
                            .frame(minHeight: 80) // Altura mínima del TextEditor
                            .padding()
                            .background(Color.gray.opacity(0.1)) // Fondo del TextEditor
                            .cornerRadius(8) // Bordes redondeados
                            .padding()
                    }
                    Toggle("Física", isOn: $_Virtual.animation())
                       Toggle("Virtual", isOn: Binding<Bool>(
                           get: { !_Virtual },
                           set: { newValue in _Virtual = !newValue }
                       ).animation())
                }
                
                
                Section {
                    Button(action: {
                        if validarNombreSucursalTipo() {
                            if buttonText == "Agregar"{
                                avisoText = "Registro Agregado"
                                showAlertAgregarModificar.toggle()
                                
                                let nuevaSucursalTipo = SucursalTipo(
                                    Id: "",
                                    Nombre: _Nombre,
                                    Fecha: "2024-01-30T19:06:05.675Z",
                                    IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
                                    Borrado: false,
                                    Virtual: _Virtual,
                                    Notas: _Notas
                                )
                                viewModelSucursalTipo.agregarNuevaSucursal(nuevaSucursalTipo: nuevaSucursalTipo)
                                viewModelSucursalTipo.fetchSucursalesTipo()
                                //limpiarFormulario()
                            }else{
                                avisoText = "Registro Modificado"
                                showAlertAgregarModificar.toggle()
                                let sucursalTipo = SucursalTipo(
                                    Id: _Id,
                                    Nombre: _Nombre,
                                    Fecha: "2024-01-30T19:06:05.675Z",
                                    IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
                                    Borrado: false,
                                    Virtual: _Virtual,
                                    Notas: _Notas
                                )
                                viewModelSucursalTipo.editarSucursalTipo(sucursalTipo: sucursalTipo)
                                viewModelSucursalTipo.fetchSucursalesTipo()
                                //limpiarFormulario()
                            }
                        }else{
                            avisoText = "Debes llenar todos los campos"
                            showAlertAgregarModificar.toggle()
                        }
                        
                        
                    }) {
                        Text(buttonText)
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                    }.alert(isPresented: $showAlertAgregarModificar) {
                        Alert(title: Text("Aviso"), message: Text(avisoText), dismissButton: .default(Text("Aceptar")))
                    }
                }
            }
            .navigationTitle("Tipos sucursales")
            
        }
    }
}



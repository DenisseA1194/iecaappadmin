//
//  ZonasView.swift
//  iecaappadmin
//
//  Created by Omar on 26/02/24.
//

import SwiftUI

struct EspecialidadesView: View {
    
    
    
    @State var seleccionEspecialidad: Int = 0
    @State var seleccionArea: Int = 0
    @State var seleccionAreaEditar: Int = 0
    @StateObject var viewModelEspecialidad = CatalogoCursosEspecialidadesViewModel()
    @StateObject var viewModelArea = AreaViewModel()
    @State private var _Nombre = ""
    @State private var _Notas = ""
    @State private var _Id = ""
    @State private var _IdAreaAgregar = ""
    @State private var _IdAreaEditar = ""
    @State private var buttonText = "Agregar"
    
    
    //    datos de aviso e imagen
    @State private var imageUrl: String?
    @State private var urlImagenFirebase: String? = ""
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var image: Image?
    @State private var showAlert = false
    @State private var showAlertAgregarModificar = false
    @State private var avisoText = ""
    @State private var isActivePickerAreaEdit = false
    
    
    
    func limpiarFormulario() {
        _Nombre = ""
        _Notas = ""
        imageUrl = nil
        urlImagenFirebase = nil
    }
    
    func todosLosCamposEstanCompletos() -> Bool {
        // Verificar si el campo de nombre no está vacío
        guard !_Nombre.isEmpty else {
            // Si el campo está vacío, retornar falso
            return false
        }
        
        // Si el campo no está vacío, retornar verdadero
        return true
    }
    
    
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Selecciona un Area")) {
                    Picker("Areas", selection: $seleccionArea) {
                        let i = 0
                        ForEach([0] + viewModelArea.areas.indices.map { $0 + 1 }, id: \.self) { index in
                            if index == 0 {
                                Text("")
                                    .tag(0)
                            } else {
                                Text(viewModelArea.areas[index - 1].Nombre)
                                    .tag(index)
                            }
                        }
                        
//                        ForEach(viewModelArea.areas.indices.map { $0}, id: \.self) { index in
//                            Text(viewModelArea.areas[index].Nombre)
//                                .tag(index)
//                        }
                    }.onAppear {
                        
                        
                        viewModelArea.fetchAreas()
                        
                        
                        
                    }.onChange(of: seleccionArea) { index in
                        print(index)
                      
                            let areaSeleccionada = viewModelArea.areas[index - 1]
                            
                            viewModelEspecialidad.catalogoCursosEspecialidades = []

                        _IdAreaAgregar = areaSeleccionada.Id
                           
                            viewModelEspecialidad.fetchCatalogoCursosEspecialidades(idArea: _IdAreaAgregar)
                        isActivePickerAreaEdit = true
                            buttonText = "Actualizar"
                      
                        
                    }
                    Picker("Especialidades", selection: $seleccionEspecialidad) {
                        
                        ForEach(viewModelEspecialidad.catalogoCursosEspecialidades.indices.map { $0}, id: \.self) { index in
                            Text(viewModelEspecialidad.catalogoCursosEspecialidades[index].Nombre)
                                .tag(index)
                        }
                    }.onChange(of: seleccionEspecialidad) { index in
                        print(index)
                        
                            let zonaSeleccionada = viewModelEspecialidad.catalogoCursosEspecialidades[index]
                            
                            _Nombre = zonaSeleccionada.Nombre
                            _Notas = zonaSeleccionada.Notas
                            _Id = zonaSeleccionada.Id
                            
                            
                            buttonText = "Actualizar"
                      
                        
                    }.onAppear {
                        
                        
                      
                        
                        
                        
                    }.toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                buttonText = "Agregar"
                                limpiarFormulario()
                                showAlert.toggle()
                            }) {
                                
                                Image(systemName: "plus")
                                
                            }.alert(isPresented: $showAlert) {
                                Alert(title: Text("Aviso"), message: Text("Agrega una nueva especialidad"), dismissButton: .default(Text("Aceptar")))
                            }
                        }
                    }
                }
                
                Section() {
                    if isActivePickerAreaEdit{
                        Picker("Areas", selection: $seleccionAreaEditar) {
                            
                            ForEach(viewModelArea.areas.indices.map { $0}, id: \.self) { index in
                                Text(viewModelArea.areas[index].Nombre)
                                    .tag(index)
                            }
                        }.onChange(of: seleccionAreaEditar) { index in
                            print(index)
                          
                                let areaSeleccionada = viewModelArea.areas[index]
                                
                             

                            _IdAreaEditar = areaSeleccionada.Id
                            
                        }
                    }
                   
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
                    
                }
                
                
                
                
                Section {
                    Button(action: {
                        if todosLosCamposEstanCompletos() {
                            if buttonText == "Agregar"{
                                avisoText = "Registro Agregado"
                                showAlertAgregarModificar.toggle()
                                let nuevaEspecialidad = CatalogoCursosEspecialidades(
                                    Id:_Id,
                                    IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
                                    IdArea:_IdAreaAgregar,
                                    Fecha: "2024-01-30T19:06:05.675Z",
                                    Nombre: _Nombre,
                                    Notas: _Notas,
                                    Observaciones:"N/A",
                                    Status:true,
                                    Borrado: false
                                    
                                    
                                )
                                viewModelEspecialidad.agregarCatalogoCursosEspecialidades(idArea: _IdAreaAgregar, nuevoCatalogoCursosEspecialidades: nuevaEspecialidad)
                                viewModelEspecialidad.fetchCatalogoCursosEspecialidades(idArea: _IdAreaAgregar)
                            }else{
                                avisoText = "Registro Modificado"
                                showAlertAgregarModificar.toggle()
                                let especialidad = CatalogoCursosEspecialidades(
                                    Id:_Id,
                                    IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
                                    IdArea:_IdAreaEditar,
                                    Fecha: "2024-01-30T19:06:05.675Z",
                                    Nombre: _Nombre,
                                    Notas: _Notas,
                                    Observaciones:"N/A",
                                    Status:true,
                                    Borrado: false
                                )
                                viewModelEspecialidad.editarCatalogoCursosEspecialidades(idArea: _IdAreaEditar, catalogoCursosEspecialidades: especialidad)
                                viewModelEspecialidad.fetchCatalogoCursosEspecialidades(idArea: _IdAreaEditar)
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
            .navigationTitle("Especialidades")
        }
    }
}

#Preview {
    ZonasView()
}

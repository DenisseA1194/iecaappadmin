
//
//  ZonasView.swift
//  iecaappadmin
//
//  Created by Omar on 26/02/24.
//

import SwiftUI

struct TipoConfidencialidadView: View {
    
    @State var seleccionTipoConfidencialidad: Int = 0
    @StateObject var viewModelTipoConfidencialidad = CatalogoCursosTipoConfidencialidadViewModel()
    @State private var _Nombre = ""
    @State private var _Notas = ""
    @State private var _Id = ""
    @State private var buttonText = "Agregar"
    
    @State private var showAlert = false
    @State private var showAlertAgregarModificar = false
    @State private var avisoText = ""
    
    
    
    func limpiarFormulario() {
        _Nombre = ""
        _Notas = ""
    }
    
    func todosLosCamposEstanCompletos() -> Bool {
        
        guard !_Nombre.isEmpty else {
            
            return false
        }
        return true
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    Picker("Tipo confidencialidad", selection: $seleccionTipoConfidencialidad) {
                        
                        ForEach(viewModelTipoConfidencialidad.catalogoCursosTipoConfidencialidad.indices.map { $0}, id: \.self) { index in
                            Text(viewModelTipoConfidencialidad.catalogoCursosTipoConfidencialidad[index].Nombre)
                                .tag(index)
                        }
                    }.onChange(of: seleccionTipoConfidencialidad) { index in
                        print(index)
                        if index != 0 {
                            let tipoConfidencialidadSeleccionada = viewModelTipoConfidencialidad.catalogoCursosTipoConfidencialidad[index]
                            
                            _Nombre = tipoConfidencialidadSeleccionada.Nombre
                            _Notas = tipoConfidencialidadSeleccionada.Notas
                            _Id = tipoConfidencialidadSeleccionada.Id
                            
                            
                            buttonText = "Actualizar"
                        }else{
                            //                             limpiarFormulario()
                            
                        }
                        
                    }.onAppear {
                        
                        viewModelTipoConfidencialidad.fetchCatalogoCursosTipoConfidencialidad()
                        
                    }.toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                buttonText = "Agregar"
                                limpiarFormulario()
                                showAlert.toggle()
                                
                            }) {
                                
                                Image(systemName: "plus")
                                
                            }.alert(isPresented: $showAlert) {
                                Alert(title: Text("Aviso"), message: Text("Agrega un Tipo confidencialidad"), dismissButton: .default(Text("Aceptar")))
                            }
                        }
                    }
                }
                
                Section() {
                    TextField("Nombre", text: $_Nombre)
                    VStack(alignment: .leading) {
                        Text("Notas:")
                            .font(.headline)
                            .padding(.top)
                        
                        TextEditor(text: $_Notas)
                            .frame(minHeight: 80)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .padding()
                    }
                    
                }
                
                
                
                Section {
                    Button(action: {
                        if todosLosCamposEstanCompletos() {
                            if buttonText == "Agregar"{
                                avisoText = "Registro Agregado"
                                showAlertAgregarModificar.toggle()
                                let nuevoTipoConfidencialidad = CatalogoCursosTipoConfidencialidad(
                                    Id: "",
                                    IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
                                    Fecha: "2024-01-30T19:06:05.675Z",
                                    Nombre: _Nombre,
                                    Notas: _Notas,
                                    Observaciones: "",
                                    Status: true,
                                    Borrado: false
                                )
                                viewModelTipoConfidencialidad.agregarCatalogoCursosTipoConfidencialidad(nuevoCatalogoCursosTipoConfidencialidad: nuevoTipoConfidencialidad)
                                viewModelTipoConfidencialidad.fetchCatalogoCursosTipoConfidencialidad()
                            }else{
                                avisoText = "Registro Modificado"
                                showAlertAgregarModificar.toggle()
                                let tipoConfidencialidad = CatalogoCursosTipoConfidencialidad(
                                    Id: _Id,
                                    IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
                                    Fecha: "2024-01-30T19:06:05.675Z",
                                    Nombre: _Nombre,
                                    Notas: _Notas,
                                    Observaciones: "",
                                    Status: true,
                                    Borrado: false
                                )
                                viewModelTipoConfidencialidad.editarCatalogoCursosTipoConfidencialidad(catalogoCursosTipoConfidencialidad: tipoConfidencialidad)
                                viewModelTipoConfidencialidad.fetchCatalogoCursosTipoConfidencialidad()
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
            .navigationTitle("Tipo Confidencialidad")
        }
    }
}

struct TipoConfidencialidadView_Previews: PreviewProvider {
    static var previews: some View {
        TipoConfidencialidadView()
    }
}


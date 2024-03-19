//
//  ZonasView.swift
//  iecaappadmin
//
//  Created by Omar on 26/02/24.
//

import SwiftUI

struct TemasView: View {
    @State private var newRazonSocialName = ""
    @State private var newRepresentante = ""
    @State private var notas = ""
    
    
    @State var seleccionTema: Int = 0
    @StateObject var viewModelTema = CatalogoCursosTemasViewModel()
    @State private var _Nombre = ""
    @State private var _Notas = ""
    @State private var _Id = ""
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
                Section(header: Text("Selecciona una zona")) {
                    Picker("Zonas", selection: $seleccionTema) {
                        
                        ForEach(viewModelTema.catalogoCursosTemas.indices.map { $0}, id: \.self) { index in
                            Text(viewModelTema.catalogoCursosTemas[index].Nombre)
                                .tag(index)
                        }
                    }.onChange(of: seleccionTema) { index in
                        print(index)
                        if index != 0 {
                            let zonaSeleccionada = viewModelTema.catalogoCursosTemas[index]
                            
                            _Nombre = zonaSeleccionada.Nombre
                            _Notas = zonaSeleccionada.Notas
                            _Id = zonaSeleccionada.Id
                            
                            
                            buttonText = "Actualizar"
                        }else{
                            //                             limpiarFormulario()
                            
                        }
                        
                    }.onAppear {
                        
                        
                        viewModelTema.fetchCatalogoCursosTemas()
                        
                        
                        
                    }.toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                buttonText = "Agregar"
                                limpiarFormulario()
                                showAlert.toggle()
                            }) {
                                
                                Image(systemName: "plus")
                                
                            }.alert(isPresented: $showAlert) {
                                Alert(title: Text("Aviso"), message: Text("Agrega un nuevo tema"), dismissButton: .default(Text("Aceptar")))
                            }
                        }
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
                    
                }
                

                
                Section {
                    Button(action: {
                        if todosLosCamposEstanCompletos() {
                            if buttonText == "Agregar"{
                                avisoText = "Registro Agregado"
                                showAlertAgregarModificar.toggle()
                                let nuevoTema = CatalogoCursosTemas(
                                                     Id:"",
                                                     IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
                                                     Fecha: "2024-01-30T19:06:05.675Z",
                                                     Nombre: _Nombre,
                                                     Notas: _Notas,
                                                     Observaciones:"N/A",
                                                     Link:"",
                                                     Status:true,
                                                     Borrado: false
                                )
                                viewModelTema.agregarCatalogoTemas(nuevoCatalogoTemas: nuevoTema)
                                viewModelTema.fetchCatalogoCursosTemas()
                            }else{
                                avisoText = "Registro Modificado"
                                showAlertAgregarModificar.toggle()
                                let tema = CatalogoCursosTemas(
                                    Id:_Id,
                                    IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
                                    Fecha: "2024-01-30T19:06:05.675Z",
                                    Nombre: _Nombre,
                                    Notas: _Notas,
                                    Observaciones:"N/A",
                                    Link:"",
                                    Status:true,
                                    Borrado: false
                                )
                                viewModelTema.editarCatalogoCursosTemas(catalogoCursosTemas: tema)
                                viewModelTema.fetchCatalogoCursosTemas()
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
            .navigationTitle("Zonas")
        }
    }
}

#Preview {
    ZonasView()
}

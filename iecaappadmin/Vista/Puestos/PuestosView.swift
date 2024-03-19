//
//  PuestosView.swift
//  iecaappadmin
//
//  Created by Omar on 26/02/24.
//

import SwiftUI

struct PuestosView: View {
    @Binding var presentSideMenu: Bool
    @Binding var showSignInView: Bool
    
    @State private var _Nombre = ""
    @State private var _Id = ""
    @State private var _Notas = ""
    @State private var buttonText = "Agregar"
    @StateObject var viewModelPuesto = PuestosViewModel()
    
    
    @State var seleccionPuesto: Int = 0
    
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
        _Id = ""
        _Notas = ""
        buttonText = "Agregar"
        seleccionPuesto = 0
    }
    
    func validarNombre() -> Bool {
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
                Section(header: Text("Selecciona un puesto")) {
                    Picker("Puesto", selection: $seleccionPuesto) {
                        //                        ForEach(viewModelPuesto.puesto.indices.map { $0}, id: \.self) { index in
                        //                            Text(viewModelPuesto.puesto[index].Nombre)
                        //                                .tag(index)
                        //                        }
                        
                        let i = 0
                        ForEach([0] + viewModelPuesto.puesto.indices.map { $0 + 1 }, id: \.self) { index in
                            if index == 0 {
                                Text("")
                                    .tag(0)
                            } else {
                                Text(viewModelPuesto.puesto[index - 1].Nombre)
                                    .tag(index)
                            }
                        }
                    }.onAppear {
                        
                        viewModelPuesto.fetchPuesto()
                        
                    }.onChange(of: seleccionPuesto) { index in
                        
                        print(index)
                        if index != 0 {
                            let titularSeleccionada = viewModelPuesto.puesto[index-1]
                            //                            let titularSeleccionada = viewModelPuesto.puesto[seleccionPuesto]
                            _Id = titularSeleccionada.Id
                            _Nombre = titularSeleccionada.Nombre
                            _Notas = titularSeleccionada.Notas
                            
                            buttonText = "Actualizar"
                        }else{
                            //                            limpiarFormulario()
                            
                        }
                        
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
                        Alert(title: Text("Aviso"), message: Text("Agrega un nuevo puesto"), dismissButton: .default(Text("Aceptar")))
                    }
                }
                
                Section() {
                    TextField("Nombre", text: $_Nombre)
                    VStack(alignment: .leading) {
                        Text("Notas:") // Etiqueta para el TextEditor
                            .font(.headline)
                            .padding(.top)
                        
                        TextEditor(text: $_Notas)
                            .frame(minHeight: 50) // Altura mínima del TextEditor
                            .padding()
                            .background(Color.gray.opacity(0.1)) // Fondo del TextEditor
                            .cornerRadius(8) // Bordes redondeados
                            .padding()
                    }
                }
//                HStack{
//                    Spacer()
//                    Image("logo") // Reemplaza "tu_imagen" con el nombre de tu imagen en el catálogo de activos
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 100, height: 100) // Ajusta el tamaño según sea necesario
//                        .clipShape(Circle()) // Opcional: recorta la imagen en forma de círculo
//                        .overlay(Circle().stroke(Color.blue, lineWidth: 4)) // Opcional: agrega un borde alrededor de la imagen
//                        .shadow(radius: 10)
//                    Spacer()
//                }
                
                Section {
                    Button(action: {
                        if validarNombre() {
                            if buttonText == "Agregar"{
                                avisoText = "Registro Agregado"
                                showAlertAgregarModificar.toggle()
                                let nuevaPuesto = Puesto(Id: "",
                                                         IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
                                                         Nombre: _Nombre,
                                                         Notas: _Notas,
                                                         Fecha: "2024-01-30T19:06:05.675Z",
                                                         borrado: false
                                )
                                viewModelPuesto.agregarNuevaPuesto(nuevaPuesto: nuevaPuesto)
                                viewModelPuesto.fetchPuesto()
                            }else{
                                avisoText = "Registro Modificado"
                                showAlertAgregarModificar.toggle()
                                let puesto = Puesto(Id: _Id,
                                                    IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
                                                    Nombre: _Nombre,
                                                    Notas: _Notas,
                                                    Fecha: "2024-01-30T19:06:05.675Z",
                                                    borrado: false
                                )
                                viewModelPuesto.editarPuesto(puesto: puesto)
                                viewModelPuesto.fetchPuesto()
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
            .navigationTitle("Puestos")
            
        }
    }
}

//#Preview {
//    PuestosView()
//}

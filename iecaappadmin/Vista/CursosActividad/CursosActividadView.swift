//
//  ZonasView.swift
//  iecaappadmin
//
//  Created by Omar on 26/02/24.
//

import SwiftUI
import FirebaseStorage
import MobileCoreServices
import UIKit
import UniformTypeIdentifiers
struct CursosActividadView: View {
    
    @State private var selectedFile: URL?
    @State private var fileURL: URL?
    let storage = Storage.storage()
    
    @State var seleccionCurso: Int = 0
    @State var seleccionActividad: Int = 0
    @StateObject var viewModelCursos = CursosViewModel()
    @StateObject var viewModelActividad = CatalogoCursosActividadesViewModel()
    
    @State var selectMinutos: Int = 0
    @State var selectPosicion: Int = 0
    
    @State private var minutes = 0
    @State private var posicion = 0
    
    @State private var _Link1 = ""
    
    
    
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
    @State private var pickerAbierto = false
    @State private var isPlusButtonPressed = false
    @State private var isMinusButtonPressed = false
    
    
    //    @State private var selectedFile: URL?
    @State private var isDocumentPickerPresented = false
    
    
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
    
    //    func uploadFile(from url: URL) {
    //        // Configura una referencia al archivo en Firebase Storage
    //        let storageRef = storage.reference().child("uploads").child(url.lastPathComponent)
    //
    //        // Sube el archivo al Firebase Storage
    //        storageRef.putFile(from: url, metadata: nil) { metadata, error in
    //            if let error = error {
    //                print("Error al cargar el archivo: \(error.localizedDescription)")
    //            } else {
    //                print("¡Archivo cargado exitosamente!")
    //                // Aquí puedes realizar cualquier acción adicional después de cargar el archivo, si es necesario
    //            }
    //        }
    //    }
    //    func uploadFile() {
    //        // Configura una referencia al archivo en Firebase Storage
    //        let storageRef = storage.reference().child("uploads").child("example.jpg")
    //
    //        // Aquí deberías tener el URL del archivo local que quieres subir
    //        guard let localFileURL = fileURL else {
    //            print("No se ha seleccionado ningún archivo")
    //            return
    //        }
    //
    //        // Sube el archivo al Firebase Storage
    //        storageRef.putFile(from: localFileURL, metadata: nil) { metadata, error in
    //            if let error = error {
    //                print("Error al cargar el archivo: \(error.localizedDescription)")
    //            } else {
    //                print("¡Archivo cargado exitosamente!")
    //            }
    //        }
    //    }
    
    //    func makeCoordinator() -> Coordinator {
    //            Coordinator(self)
    //        }
    //
    //    class Coordinator: NSObject, UIDocumentPickerDelegate {
    //        var parent: CursosActividadView
    //
    //        init(_ parent: CursosActividadView) {
    //            self.parent = parent
    //        }
    //
    //        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
    //            if let selectedFileURL = urls.first {
    //                parent.selectedFile = selectedFileURL
    //                parent.fileURL = selectedFileURL // Asigna la URL seleccionada a la variable fileURL
    //                print("Ruta del archivo seleccionado: \(selectedFileURL.path)")
    //                parent.uploadFile()
    //            }else{
    //                print("nel")
    //            }
    //        }
    //    }
    
    
    var body: some View {
        NavigationStack{
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: 400, height: 150)
                .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 4)
                .overlay(
                    
                    VStack{
                        Section(header: Text("Selecciona una Actividad") .frame(maxWidth: .infinity, alignment: .leading)) {
                            Picker("Actividades", selection: $seleccionActividad) {
                                ForEach(viewModelActividad.catalogoCursosActividades.indices, id: \.self) { index in
                                    Text(viewModelActividad.catalogoCursosActividades[index].Nombre)
                                        .tag(index)
                                }
                            }
                            .disabled(pickerAbierto)
                        }
                        Section(header: Text("Selecciona un curso y actividad") .frame(maxWidth: .infinity, alignment: .leading)) {
                            Picker("Cursos", selection: $seleccionCurso) {
                                
                                ForEach(viewModelCursos.cursos.indices.map { $0}, id: \.self) { index in
                                    Text(viewModelCursos.cursos[index].Nombre)
                                        .tag(index)
                                }
                            }.onChange(of: seleccionCurso) { index in
                                print(index)
                                if index != 0 {
                                    let zonaSeleccionada = viewModelCursos.cursos[index]
                                    
                                    _Nombre = zonaSeleccionada.Nombre
                                    _Notas = zonaSeleccionada.Notas
                                    _Id = zonaSeleccionada.Id
                                    
                                    
                                    buttonText = "Actualizar"
                                }else{
                                    //                             limpiarFormulario()
                                    
                                }
                                
                            }.onAppear {
                                
                                
                                viewModelCursos.fetchCursos()
                                viewModelActividad.fetchCatalogoCursosCampoDeFormacion()
                                
                                
                                
                            }.toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button(action: {
                                        buttonText = "Agregar"
                                        limpiarFormulario()
                                        showAlert.toggle()
                                    }) {
                                        
                                        Image(systemName: "plus")
                                        
                                    }.alert(isPresented: $showAlert) {
                                        Alert(title: Text("Aviso"), message: Text("Agrega una nueva actividad"), dismissButton: .default(Text("Aceptar")))
                                    }
                                }
                            }
                            HStack {
                                Picker("Actividades", selection: $seleccionActividad) {
                                    ForEach(viewModelActividad.catalogoCursosActividades.indices, id: \.self) { index in
                                        Text(viewModelActividad.catalogoCursosActividades[index].Nombre)
                                            .tag(index)
                                    }
                                }
                                .disabled(pickerAbierto) // Deshabilita el picker si está abierto
                                
                                Button(action: {
                                    // Acción para el botón de editar
                                }) {
                                    Image(systemName: "pencil") .font(.system(size: 30))
                                }.frame(width: 60, height: 60) // Establece el tamaño del botón
                                    .disabled(pickerAbierto) // Deshabilita el botón si el picker está abierto
                                
                                Button(action: {
                                    // Acción para el botón de agregar
                                }) {
                                    Image(systemName: "plus").font(.system(size: 30))
                                }
                                .disabled(pickerAbierto) // Deshabilita el botón si el picker está abierto
                            }
                        }
                        
                        
                        Section() {
                            
                            HStack {
                                HStack {
                                    Text("posicion")
                                        .font(.headline)
                                    Text("\(posicion)")
                                        .font(.headline)
                                    VStack {
                                        Button(action: {
                                            posicion += 1
                                        }) {
                                            Image(systemName: "plus.circle")
                                                .font(.title)
                                        }
                                        Button(action: {
                                            if posicion > 0 {
                                                posicion -= 1
                                            }
                                        }) {
                                            Image(systemName: "minus.circle")
                                                .font(.title)
                                        }
                                    }
                                }
                                .padding()
                                
                                Spacer()
                                HStack {
                                    Text("Minutos")
                                        .font(.headline)
                                    Text("\(minutes)")
                                        .font(.headline)
                                    VStack {
                                        Button(action: {
                                            minutes += 1
                                        }) {
                                            Image(systemName: "plus.circle")
                                                .font(.title)
                                        }
                                        Button(action: {
                                            if minutes > 0 {
                                                minutes -= 1
                                            }
                                        }) {
                                            Image(systemName: "minus.circle")
                                                .font(.title)
                                        }
                                    }
                                }
                                .padding()
                            }
                            
                            HStack{
                                
                                Button(action: {
                                    // Aquí deberías implementar la lógica para seleccionar un archivo desde el dispositivo
                                    // En este ejemplo, simplemente establecemos un URL de archivo de ejemplo
                                    self.fileURL = URL(fileURLWithPath: "path/to/your/file")
                                }) {
                                    HStack {
                                        Image(systemName: "arrow.up.doc") // Icono de carga
                                        //                                           Text("Cargar archivo") // Texto del botón
                                    }
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                }
                                .padding()
                                
                                Button(action: {
                                    // Acción que deseas realizar al hacer clic en el botón
                                }) {
                                    Image(systemName: "eye")
                                        .font(.title)
                                        .foregroundColor(.blue) // Color del icono
                                    
                                }
                                
                                TextField("Link 1", text: $_Link1)
                                    .padding()
                                    .border(Color.gray, width: 1) // Agrega un borde alrededor del TextField
                                    .padding() // Agrega espacio alrededor del TextField
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                
                                
                                
                                
                            }
                            
                            HStack{
                                
                                Button(action: {
                                    // Aquí deberías implementar la lógica para seleccionar un archivo desde el dispositivo
                                    // En este ejemplo, simplemente establecemos un URL de archivo de ejemplo
                                    self.fileURL = URL(fileURLWithPath: "path/to/your/file")
                                }) {
                                    HStack {
                                        Image(systemName: "arrow.up.doc") // Icono de carga
                                        //                                           Text("Cargar archivo") // Texto del botón
                                    }
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                }
                                .padding()
                                
                                Button(action: {
                                    // Acción que deseas realizar al hacer clic en el botón
                                }) {
                                    Image(systemName: "eye")
                                        .font(.title)
                                        .foregroundColor(.blue) // Color del icono
                                }
                                
                                TextField("Link 1", text: $_Link1)
                                    .padding()
                                    .border(Color.gray, width: 1) // Agrega un borde alrededor del TextField
                                    .padding() // Agrega espacio alrededor del TextField
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                
                                
                                
                                
                            }
                            VStack {
                                if let fileURL = selectedFile {
                                    
                                    Text(" \(fileURL.lastPathComponent)")
                                        .padding()
                                } else {
                                    Text("No se ha seleccionado ningún archivo")
                                        .padding()
                                }
                                
                                Button("Seleccionar Archivo") {
                                    isDocumentPickerPresented = true
                                }
                                .sheet(isPresented: $isDocumentPickerPresented) {
                                    DocumentPicker(selectedFile: $selectedFile)
                                }
                                .padding()
                            }
                            
                            //                    Button("Seleccionar Archivo") {
                            //
                            //                        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf, .text])
                            //                        print("Funciona ???")
                            //                          documentPicker.allowsMultipleSelection = false
                            //                          documentPicker.delegate = self.makeCoordinator()
                            //                        print(documentPicker)
                            //                          UIApplication.shared.windows.first?.rootViewController?.present(documentPicker, animated: true)
                            //                    }
                            //                               .padding()
                            //
                            //                    if let fileURL = selectedFile {
                            //                        Text("Archivo Seleccionado: \(fileURL.lastPathComponent)")
                            //                            .padding()
                            //                    }else{
                            //                        Text("No funciona")
                            //                            .padding()
                            //                    }
                            //                               if let fileURL = selectedFile {
                            //                                   Text("Archivo Seleccionado: \(fileURL.lastPathComponent)")
                            //                                       .padding()
                            //                               }
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
                                        let nuevaZona = Zona(Id:"",
                                                             IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
                                                             Nombre: _Nombre,
                                                             Notas: _Notas,
                                                             Fecha: "2024-01-30T19:06:05.675Z",
                                                             borrado: false
                                        )
                                        //                                viewModelZona.agregarNuevaZona(nuevaZona: nuevaZona)
                                        //                                viewModelZona.fetchZonas()
                                    }else{
                                        avisoText = "Registro Modificado"
                                        showAlertAgregarModificar.toggle()
                                        let zona = Zona(
                                            Id:_Id,
                                            IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
                                            Nombre: _Nombre,
                                            Notas: _Notas,
                                            Fecha: "2024-01-30T19:06:05.675Z",
                                            borrado: false
                                        )
                                        //                                viewModelZona.editarZona(zona: zona)
                                        //                                viewModelZona.fetchZonas()
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
                    }.padding(.leading, 8) .padding(.top, 20) //
                )
                .padding(.top, 20)
        }
        
    }
}


#Preview {
    CursosActividadView()
}

import SwiftUI

struct CursosAutorizacionView: View {
    @StateObject var viewModelCurso = CursosViewModel()
    @State var seleccionCurso: Int = 0
    
    @StateObject var viewModelUsuario = UsuariosViewModel()
    @State var seleccionUsuario: Int = 0
    
    @StateObject var viewModelAutorizacion = CursosAutorizacionViewModel()
    @State var seleccionAutorizacion: Int = 0
    
    @State private var selectedCurso = 0
    @State private var selectedUsuario = 0
    @State private var elaboroChecked = false
    @State private var revisoChecked = false
    @State private var validoChecked = false
    @State private var aproboChecked = false
    @State private var autorizoChecked = false
    @State private var fechaSeleccionada = Date()
    @State private var notas = ""
    @State private var idCurso = ""
    @State private var idUsuario = ""
    @State private var avisoText = ""
    @State private var id = ""
    @State private var showAlertAgregarModificar = false
    @State private var buttonText = "Agregar"
    @State private var showAlert = false
    
    let cursos = ["Curso 1", "Curso 2", "Curso 3"] // Ejemplo de nombres de cursos
    let usuarios = ["Usuario 1", "Usuario 2", "Usuario 3"] // Ejemplo de nombres de usuarios
    
    func todosLosCamposEstanCompletos() -> Bool {
        // Verificar si el campo de nombre no está vacío
//        guard !_Nombre.isEmpty else {
//            // Si el campo está vacío, retornar falso
//            return false
//        }
//        
        // Si el campo no está vacío, retornar verdadero
        return true
    }
    
    var body: some View {
        NavigationView {
            Form {
                
//                Picker("Autorizaciones", selection: $seleccionAutorizacion) {
//                    
//                    ForEach(viewModelAutorizacion.autorizaciones.indices.map { $0}, id: \.self) { index in
//                        Text(viewModelAutorizacion.autorizaciones[index].)
//                            .tag(index)
//                    }
//                }
                Section(header: Text("Seleccione el Curso")) {
                    Picker("Cursos", selection: $seleccionCurso) {
                        
                        ForEach(viewModelCurso.cursos.indices.map { $0}, id: \.self) { index in
                            Text(viewModelCurso.cursos[index].Nombre)
                                .tag(index)
                        }
                        
//
//                        let i = 0
//                        ForEach([0] + viewModelCurso.cursos.indices.map { $0 + 1 }, id: \.self) { index in
//                            if index == 0 {
//                                Text("")
//                                    .tag(0)
//                            } else {
//                                Text(viewModelCurso.cursos[index - 1].Nombre)
//                                    .tag(index)
//                            }
//                        }
                    }.onAppear {
                        
                        
                        viewModelCurso.fetchCursos()
                        viewModelUsuario.fetchUsuarios()
                        
                        
                        
                    }
                }
                Picker("Cursos", selection: $seleccionUsuario) {
                    
                    ForEach(viewModelUsuario.usuarios.indices.map { $0}, id: \.self) { index in
                        Text(viewModelUsuario.usuarios[index].Nombre)
                            .tag(index)
                    }

                }
              
                Section(header: Text("Acciones")) {
                    Toggle("Elaboró", isOn: $elaboroChecked)
                    Toggle("Revisó", isOn: $revisoChecked)
                    Toggle("Validó", isOn: $validoChecked)
                    Toggle("Aprobó", isOn: $aproboChecked)
                    Toggle("Autorizó", isOn: $autorizoChecked)
                }
                
                Section(header: Text("Fecha")) {
                    DatePicker("Fecha", selection: $fechaSeleccionada, displayedComponents: .date)
                }
                
                Section(header: Text("Notas")) {
                    TextEditor(text: $notas)
                        .frame(minHeight: 100)
                        .cornerRadius(8)
                        .padding(.vertical)
                }
                
                Section {
                    Button(action: {
                        if todosLosCamposEstanCompletos() {
                            if buttonText == "Agregar"{
                                avisoText = "Registro Agregado"
                                showAlertAgregarModificar.toggle()
                                let nuevaAutorizacion = CursosAutorizaciones(
                                     Id: "",
                                     IdCurso: idCurso,
                                     IdUsuario: idUsuario,
                                     FechaOperacion: fechaSeleccionada,
                                     Elabora: elaboroChecked,
                                     Revisa: revisoChecked,
                                     Valida: validoChecked,
                                     Aprueba: aproboChecked,
                                     Autoriza: autorizoChecked,
                                     Notas: notas,
                                     Observaciones: " ",
                                     Fecha: "2024-01-30T19:06:05.675Z",
                                     IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
                                     Borrado: false
                                    
                                    
                                )
                                viewModelAutorizacion.agregarNuevaAutorizacion(nuevaAutorizacion: nuevaAutorizacion)
                                viewModelAutorizacion.fetchAutorizaciones()
                            }else{
                                avisoText = "Registro Modificado"
                                showAlertAgregarModificar.toggle()
                                let autorizacion = CursosAutorizaciones(
                                    Id: id,
                                    IdCurso: idCurso,
                                    IdUsuario: idUsuario,
                                    FechaOperacion: fechaSeleccionada,
                                    Elabora: elaboroChecked,
                                    Revisa: revisoChecked,
                                    Valida: validoChecked,
                                    Aprueba: aproboChecked,
                                    Autoriza: autorizoChecked,
                                    Notas: notas,
                                    Observaciones: " ",
                                    Fecha: "2024-01-30T19:06:05.675Z",
                                    IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
                                    Borrado: false
                                )
                                viewModelAutorizacion.editarAutorizacion(autorizacion: autorizacion)
                                viewModelAutorizacion.fetchAutorizaciones()
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
            .navigationBarTitle("Autorización de Curso")
        }
    }
}

//struct CursosAutorizacion_Previews: PreviewProvider {
//    static var previews: some View {
//        CursosAutorizaciones()
//    }
//}

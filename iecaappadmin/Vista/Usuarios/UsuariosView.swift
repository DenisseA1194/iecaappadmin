//
//  UsuariosView.swift
//  iecaappadmin
//
//  Created by Omar on 26/02/24.
//

import SwiftUI

struct UsuariosView: View {
    @State private var _Nombre: String = ""
    @State private var _ApellidoPaterno: String = ""
    @State private var _ApellidoMaterno: String = ""
    @State private var _FechaNacimiento: Date = Date()
    @State private var _NumeroIdentificador: String = ""
    @State private var _TelefonoMovil: String = ""
    @State private var _TelefonoFijo: String = ""
    @State private var _CorreoInstitucional: String = ""
    @State private var _CorreoPersonal: String = ""
    @State private var _IdSucursal: String = ""
    @State private var _IdDepartamento: String = ""
    @State private var _IdPuesto: String = ""
    @State private var _EstadoDocencia: Bool = false
    @State private var _FechaIngreso: Date = Date()
    @State private var _Estatus: Bool = false
    @State private var _Notas: String = ""
    @State private var _Id: String = ""
    
    
    @StateObject var viewModelApellido = ApellidoViewModel()
    @StateObject var viewModelUsuario = UsuariosViewModel()
    @StateObject var viewModelSucursal = SucursalesViewModel()
    @StateObject var viewModelPuesto = PuestosViewModel()
    @StateObject var viewModelUsuarioDepartamento = UsuarioDepartamentoViewModel()
    
    @State var seleccionApellidoPaterno: Int = 0
    @State var seleccionApellidoMaterno: Int = 0
    @State var seleccionSucursal: Int = 0
    @State var seleccionUsuario: Int = 0
    @State var seleccionDepartamento: Int = 0
    @State var seleccionPuesto: Int = 0
    @State private var buttonText = "Agregar"
    
    
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
        _ApellidoPaterno = ""
        _ApellidoMaterno = ""
        _FechaNacimiento = Date()
        _NumeroIdentificador = ""
        _TelefonoMovil = ""
        _TelefonoFijo = ""
        _CorreoInstitucional = ""
        _CorreoPersonal = ""
        _IdSucursal = ""
        _IdDepartamento = ""
        _IdPuesto = ""
        _EstadoDocencia = false
        _FechaIngreso = Date()
        _Estatus = false
        _Notas = ""
        _Id = ""
        seleccionApellidoPaterno = 0
        seleccionApellidoMaterno = 0
        seleccionSucursal = 0
        seleccionDepartamento = 0
        seleccionPuesto = 0
        buttonText = "Agregar"
        urlImagenFirebase = ""
    }
    
    func todosLosCamposEstanCompletos() -> Bool {
        // Verificar si todos los campos necesarios están llenos
        guard !_Nombre.isEmpty,
              !_ApellidoPaterno.isEmpty,
              !_ApellidoMaterno.isEmpty,
              !_NumeroIdentificador.isEmpty,
              !_TelefonoMovil.isEmpty,
              !_TelefonoFijo.isEmpty,
              !_CorreoInstitucional.isEmpty,
              !_CorreoPersonal.isEmpty,
              !_IdSucursal.isEmpty,
              !_IdDepartamento.isEmpty,
              !_IdPuesto.isEmpty,
//              !_EstadoDocencia.isEmpty,
              let urlImagenFirebase = urlImagenFirebase else {
                  // Si algún campo está vacío, retornar falso
                  return false
              }
        
        // Si todos los campos están llenos, retornar verdadero
        return true
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("")) {
                    Picker("Selecciona un usuario", selection: $seleccionUsuario) {

                        let i = 0
                        ForEach([0] + viewModelUsuario.usuarios.indices.map { $0 + 1 }, id: \.self) { index in
                            if index == 0 {
                                Text("")
                                    .tag(0)
                            } else {
                                Text(viewModelUsuario.usuarios[index - 1].Nombre)
                                    .tag(index)
                            }
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
                    }
                }.alert(isPresented: $showAlert) {
                    Alert(title: Text("Aviso"), message: Text("Agrega una nuevo usuario"), dismissButton: .default(Text("Aceptar")))
                }.onChange(of: seleccionUsuario) { index in
                   // Cadena de texto con la fecha de nacimiento
                   
                    print(index)
                    if index != 0 {
        
                        let UsuarioSeleccionado = viewModelUsuario.usuarios[index-1]
                        
                        let fechaIngreso = UsuarioSeleccionado.FechaIngreso
                        let fechaNacimiento = UsuarioSeleccionado.FechaNacimiento
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                        
                        
                        if let date1 = dateFormatter.date(from: fechaIngreso) {
                            // La cadena de texto se pudo convertir a un objeto Date correctamente
                            _FechaNacimiento = date1
                        } else {
                            // No se pudo convertir la cadena de texto a un objeto Date
                            print("Error: No se pudo convertir la cadena de texto a Date ", UsuarioSeleccionado.FechaIngreso)
                        }
                        
                        if let date = dateFormatter.date(from: fechaNacimiento) {
                            // La cadena de texto se pudo convertir a un objeto Date correctamente
                            _FechaIngreso = date
                        } else {
                            // No se pudo convertir la cadena de texto a un objeto Date
                            print("Error: No se pudo convertir la cadena de texto a Date ",  UsuarioSeleccionado.FechaNacimiento)
                        }
                        
                        print(UsuarioSeleccionado.Nombre)
                        _Nombre = UsuarioSeleccionado.Nombre
                        _ApellidoPaterno = UsuarioSeleccionado.ApellidoPaterno
                        _ApellidoMaterno = UsuarioSeleccionado.ApellidoMaterno
//                        _FechaNacimiento = dateFormatter.date(from: UsuarioSeleccionado.FechaNacimiento)!
                        _NumeroIdentificador = UsuarioSeleccionado.Numero
                        _TelefonoMovil = UsuarioSeleccionado.TelefonoMovil
                        _TelefonoFijo = UsuarioSeleccionado.TelefonoFijo
                        _CorreoInstitucional = UsuarioSeleccionado.CorreoInstitucional
                        _CorreoPersonal = UsuarioSeleccionado.CorreoPersonal
                        _IdSucursal = UsuarioSeleccionado.IdSucursal
                        _IdDepartamento = UsuarioSeleccionado.IdDepartamento
                        _IdPuesto = UsuarioSeleccionado.IdPuesto
//                        _EstadoDocencia = UsuarioSeleccionado.Estado
//                        _FechaIngreso = dateFormatter.date(from: UsuarioSeleccionado.FechaIngreso)!
                        _Estatus = UsuarioSeleccionado.Estatus
                        _Notas = UsuarioSeleccionado.Notas
                        _Id = UsuarioSeleccionado.Id
                        urlImagenFirebase! = UsuarioSeleccionado.FotoLink
                       
                        _EstadoDocencia = UsuarioSeleccionado.Estado
                        
                        
                        if let posicionRegistro = viewModelApellido.apellido.firstIndex(where: { $0.Id.uppercased() == UsuarioSeleccionado.ApellidoPaterno.uppercased() }) {
                            seleccionApellidoPaterno = posicionRegistro
                        }
                        
                        if let posicionRegistro = viewModelApellido.apellido.firstIndex(where: { $0.Id.uppercased() == UsuarioSeleccionado.ApellidoMaterno.uppercased() }) {
                            seleccionApellidoMaterno = posicionRegistro
                        }
                        
                        if let posicionRegistro = viewModelSucursal.sucursales.firstIndex(where: { $0.Id.uppercased() == UsuarioSeleccionado.IdSucursal.uppercased() }) {
                            seleccionSucursal = posicionRegistro
                        }
                        
                        if let posicionRegistro = viewModelUsuarioDepartamento.departamento.firstIndex(where: { $0.Id.uppercased() == UsuarioSeleccionado.IdDepartamento.uppercased() }) {
                            seleccionDepartamento = posicionRegistro
                        }
                        
                        if let posicionRegistro = viewModelPuesto.puesto.firstIndex(where: { $0.Id.uppercased() == UsuarioSeleccionado.IdPuesto.uppercased() }) {
                            seleccionPuesto = posicionRegistro
                        }
                        
                        buttonText = "Actualizar"
                    }else{
//                        limpiarFormulario()
                        
                    }
                    
                    
                }.onAppear {
                    viewModelUsuario.fetchUsuarios()
                    viewModelApellido.fetchApellidos()
                    viewModelSucursal.fetchSucursales()
                    viewModelUsuarioDepartamento.fetchDepartamentos()
                    viewModelPuesto.fetchPuesto()
                    
                }
                
                Section(header: Text("")) {
                    TextField("Nombre", text: $_Nombre)
                    
                    HStack {
                        Picker("Apellido Paterno", selection: $seleccionApellidoPaterno) {
                            ForEach(viewModelApellido.apellido.indices, id: \.self) { index in
                                Text(viewModelApellido.apellido[index].Apellido)
                                    .tag(index)
                            }
                        }.onChange(of: seleccionApellidoPaterno) { index in
                            let titularSeleccionada = viewModelApellido.apellido[seleccionApellidoPaterno]
                            _ApellidoPaterno = titularSeleccionada.Id
                        }
                        
                    }
                    Picker("Apellido Materno", selection: $seleccionApellidoMaterno) {
                        ForEach(viewModelApellido.apellido.indices.map { $0}, id: \.self) { index in
                            Text(viewModelApellido.apellido[index].Apellido)
                                .tag(index)
                        }
                        
                    }.onChange(of: seleccionApellidoMaterno) { index in
                        let titularSeleccionada = viewModelApellido.apellido[seleccionApellidoMaterno]
                        _ApellidoMaterno = titularSeleccionada.Id
                    }
                    
                    DatePicker("Fecha de Nacimiento", selection: $_FechaNacimiento, displayedComponents: .date)
                    TextField("Número o Identificador", text: $_NumeroIdentificador)
                    TextField("Teléfono Móvil", text: $_TelefonoMovil)
                    TextField("Teléfono Fijo", text: $_TelefonoFijo)
                    TextField("Correo Institucional", text: $_CorreoInstitucional)
                    TextField("Correo Personal", text: $_CorreoPersonal)
                    
                    Picker("Sucursal", selection: $seleccionSucursal) {
                        ForEach(viewModelSucursal.sucursales.indices.map { $0}, id: \.self) { index in
                            Text(viewModelSucursal.sucursales[index].Nombre)
                                .tag(index)
                        }
                        
                    }.onChange(of: seleccionSucursal) { index in
                        let titularSeleccionada = viewModelSucursal.sucursales[seleccionSucursal]
                        _IdSucursal = titularSeleccionada.Id
                    }
                    
                    
                    Picker("Departamento", selection: $seleccionDepartamento) {
                        ForEach(viewModelUsuarioDepartamento.departamento.indices.map { $0}, id: \.self) { index in
                            Text(viewModelUsuarioDepartamento.departamento[index].Nombre)
                                .tag(index)
                        }
                    }.onChange(of: seleccionDepartamento) { index in
                        let titularSeleccionada = viewModelUsuarioDepartamento.departamento[seleccionDepartamento]
                        _IdDepartamento = titularSeleccionada.Id
                    }
                    
                    Picker("Puesto", selection: $seleccionPuesto) {
                        ForEach(viewModelPuesto.puesto.indices.map { $0}, id: \.self) { index in
                            Text(viewModelPuesto.puesto[index].Nombre)
                                .tag(index)
                        }
                        
                    }.onChange(of: seleccionPuesto) { index in
                        let titularSeleccionada = viewModelPuesto.puesto[seleccionPuesto]
                        _IdPuesto = titularSeleccionada.Id
                    }
                    
                    Picker("Estado de Docencia", selection: $_EstadoDocencia) {
                        Text("Activo").tag(0)
                        Text("Inactivo").tag(1)
                    }
                    
                    DatePicker("Fecha de Ingreso", selection: $_FechaIngreso, displayedComponents: .date)
                    Toggle("Estatus", isOn: $_Estatus)
                }
                Section(header: Text("Notas")) {
                    TextEditor(text: $_Notas)
                        .frame(minHeight: 80) // Altura mínima del TextEditor
                        .padding()
                        .background(Color.gray.opacity(0.1)) // Fondo del TextEditor
                        .cornerRadius(8) // Bordes redondeados
                        .padding()
                }
                HStack {
                    Spacer()
                    if let selectedImage = urlImagenFirebase {
                        AsyncImage(url: URL(string: urlImagenFirebase ?? "logo")) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                            } else if phase.error != nil {
                                // Handle error
                                Image("logo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                            } else {
                                // Placeholder image or activity indicator while loading
//                                   /* */ProgressView()
                                Image("logo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                            }
                        }
                    } else {
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    }
                    Spacer()
                    Button("Seleccionar imagen") {
                        imageUrl = "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C/FotoUsuario/"
                        isShowingImagePicker.toggle()
                    }
                    .sheet(isPresented: $isShowingImagePicker) {
                        ImagePicker(image: $image, isPresented: $isShowingImagePicker, imageUrl: $imageUrl, urlImagenFirebase: $urlImagenFirebase)
                    }
                }
                Section {
                    Button(action: {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy/MM/dd"
                        if todosLosCamposEstanCompletos() {
                            if buttonText == "Agregar"{
                                avisoText = "Registro Agregado"
                                showAlertAgregarModificar.toggle()
                                let nuevaUsuario = Usuarios(
                                    Id: "",
                                    Nombre: _Nombre,
                                    ApellidoPaterno: _ApellidoPaterno,
                                    ApellidoMaterno: _ApellidoMaterno,
                                    FechaNacimiento: dateFormatter.string(from: _FechaNacimiento),
                                    Numero: _NumeroIdentificador,
                                    TelefonoMovil: _TelefonoMovil,
                                    TelefonoFijo: _TelefonoFijo,
                                    CorreoInstitucional: _CorreoInstitucional,
                                    CorreoPersonal: _CorreoPersonal,
                                    IdSucursal: _IdSucursal,
                                    IdDepartamento: _IdDepartamento,
                                    IdPuesto: _IdPuesto,
                                    Estado: _EstadoDocencia,
                                    FechaIngreso: dateFormatter.string(from: _FechaIngreso),
                                    Estatus: _Estatus,
                                    Notas: _Notas,
                                    borrado: false,
                                    FechaAlta: "2024-01-30T19:06:05.675Z",
                                    FotoLink: urlImagenFirebase!,
                                    IdFirebase: "",
                                    IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
                                )
                                viewModelUsuario.agregarNuevoUsuario(nuevoUsuario: nuevaUsuario)
                                limpiarFormulario()
                                
                            }else{
                                avisoText = "Registro Modificado"
                                showAlertAgregarModificar.toggle()
                                let usuario = Usuarios(
                                    Id: _Id,
                                    Nombre: _Nombre,
                                    ApellidoPaterno: _ApellidoPaterno,
                                    ApellidoMaterno: _ApellidoMaterno,
                                    FechaNacimiento: dateFormatter.string(from: _FechaNacimiento),
                                    Numero: _NumeroIdentificador,
                                    TelefonoMovil: _TelefonoMovil,
                                    TelefonoFijo: _TelefonoFijo,
                                    CorreoInstitucional: _CorreoInstitucional,
                                    CorreoPersonal: _CorreoPersonal,
                                    IdSucursal: _IdSucursal,
                                    IdDepartamento: _IdDepartamento,
                                    IdPuesto: _IdPuesto,
                                    Estado: _EstadoDocencia,
                                    FechaIngreso: dateFormatter.string(from: _FechaIngreso),
                                    Estatus: _Estatus,
                                    Notas: _Notas,
                                    borrado: false,
                                    FechaAlta: "2024-01-30T19:06:05.675Z",
                                    FotoLink: urlImagenFirebase!,
                                    IdFirebase: "",
                                    IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
                                )
                                viewModelUsuario.editarUsuario(usuario: usuario)
                                limpiarFormulario()
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
            .navigationTitle("Usuarios")
        }
        
    }
}

#Preview {
    UsuariosView()
}

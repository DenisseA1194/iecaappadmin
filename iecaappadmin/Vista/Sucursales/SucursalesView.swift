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
    @State private var _IdSucursalTipo = ""
    @State private var _Notas = ""
    @State private var _IdSucursal = ""
    @State private var buttonText = "Agregar"
    
    @StateObject var viewModel = SucursalesViewModel()
    @StateObject var viewModelSucursalTipo = SucursalTipoViewModel()
    @StateObject var viewModelZona = ZonasViewModel()
    @StateObject var viewModelRazonSocial = RazonSocialViewModel()
    @StateObject var viewModelUsuario = UsuariosViewModel()
    
    @State var seleccionSucursal: Int = 0
    @State var seleccionSucursalTipo: Int = 0
    @State var seleccionZona: Int = 0
    @State var seleccionRazonSocial: Int = 0
    @State var seleccionTitular: Int = 0
    @State var regimenFiscal: Int = 0
    
    
    @State private var imageUrl: String?
    @State private var urlImagenFirebase: String? = ""
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var image: Image?
    @State private var showAlert = false
    @State private var showAlertAgregarModificar = false
    @State private var avisoText = ""
    
    
    func validarCamposSucursal() -> Bool {
        // Verificar si todos los campos necesarios están llenos
        guard !_Nombre.isEmpty,
              !_Direccion.isEmpty,
              !_Ciudad.isEmpty,
              !_Telefono.isEmpty,
              !_Numero.isEmpty,
              !_Correo.isEmpty,
              !_Pais.isEmpty,
              !_IdTitular.isEmpty,
              !_IdRazonSocial.isEmpty,
              !_IdZona.isEmpty,
              !_IdSucursalTipo.isEmpty,
              let urlImagenFirebase = urlImagenFirebase else {
            // Si algún campo está vacío, retornar falso
            return false
        }
        
        // Si todos los campos están llenos, retornar verdadero
        return true
    }
    
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Selecciona una Sucursal")) {
                    Picker("Sucursales", selection: $seleccionSucursal) {
                        
                        let i = 0
                        ForEach([0] + viewModel.sucursales.indices.map { $0 + 1 }, id: \.self) { index in
                            if index == 0 {
                                Text("")
                                    .tag(0)
                            } else {
                                Text(viewModel.sucursales[index - 1].Nombre)
                                    .tag(index)
                            }
                        }
                    }.onChange(of: seleccionSucursal) { index in
                        
                        print(index)
                        if index != 0 {
                            let sucursalSeleccionada = viewModel.sucursales[index-1]
                            print(sucursalSeleccionada.Nombre)
                            _Nombre = sucursalSeleccionada.Nombre
                            _Direccion = sucursalSeleccionada.Direccion
                            _Ciudad = sucursalSeleccionada.Ciudad
                            _Telefono = sucursalSeleccionada.Telefono
                            _Numero = sucursalSeleccionada.Numero
                            _Correo = sucursalSeleccionada.Correo
                            _Pais = sucursalSeleccionada.Pais
                            _IdTitular = sucursalSeleccionada.IdTitular
                            _IdRazonSocial = sucursalSeleccionada.IdRazonSocial
                            _IdZona = sucursalSeleccionada.IdZona
                            _Notas = sucursalSeleccionada.Notas
                            _IdSucursalTipo = sucursalSeleccionada.IdSucursalTipo
                            _IdSucursal = sucursalSeleccionada.Id
                            urlImagenFirebase = sucursalSeleccionada.LinkImagen
                            
                            if let posicionRegistro = viewModelSucursalTipo.sucursalesTipo.firstIndex(where: { $0.Id.uppercased() == sucursalSeleccionada.IdSucursalTipo.uppercased() }) {
                                seleccionSucursalTipo = posicionRegistro
                            }
                            
                            if let posicionRegistro2 = viewModelZona.zonas.firstIndex(where: { $0.Id.uppercased() == sucursalSeleccionada.IdZona.uppercased() }) {
                                seleccionZona = posicionRegistro2
                            }
                            
                            if let posicionRegistro3 = viewModelRazonSocial.razonSocials.firstIndex(where: { $0.Id.uppercased() == sucursalSeleccionada.IdRazonSocial.uppercased() }) {
                                seleccionRazonSocial = posicionRegistro3
                            }
                            
                            if let posicionRegistro4 = viewModelUsuario.usuarios.firstIndex(where: { $0.Id.uppercased() == sucursalSeleccionada.IdTitular.uppercased() }) {
                                seleccionTitular = posicionRegistro4
                            }
                            
                            buttonText = "Actualizar"
                        }else{
                            limpiarFormulario()
                            
                        }
                        
                        
                    }.onAppear {
                        
                        viewModel.fetchSucursales()
                        viewModelSucursalTipo.fetchSucursalesTipo()
                        viewModelZona.fetchZonas()
                        viewModelRazonSocial.fetchRazonSocials()
                        viewModelUsuario.fetchUsuarios()
                        seleccionSucursal = 0
                        
                        
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
                    TextField("Dirección", text: $_Direccion)
                    TextField("Ciudad", text: $_Ciudad)
                    TextField("Teléfono", text: $_Telefono)
                        .keyboardType(.numberPad)
                    TextField("Identificador/Número", text: $_Numero)
                        .keyboardType(.numberPad)
                    TextField("Correo", text: $_Correo)
                    TextField("País", text: $_Pais)
                    
                    Picker("Titular", selection: $seleccionTitular) {
                        ForEach(viewModelUsuario.usuarios.indices.map { $0}, id: \.self) { index in
                            Text(viewModelUsuario.usuarios[index].Nombre)
                                .tag(index)
                        }
                        
                    }.onChange(of: seleccionTitular) { index in
                        let titularSeleccionada = viewModelUsuario.usuarios[seleccionTitular]
                        _IdTitular = titularSeleccionada.Id
                    }
                    
                    
                    Picker("Razon social", selection: $seleccionRazonSocial) {
                        ForEach(viewModelRazonSocial.razonSocials.indices.map { $0}, id: \.self) { index in
                            Text(viewModelRazonSocial.razonSocials[index].Nombre)
                                .tag(index)
                        }
                    }.onChange(of: seleccionRazonSocial) { index in
                        let razonSocialSeleccionada = viewModelRazonSocial.razonSocials[seleccionRazonSocial]
                        _IdRazonSocial = razonSocialSeleccionada.Id
                        
                    }
                    
                    
                    Picker("Zona", selection: $seleccionZona) {
                        ForEach(viewModelZona.zonas.indices.map { $0}, id: \.self) { index in
                            Text(viewModelZona.zonas[index].Nombre)
                                .tag(index)
                        }
                    }.onChange(of: seleccionZona) { index in
                        let zonaSeleccionada = viewModelZona.zonas[seleccionZona]
                        _IdZona = zonaSeleccionada.Id
                        
                    }
                    
                    Picker("Tipo", selection: $seleccionSucursalTipo) {
                        
                        ForEach(viewModelSucursalTipo.sucursalesTipo.indices.map { $0}, id: \.self) { index in
                            
                            Text(viewModelSucursalTipo.sucursalesTipo[index].Nombre)
                                .tag(index)
                            
                        }
                        
                    }.onChange(of: seleccionSucursalTipo) { index in
                        let sucursalTipoSeleccionada = viewModelSucursalTipo.sucursalesTipo[seleccionSucursalTipo]
                        _IdSucursalTipo = sucursalTipoSeleccionada.Id
                    }
                }
                Section(header: Text("Notas")) {
                    TextEditor(text: $_Notas)
                        .frame(minHeight: 80)
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
                        imageUrl = "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C/LogoSucursal/"
                        isShowingImagePicker.toggle()
                    }
                    .sheet(isPresented: $isShowingImagePicker) {
                        ImagePicker(image: $image, isPresented: $isShowingImagePicker, imageUrl: $imageUrl, urlImagenFirebase: $urlImagenFirebase)
                    }
                }
                
                Section {
                    Button(action: {
                        if validarCamposSucursal() {
                            if buttonText == "Agregar"{
                                avisoText = "Registro Agregado"
                                showAlertAgregarModificar.toggle()
                                let nuevaSucursal = Sucursal(Id: _IdSucursal,
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
                                                             IdSucursalTipo: _IdSucursalTipo,
                                                             Notas: _Notas,
                                                             borrado: false,
                                                             Fecha: "2024-01-30T19:06:05.675Z",
                                                             LinkImagen: urlImagenFirebase!,
                                                             IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
                                )
                                viewModel.agregarNuevaSucursal(nuevaSucursal: nuevaSucursal)
                                viewModel.fetchSucursales()
                                limpiarFormulario()
                            }else{
                                avisoText = "Registro Modificado"
                                showAlertAgregarModificar.toggle()
                                let sucursal = Sucursal(Id: _IdSucursal,
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
                                                        IdSucursalTipo: _IdSucursalTipo,
                                                        Notas: _Notas,
                                                        borrado: false,
                                                        Fecha: "2024-01-30T19:06:05.675Z",
                                                        LinkImagen: urlImagenFirebase!,
                                                        IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
                                )
                                viewModel.editarSucursal(sucursal: sucursal)
                                viewModel.fetchSucursales()
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
            .navigationTitle("Sucursales")
            
        }
    }
    
    func limpiarFormulario() {
        _Nombre = ""
        _Direccion = ""
        _Ciudad = ""
        _Telefono = ""
        _Numero = ""
        _Correo = ""
        _Pais = ""
        _IdTitular = ""
        _IdRazonSocial = ""
        _IdZona = ""
        _IdSucursalTipo = ""
        _Notas = ""
        _IdSucursal = ""
        urlImagenFirebase = ""
        buttonText = "Agregar"
        
        // Restablecer selecciones
        seleccionSucursal = 0
        seleccionSucursalTipo = 0
        seleccionZona = 0
        seleccionRazonSocial = 0
        seleccionTitular = 0
    }
}

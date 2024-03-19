//
//  InstitucionesView.swift
//  iecaappadmin
//
//  Created by Omar on 27/02/24.
//

import SwiftUI

struct InstitucionesView: View {
    @State private var _Nombre = ""
    @State private var _Correo = ""
    @State private var _Telefono = ""
    @State private var _IdRazonSocial = ""
    @State private var _Notas = ""
    @State private var _Id = ""
    
    @StateObject var viewModelRazonSocial = RazonSocialViewModel()
    @StateObject var viewModelInstitucion = InstitucionViewModel()
    @State var seleccionRazonSocial: Int = 0
    
    
    @State private var imageUrl: String?
    @State private var urlImagenFirebase: String? = ""
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var image: Image?
    @State private var showAlert = false
    @State private var showAlertAgregarModificar = false
    @State private var avisoText = ""
    
    var body: some View {
        NavigationView {
            
            Form {
                
                Section() {
                    TextField("Nombre", text: $_Nombre)
                    TextField("Correo", text: $_Correo)
                    TextField("Telefono", text: $_Telefono)
                    
                    Picker("Razones sociales", selection: $seleccionRazonSocial) {
                        
                        ForEach(viewModelRazonSocial.razonSocials.indices.map { $0}, id: \.self) { index in
                            Text(viewModelRazonSocial.razonSocials[index].Nombre)
                                .tag(index)
                        }
                    }.onChange(of: seleccionRazonSocial) { index in
                        print(index)
                        if index != 0 {
                            let zonaSeleccionada = viewModelRazonSocial.razonSocials[index]
                            
                            
                            _IdRazonSocial = zonaSeleccionada.Id
                            
                            
                            
                        }
                        
                    }.onAppear {
                     
                        //                        viewModelRazonSocial.fetchRazonSocials()
                        
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
                        imageUrl = "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C/LogoEmpresa/"
                        isShowingImagePicker.toggle()
                    }
                    .sheet(isPresented: $isShowingImagePicker) {
                        ImagePicker(image: $image, isPresented: $isShowingImagePicker, imageUrl: $imageUrl, urlImagenFirebase: $urlImagenFirebase)
                    }
                }
                
                
                
                Section {
                    Button("Actualizar") {
                        avisoText = "Registro Modificado"
                        showAlertAgregarModificar.toggle()
                        let institucion = Institucion(
                            Id: _Id,
                            Nombre: _Nombre,
                            LogoLink: urlImagenFirebase!,
                            Fecha: "2024-01-30T19:06:05.675Z",
                            Status: true,
                            borrado: false,
                            Correo: _Correo,
                            Telefono: _Telefono,
                            Notas: _Notas,
                            IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
                            IdRazonSocial: _IdRazonSocial
                        )
                        viewModelInstitucion.editarInstitucion(institucion: institucion)
                        
                    }
                }.onAppear {
                    viewModelRazonSocial.fetchRazonSocials()
                    viewModelInstitucion.fetchInstitucion()
                }.alert(isPresented: $showAlertAgregarModificar) {
                    Alert(title: Text("Aviso"), message: Text(avisoText), dismissButton: .default(Text("Aceptar")))
                }
                .onChange(of: viewModelInstitucion.instituciones) { instituciones in
                    guard let primeraInstitucion = instituciones.first else {
                        print("No se encontraron instituciones")
                        return
                    }
                    _Nombre = primeraInstitucion.Nombre
                    _Correo =  primeraInstitucion.Correo
                    _Telefono = primeraInstitucion.Telefono
                    _Notas = primeraInstitucion.Notas
                    _Id = primeraInstitucion.Id
                    _IdRazonSocial = primeraInstitucion.IdRazonSocial
                    urlImagenFirebase = primeraInstitucion.LogoLink
                    
                    if let posicionRegistro = viewModelRazonSocial.razonSocials.firstIndex(where: { $0.Id.uppercased() == primeraInstitucion.IdRazonSocial.uppercased() }) {
                        seleccionRazonSocial = posicionRegistro
                    }
                }
            }
            
            .navigationTitle("Institucion")
        }
    }
}

#Preview {
    InstitucionesView()
}

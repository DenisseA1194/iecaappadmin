//
//  ZonasView.swift
//  iecaappadmin
//
//  Created by Omar on 26/02/24.
//

import SwiftUI

struct CursosView: View {
    
    @State var seleccionCurso: Int = 0
    @State var seleccionCampoFormacion: Int = 0
    @State var seleccionArea: Int = 0
    @State var seleccionEspecialidad: Int = 0
    @State var seleccionModalidad: Int = 0
    @State var seleccionConfidencialidad: Int = 0
    @State var seleccionPlataforma: Int = 0
    @StateObject var viewModelCurso = CursosViewModel()
    @StateObject var viewModelCampoFormacion = CatalogoCursosCampoDeFormacionViewModel()
    @StateObject var viewModelArea = AreaViewModel()
    @StateObject var viewModelEspecialidad = CatalogoCursosEspecialidadesViewModel()
    @StateObject var viewModelModalidad = CatalogoCursosModalidadesViewModel()
    @StateObject var viewModelConfidencialidad = CatalogoCursosTipoConfidencialidadViewModel()
    @StateObject var viewModelPlataforma = CatalogoCursosPlataformasViewModel()
    
    
    @State private var _Nombre = ""
    @State private var _Notas = ""
    @State private var _Id = ""
    @State private var _Version = 0.0
    @State private var _Codigo = ""
    @State private var _STPS = ""
    @State private var _CodigoCliente = ""
    @State private var _CodigoAlterno = ""
    @State private var _CodigoInterno = ""
    @State private var _Proposito = ""
    @State private var _Objetivo = ""
    @State private var _ObjetivoGeneral = ""
    @State private var _LinkLogo = ""
    
    @State private var _IdCampoDeFormacion = ""
    @State private var _IdEspecialidad = ""
    @State private var _IdTipoConfidencialidad = ""
    @State private var _IdModalidad = ""
    @State private var _IdPlataformaLMSUtilizada = ""
    @State private var _IdArea = ""
    
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
    
    func ConsultarEspecialidades() async throws  {
        
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
                Section(header: Text("Selecciona un curso")) {
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
                    }.onChange(of: seleccionCurso) { index in
                        
                        if index != 0 {
                            let Seleccionada = viewModelCurso.cursos[index]
                            
                            let stringValue = "123"
                            if let intValue = Int(stringValue) {
                                // Aquí intValue contendrá el valor entero 123
                                print(intValue)
                            } else {
                                // Manejar el caso en el que la conversión falla
                                print("No se pudo convertir a entero")
                            }
                            
                            _Nombre = Seleccionada.Nombre
                            _Notas = Seleccionada.Notas
                            _Id = Seleccionada.Id
                            _Version = Seleccionada.Version
                            _Codigo = Seleccionada.Codigo
                            _STPS = Seleccionada.RegistroSTPS
                            _CodigoCliente = Seleccionada.CodigoCliente
                            _CodigoAlterno = Seleccionada.CodigoAlterno
                            _CodigoInterno = Seleccionada.CodigoInterno
                            _Proposito = Seleccionada.Proposito
                            _Objetivo = Seleccionada.Objetivo
                            _ObjetivoGeneral = Seleccionada.ObjetivoGeneral
                            urlImagenFirebase = Seleccionada.LinkFoto
                            _IdCampoDeFormacion = Seleccionada.IdCampoDeFormacion
                            _IdEspecialidad = Seleccionada.IdEspecialidad
                            _IdTipoConfidencialidad = Seleccionada.IdTipoConfidencialidad
                            _IdModalidad = Seleccionada.IdModalidad
                            _IdPlataformaLMSUtilizada = Seleccionada.IdModalidad
                            _IdArea = Seleccionada.IdArea
                   
                          
                            viewModelEspecialidad.fetchCatalogoCursosEspecialidades(idArea: Seleccionada.IdArea) { result in
                                switch result {
                                case .success(let catalogoCursosEspecialidades):
                                    if !catalogoCursosEspecialidades.isEmpty {
                                        let Seleccionada = viewModelCurso.cursos[index]
                                        
                                        if let registro = viewModelEspecialidad.catalogoCursosEspecialidades.firstIndex(where: { $0.Id.uppercased() == Seleccionada.IdEspecialidad.uppercased() }) {
                                            seleccionEspecialidad = registro
                                        }
                                    } else {
                                        // No se han traído registros, manejar caso aquí
                                    }
                                case .failure(let error):
                                    // Manejar el error
                                    print("Error al obtener el catálogo de cursos especialidad: \(error.localizedDescription)")
                                }
                            }
                            
//                            Esta es el codigo que depende de los registros obtenidos
                            if index != 0 {
                                let seleccion =  viewModelCurso.cursos[index]
                           
                                if let registro = viewModelEspecialidad.catalogoCursosEspecialidades.firstIndex(where: { $0.Id.uppercased() == seleccion.IdEspecialidad.uppercased() }) {
                                    seleccionEspecialidad = registro
                                }
  
                            }else{
                                //                             limpiarFormulario()
                                
                            }
                            
                            if let registro = viewModelCampoFormacion.catalogoCursosCampoDeFormacion.firstIndex(where: { $0.Id.uppercased() == Seleccionada.IdCampoDeFormacion.uppercased() }) {
                                seleccionCampoFormacion = registro
                            }
                            
                            if let registro = viewModelArea.areas.firstIndex(where: { $0.Id.uppercased() == Seleccionada.IdArea.uppercased() }) {
                                seleccionArea = registro
                                viewModelEspecialidad.fetchCatalogoCursosEspecialidades(idArea: _IdArea)
                            }
                            
                            if let registro = viewModelModalidad.catalogoCursosModalidades.firstIndex(where: { $0.Id.uppercased() == Seleccionada.IdModalidad.uppercased() }) {
                                seleccionModalidad = registro
                            }
                            
                            if let registro = viewModelConfidencialidad.catalogoCursosTipoConfidencialidad.firstIndex(where: { $0.Id.uppercased() == Seleccionada.IdTipoConfidencialidad.uppercased() }) {
                                seleccionConfidencialidad = registro
                            }
                            
                            if let registro = viewModelPlataforma.catalogoCursosPlataformas.firstIndex(where: { $0.Id.uppercased() == Seleccionada.IdPlataformaLMSUtilizada.uppercased() }) {
                                seleccionPlataforma = registro
                            }
                            
                            if let registro = viewModelEspecialidad.catalogoCursosEspecialidades.firstIndex(where: { $0.Id.uppercased() == Seleccionada.IdEspecialidad.uppercased() }) {
                                
                                seleccionEspecialidad = registro
                            }else{
                                
                                
                            }
                            buttonText = "Actualizar"
                        }else{
                            //                             limpiarFormulario()
                            
                        }
                        
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
                                Alert(title: Text("Aviso"), message: Text("Agrega una nueva zona"), dismissButton: .default(Text("Aceptar")))
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
                    Picker("Campo formacion", selection: $seleccionCampoFormacion) {
                        
                        ForEach(viewModelCampoFormacion.catalogoCursosCampoDeFormacion.indices.map { $0}, id: \.self) { index in
                            Text(viewModelCampoFormacion.catalogoCursosCampoDeFormacion[index].Nombre)
                                .tag(index)
                        }
                    }.onChange(of: seleccionCampoFormacion) { index in
                        
                        if index != 0 {
                            let zonaSeleccionada = viewModelCampoFormacion.catalogoCursosCampoDeFormacion[index]
                            
                            
                            _IdCampoDeFormacion = zonaSeleccionada.Id
                            
                            
                            
                        }else{
                            //                             limpiarFormulario()
                            
                        }
                        
                    }.onAppear {
                        
                        //                        viewModelCurso.fetchCursos()
                        
                        
                    }
                    
                    Picker("Areas", selection: $seleccionArea) {
                        
                        ForEach(viewModelArea.areas.indices.map { $0}, id: \.self) { index in
                            Text(viewModelArea.areas[index].Nombre)
                                .tag(index)
                        }
                    }.onChange(of: seleccionArea) { index in
                        
                        
                        let areaSeleccionada = viewModelArea.areas[index]
                        
                        viewModelEspecialidad.catalogoCursosEspecialidades = []
                        
                        _IdArea = areaSeleccionada.Id
                        
                        viewModelEspecialidad.fetchCatalogoCursosEspecialidades(idArea: _IdArea)
                        
                        
                        
                        
                    }.onAppear {
                        
                        
                        //                        viewModelCurso.fetchCursos()
                        
                        
                        
                    }
                    
                    Picker("Especialidad", selection: $seleccionEspecialidad) {
                        
                        ForEach(viewModelEspecialidad.catalogoCursosEspecialidades.indices.map { $0}, id: \.self) { index in
                            Text(viewModelEspecialidad.catalogoCursosEspecialidades[index].Nombre)
                                .tag(index)
                        }
                    }.onChange(of: seleccionEspecialidad) { index in
                       
                        
                        
                        
                    }.onAppear {
                        
                        
                        
                        
                        
                    }
                    
                    Picker("Modalidad", selection: $seleccionModalidad) {
                        
                        ForEach(viewModelModalidad.catalogoCursosModalidades.indices.map { $0}, id: \.self) { index in
                            Text(viewModelModalidad.catalogoCursosModalidades[index].Nombre)
                                .tag(index)
                        }
                    }.onChange(of: seleccionModalidad) { index in
                        
                        if index != 0 {
                            let zonaSeleccionada = viewModelModalidad.catalogoCursosModalidades[index]
                            
                            
                            _IdModalidad = zonaSeleccionada.Id
                            
                            
                            
                        }else{
                            //                             limpiarFormulario()
                            
                        }
                        
                    }.onAppear {
                        
                        
                        //                        viewModelCurso.fetchCursos()
                        
                        
                        
                    }
                    
                    
                    Picker("Confidencialidad", selection: $seleccionConfidencialidad) {
                        
                        ForEach(viewModelConfidencialidad.catalogoCursosTipoConfidencialidad.indices.map { $0}, id: \.self) { index in
                            Text(viewModelConfidencialidad.catalogoCursosTipoConfidencialidad[index].Nombre)
                                .tag(index)
                        }
                    }.onChange(of: seleccionConfidencialidad) { index in
                        
                        if index != 0 {
                            let zonaSeleccionada = viewModelConfidencialidad.catalogoCursosTipoConfidencialidad[index]
                            
                            
                            _IdTipoConfidencialidad = zonaSeleccionada.Id
                            
                            
                            
                        }else{
                            //                             limpiarFormulario()
                            
                        }
                        
                    }.onAppear {
                        
                        
                        //                        viewModelCurso.fetchCursos()
                        
                        
                        
                    }
                    
                    Picker("Plataforma", selection: $seleccionPlataforma) {
                        
                        ForEach(viewModelPlataforma.catalogoCursosPlataformas.indices.map { $0}, id: \.self) { index in
                            Text(viewModelPlataforma.catalogoCursosPlataformas[index].Nombre)
                                .tag(index)
                        }
                    }.onChange(of: seleccionPlataforma) { index in
                        
                        if index != 0 {
                            let zonaSeleccionada = viewModelPlataforma.catalogoCursosPlataformas[index]
                            
                            
                            _IdPlataformaLMSUtilizada = zonaSeleccionada.Id
                            
                            
                            
                        }else{
                            //                             limpiarFormulario()
                            
                        }
                        
                    }.onAppear {
                        
                        
                        //                        viewModelCurso.fetchCursos()
                        
                        
                        
                    }
                    
                    
                    TextField("Version", text: Binding<String>(
                        get: { String(_Version) }, // Convierte el entero _Version a una cadena
                        set: { _Version = Double($0) ?? 0 } // Convierte la cadena introducida en el TextField a un entero
                    ))
                    TextField("Codigo", text: $_Codigo)
                    TextField("STPS", text: $_STPS)
                    TextField("Codigo cliente", text: $_CodigoCliente)
                    TextField("Codigo alterno", text: $_CodigoAlterno)
                    TextField("Codigo interno", text: $_CodigoInterno)
                    TextField("Proposito", text: $_Proposito)
                    TextField("Objetivo", text: $_Objetivo)
                    TextField("Objetivo general", text: $_ObjetivoGeneral)
                    
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
                    
                    
                }
                
                Section {
                    Button(action: {
                        if todosLosCamposEstanCompletos() {
                            if buttonText == "Agregar"{
                                avisoText = "Registro Agregado"
                                showAlertAgregarModificar.toggle()
                                let nuevoCurso = Curso(
                                    Id:"",
                                    Nombre: _Nombre,
                                    Version: _Version,
                                    Fecha: "2024-01-30T19:06:05.675Z",
                                    Borrado: false,
                                    IdCampoDeFormacion: _IdCampoDeFormacion,
                                    IdEspecialidad: _IdEspecialidad,
                                    IdTipoConfidencialidad: _IdTipoConfidencialidad,
                                    IdModalidad: _IdModalidad,
                                    IdPlataformaLMSUtilizada: _IdPlataformaLMSUtilizada,
                                    ObjetivoGeneral: _ObjetivoGeneral,
                                    RegistroSTPS: _STPS,
                                    Proposito: _Proposito,
                                    Objetivo: _Objetivo,
                                    Notas: _Notas,
                                    Codigo: _Codigo,
                                    CodigoCliente: _CodigoCliente,
                                    CodigoInterno: _CodigoInterno,
                                    CodigoAlterno: _CodigoAlterno,
                                    Activo: true,
                                    IdArea:_IdArea,
                                    LinkFoto: urlImagenFirebase!,
                                    IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
                                    
                                    
                                )
                                viewModelCurso.agregarNuevoCurso(nuevoCurso: nuevoCurso)
                                viewModelCurso.fetchCursos()
                            }else{
                                avisoText = "Registro Modificado"
                                showAlertAgregarModificar.toggle()
                                let curso = Curso(
                                    Id:_Id,
                                    Nombre: _Nombre,
                                    Version: _Version,
                                    Fecha: "2024-01-30T19:06:05.675Z",
                                    Borrado: false,
                                    IdCampoDeFormacion: _IdCampoDeFormacion,
                                    IdEspecialidad: _IdEspecialidad,
                                    IdTipoConfidencialidad: _IdTipoConfidencialidad,
                                    IdModalidad: _IdModalidad,
                                    IdPlataformaLMSUtilizada: _IdPlataformaLMSUtilizada,
                                    ObjetivoGeneral: _ObjetivoGeneral,
                                    RegistroSTPS: _STPS,
                                    Proposito: _Proposito,
                                    Objetivo: _Objetivo,
                                    Notas: _Notas,
                                    Codigo: _Codigo,
                                    CodigoCliente: _CodigoCliente,
                                    CodigoInterno: _CodigoInterno,
                                    CodigoAlterno: _CodigoAlterno,
                                    Activo: true,
                                    IdArea:_IdArea,
                                    LinkFoto: urlImagenFirebase!,
                                    IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
                                )
                                viewModelCurso.editarCurso(curso: curso)
                                viewModelCurso.fetchCursos()
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
            .navigationTitle("Cursos")
        }.onAppear {
            viewModelArea.fetchAreas()
            viewModelEspecialidad.fetchCatalogoCursosEspecialidades(idArea: _IdArea)
            viewModelCurso.fetchCursos()
            viewModelCampoFormacion.fetchCatalogoCursosCampoDeFormacion()
            viewModelArea.fetchAreas()
            viewModelEspecialidad.fetchCatalogoCursosEspecialidades(idArea: _IdArea)
            viewModelModalidad.fetchCatalogoCursosModalidades()
            viewModelConfidencialidad.fetchCatalogoCursosTipoConfidencialidad()
            viewModelPlataforma.fetchCatalogoCursosPlataformas()
        }
    }
}

#Preview {
    CursosView()
}

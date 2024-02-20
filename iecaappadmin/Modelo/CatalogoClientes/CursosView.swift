//
//  CursosView.swift
//  iecaappadmin
//
//  Created by Omar on 07/02/24.
//

import SwiftUI
import Alamofire

struct CursosView: View {
    @Binding var presentSideMenu: Bool
    enum SortingOption: String, CaseIterable {
        case nombre = "Nombre"
        case objetivoGeneral = "ObjetivoGeneral"
        
        var keyPath: KeyPath<Curso, String> {
            switch self {
            case .nombre: return \.Nombre
            case .objetivoGeneral: return \.ObjetivoGeneral
            }
        }
    }
    
    @StateObject private var viewModel = CursosViewModel()
    @Binding var showSignInView: Bool
    @State private var isAddingNewCursos = false
    @State private var isEditingCurso = false
    @State private var mostrarBotones = false
    @State private var NombreRegistroSeleccionado = ""
    @State private var searchText = ""
    @State private var selectedSortingOption: SortingOption = .nombre
    @State private var selectedCurso: Curso? = nil
    @State private var currentIndex = 0
    let items = ["","Actividades", "Autorizaciones", "Bibliografia", "Competencias", "Comp a desarrollar", "Descripciones", "Creadores", "Documentacion", "Equipos", "Evaluaciones", "Instructores", "Materiales", "Modalidades", "Temas", "Tipo de cliente"]
    
    
    var sortedCurso: [Curso] {
        if searchText.isEmpty {
            return viewModel.cursos.sorted(by: { $0[keyPath: selectedSortingOption.keyPath] < $1[keyPath: selectedSortingOption.keyPath] }) ?? []
        } else {
            let filtered = viewModel.cursos.filter { curso in
                return curso.Nombre.lowercased().contains(searchText.lowercased())
            }
            return filtered.sorted(by: { $0[keyPath: selectedSortingOption.keyPath] < $1[keyPath: selectedSortingOption.keyPath] }) ?? []
        }
    }
    
    var body: some View {
        VStack{
            
            HStack {
                
                Button(action: {
                    presentSideMenu.toggle()
                }) {
                    Image("hamburguesa")
                        .foregroundColor(.blue)
                        .imageScale(.large)
                }
                .padding()
                Spacer()
            }
            
            NavigationView {
                List {
                    SearchBar(searchText: $searchText)
                    ForEach(sortedCurso) { curso in
                        CursoCellView(curso: curso, viewModel: viewModel, mostrarBotones: $mostrarBotones, didSelectCurso: { selectedCurso in
                            // Asignar el curso seleccionado a una variable de estado en CursosView
                            self.selectedCurso = selectedCurso
                        })
                        .listRowSeparator(.visible)
                        .padding(.horizontal, 16)
                    }
                    
                    Button(action: {
                        isAddingNewCursos.toggle()
                    }) {
                        Text("Agregar Cursos")
                    }
                } .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu("Ordenar por") {
                            ForEach(SortingOption.allCases, id: \.self) { option in
                                Button(action: {
                                    selectedSortingOption = option
                                }) {
                                    Label(option.rawValue, systemImage: "arrow.up.arrow.down")
                                }
                            }
                        }
                    }
                }
                .onAppear {
                    viewModel.fetchCursos()
                }
                .navigationTitle("Cursos")
                .sheet(isPresented: $isAddingNewCursos) {
                    AgregarCursoView(isAddingNewCursos: $isAddingNewCursos, cursosViewModel: viewModel)
                }
            }
            
            if mostrarBotones {
                VStack {
                    if let nombre = selectedCurso?.Nombre {
                        Text(nombre)
                            .font(.title3)
                    }
                    CarouselView(items: items, currentIndex: $currentIndex, selectedCurso: selectedCurso)
                }
                .padding()
            }
        }
    }
}

struct SearchBarCursos: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            TextField("Buscar", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 8)
            }
        }
    }
}

struct CursoCellView: View {
    let curso: Curso
    @ObservedObject var viewModel: CursosViewModel
    @State private var isPresentingEditForm = false
    @Binding var mostrarBotones: Bool
    var didSelectCurso: (Curso) -> Void
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(curso.Nombre)
                Text(curso.Version)
                Text(curso.Proposito)
                    .lineLimit(1)
            }
            Spacer()
            HStack {
                Button(action: {
                    didSelectCurso(curso)
                    mostrarBotones = true
                    //                    isPresentingEditForm.toggle()
                }) {
                    //                                       Image(systemName: "pencil")
                }
                .foregroundColor(.blue)
                .sheet(isPresented: $isPresentingEditForm) {
                    
                    EditarCursoView(curso: curso, cursosViewModel: viewModel, isPresented: $isPresentingEditForm)
                }
            }.swipeActions{
                
                
                
                Button(action: {
                    isPresentingEditForm.toggle()
                    // Acción del primer botón
                    print("Edit")
                }) {
                    Label("Editar", systemImage: "pencil")
                        .tint(.blue)
                }
                Button(action: {
                    viewModel.eliminarCurso(curso: curso)
                }) {
                    Label("Eliminar", systemImage: "trash")
                        .tint(.red)
                }
                
                
                
                //                                                              Menu {
                //                                                                  Button("Editar") {
                //                                                                      // Acción para editar
                //                                                                      print("Editar")
                //                                                                  }.tint(.blue)
                //                                                                  Button("Eliminar") {
                //                                                                      // Acción para eliminar
                //                                                                      print("Eliminar")
                //                                                                  }.tint(.red)
                //                                                              } label: {
                //                                                                  Label("Más opciones", systemImage: "ellipsis.circle")
                //                                                                      .tint(.gray)  // Puedes establecer un color diferente si es necesario
                //                                                              }
                
            }
        }
        .padding(8)
    }
}



struct EditarCursoView: View {
    let curso: Curso
    @ObservedObject var cursosViewModel: CursosViewModel
    @Binding var isPresented: Bool
    
    @StateObject var viewModel = CatalogoCursosCampoDeFormacionViewModel()
    @StateObject var viewModelEspecialidad = CatalogoCursosEspecialidadesViewModel()
    @StateObject var viewModelConfidencialidad = CatalogoCursosTipoConfidencialidadViewModel()
    @StateObject var viewModelModalidad = CatalogoCursosModalidadesViewModel()
    @StateObject var viewModelPlataforma = CatalogoCursosPlataformasViewModel()
    
    @State private var nuevoNombre = ""
    @State private var nuevaVersion = ""
    @State private var nuevoObjetivoGeneral = ""
    @State private var nuevoProposito = ""
    @State private var nuevoObjetivo = ""
    @State private var nuevoNotas = ""
    @State private var nuevoCodigo = ""
    @State private var nuevoCodigoCliente = ""
    @State private var nuevoCodigoInterno = ""
    @State private var nuevoCodigoAlterno = ""
    
    @State private var idFormacion = ""
    @State private var idEspecialidad = ""
    @State private var idConfidencialidad = ""
    @State private var idModalidad = ""
    @State private var idPlataforma = ""
    
    //    @StateObject var viewModel = CatalogoCursosCampoDeFormacionViewModel()
    @State var seleccion: Int = 0
    @State private var isShowingForm = false
    @State private var isShowingFormFormacion = false
    @State private var isShowingFormEspecialidad = false
    @State private var isShowingFormConfidencialidad = false
    @State private var isShowingFormModalidad = false
    @State private var isShowingFormPlataforma = false
    
    @State var seleccionFormacion: Int = 0
    @State var seleccionEspecialidad: Int = 0
    @State var seleccionConfidencialidad: Int = 0
    @State var seleccionModalidad: Int = 0
    @State var seleccionPlataforma: Int = 0
    
    
    init(curso: Curso, cursosViewModel: CursosViewModel, isPresented: Binding<Bool>) {
        self.curso = curso
        self.cursosViewModel = cursosViewModel
        self._isPresented = isPresented
        
        _nuevoNombre = State(initialValue: curso.Nombre)
        _nuevaVersion = State(initialValue: curso.Version)
        _nuevoObjetivoGeneral = State(initialValue: curso.ObjetivoGeneral)
        _nuevoProposito = State(initialValue: curso.Proposito)
        _nuevoObjetivo = State(initialValue: curso.Objetivo)
        _nuevoNotas = State(initialValue: curso.Notas)
        _nuevoCodigo = State(initialValue: curso.Codigo)
        _nuevoCodigoCliente = State(initialValue: curso.CodigoCliente)
        _nuevoCodigoInterno = State(initialValue: curso.CodigoInterno)
        _nuevoCodigoAlterno = State(initialValue: curso.CodigoAlterno)
        
        _idFormacion = State(initialValue: curso.IdCampoDeFormacion)
        _idEspecialidad = State(initialValue: curso.IdEspecialidad)
        _idConfidencialidad = State(initialValue: curso.IdTipoConfidencialidad)
        _idModalidad = State(initialValue: curso.IdModalidad)
        _idPlataforma = State(initialValue: curso.IdPlataformaLMSUtilizada)
        
        
        
        if let index = viewModel.catalogoCursosCampoDeFormacion.firstIndex(where: { $0.id == curso.IdCampoDeFormacion }) {
            seleccionFormacion = index
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                Section(header: Text("Editar Curso")) {
                    
                    TextField("Nombre", text: $nuevoNombre)
                        .padding()
                    TextField("Version", text: $nuevaVersion)
                        .padding()
                    TextField("ObjetivoGeneral", text: $nuevoObjetivoGeneral)
                        .padding()
                    TextField("Proposito", text: $nuevoProposito)
                        .padding()
                    TextField("Objetivo", text: $nuevoObjetivo)
                        .padding()
                    TextField("Notas", text: $nuevoNotas)
                        .padding()
                    TextField("Codigo", text: $nuevoCodigo)
                        .padding()
                    TextField("Codigo cliente", text: $nuevoCodigoCliente)
                        .padding()
                    TextField("Codigo interno", text: $nuevoCodigoInterno)
                        .padding()
                    TextField("Codigo alterno", text: $nuevoCodigoAlterno)
                        .padding()
                    HStack{
                        VStack(alignment: .leading, spacing: 16) {
                            
                            HStack{
                                Text(" Campo de formación")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                Button(action: {
                                    isShowingFormFormacion.toggle()
                                    
                                }) {
                                    Text("+").font(.title)
                                }.sheet(isPresented: $isShowingFormFormacion) {
                                    
                                    FormularioView(isAdding: $isShowingFormFormacion, callingScreen: "Formacion", tituloScreen: " Campo de formación" )
                                }.frame(width: 30, height: 40)
                            }
                            
                            
                            
                            
                            Picker("Campo de formación", selection: $seleccionFormacion) {
                                
                                ForEach(viewModel.catalogoCursosCampoDeFormacion.indices, id: \.self) { index in
                                    
                                    Text(viewModel.catalogoCursosCampoDeFormacion[index].Nombre)
                                        .tag(index)
                                    
                                }
                                
                            }
                            
                            .pickerStyle(.menu)
                            
                        }
                        .onAppear {
                            
                            viewModel.fetchCatalogoCursosCampoDeFormacion()
                            viewModelEspecialidad.fetchCatalogoCursosEspecialidades()
                            
                            if let index = viewModel.catalogoCursosCampoDeFormacion.firstIndex(where: { $0.Nombre == "Lenguajes" }) {
                                seleccionFormacion = index
                                print("El registro está en la posición \(index)")
                            } else {
                                print(viewModel.catalogoCursosCampoDeFormacion)
                            }
                            
                        }
                        Spacer()
                    }
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 16) {
                            // Etiqueta para el segundo Picker
                            
                            HStack{
                                Text(" Especialidad")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                Button(action: {
                                    isShowingFormEspecialidad.toggle()
                                    
                                }) {
                                    Text("+").font(.title)
                                }.sheet(isPresented: $isShowingFormEspecialidad) {
                                    
                                    FormularioView(isAdding: $isShowingFormEspecialidad, callingScreen: "Especialidad",tituloScreen: "Especialidad")
                                }
                            }
                            
                            
                            Picker("Especialidad", selection: $seleccionEspecialidad) {
                                ForEach(viewModelEspecialidad.catalogoCursosEspecialidades.indices, id: \.self) { index in
                                    Text(viewModelEspecialidad.catalogoCursosEspecialidades[index].Nombre)
                                        .tag(index)
                                }
                            }.onChange(of: idEspecialidad) { newValue in
                                if let index = viewModelEspecialidad.catalogoCursosEspecialidades.firstIndex(where: { $0.id == idEspecialidad }) {
                                    seleccionEspecialidad = index
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                        Spacer()
                    }
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 16) {
                            
                            
                            
                            HStack{
                                Text(" Tipo confidencialidad")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                Button(action: {
                                    isShowingFormConfidencialidad.toggle()
                                    
                                }) {
                                    Text("+").font(.title)
                                }.sheet(isPresented: $isShowingFormConfidencialidad) {
                                    
                                    FormularioView(isAdding: $isShowingFormConfidencialidad, callingScreen: "Confidencialidad", tituloScreen: "Tipo de Confidencialidad")
                                }
                            }
                            
                            
                            Picker("Tipo confidencialidad", selection: $seleccionConfidencialidad) {
                                ForEach(viewModelConfidencialidad.catalogoCursosTipoConfidencialidad.indices, id: \.self) { index in
                                    Text(viewModelConfidencialidad.catalogoCursosTipoConfidencialidad[index].Nombre)
                                        .tag(index)
                                }
                            }.onChange(of: idConfidencialidad) { newValue in
                                if let index = viewModelConfidencialidad.catalogoCursosTipoConfidencialidad.firstIndex(where: { $0.id == idConfidencialidad }) {
                                    seleccionConfidencialidad = index
                                }
                            }
                            .pickerStyle(.menu)
                        }.onAppear {
                            viewModelConfidencialidad.fetchCatalogoCursosTipoConfidencialidad()
                        }
                        
                        Spacer()
                        
                        
                        
                        
                        
                        
                    }
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 16) {
                            
                            
                            
                            HStack{
                                Text(" Modalidad")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                Button(action: {
                                    isShowingFormModalidad.toggle()
                                    
                                }) {
                                    Text("+").font(.title)
                                }.sheet(isPresented: $isShowingFormModalidad) {
                                    
                                    FormularioView(isAdding: $isShowingFormModalidad ,callingScreen: "Modalidad", tituloScreen: "Modalidad")
                                }
                            }
                            
                            
                            
                            Picker("Modalidad", selection: $seleccionModalidad) {
                                ForEach(viewModelModalidad.catalogoCursosModalidades.indices, id: \.self) { index in
                                    Text(viewModelModalidad.catalogoCursosModalidades[index].Nombre)
                                        .tag(index)
                                }
                            }.onChange(of: idModalidad) { newValue in
                                if let index = viewModelModalidad.catalogoCursosModalidades.firstIndex(where: { $0.id == idModalidad }) {
                                    seleccionModalidad = index
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        .onAppear {
                            viewModelModalidad.fetchCatalogoCursosModalidades()
                        }
                        Spacer()
                    }
                    HStack{
                        VStack(alignment: .leading, spacing: 16) {
                            
                            
                            
                            HStack{
                                Text(" Plataforma LMS Utilizada")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                Button(action: {
                                    isShowingFormPlataforma.toggle()
                                    
                                }) {
                                    Text("+").font(.title)
                                }.sheet(isPresented: $isShowingFormPlataforma) {
                                    
                                    FormularioView(isAdding:$isShowingFormPlataforma, callingScreen: "Plataforma", tituloScreen: " Plataforma").frame(width: 300, height: 400)
                                }
                            }
                            
                            
                            Picker("Plataforma LMS Utilizada", selection: $seleccionPlataforma) {
                                ForEach(viewModelPlataforma.catalogoCursosPlataformas.indices, id: \.self) { index in
                                    Text(viewModelPlataforma.catalogoCursosPlataformas[index].Nombre)
                                        .tag(index)
                                }
                            }.onChange(of: idPlataforma) { newValue in
                                if let index = viewModelPlataforma.catalogoCursosPlataformas.firstIndex(where: { $0.id == idPlataforma }) {
                                    seleccionPlataforma = index
                                }
                            }
                            .pickerStyle(.menu)
                        } .onAppear {
                            viewModelPlataforma.fetchCatalogoCursosPlataformas()
                        }
                        
                        Spacer()
                        
                    }
                    
                }
                
                Section {
                    Button("Guardar Cambios") {
                        editarCurso()
                    }
                }
            }
            .navigationTitle("Editar Curso")
            .navigationBarItems(trailing: Button("Cerrar") {
                isPresented.toggle()
            })
            
        }
    }
    
    private func editarCurso() {
        
        let CursoEditado = Curso(
            Id : curso.Id,
            Nombre : nuevoNombre,
            Version : nuevaVersion,
            Fecha : curso.Fecha,
            Borrado : curso.Borrado,
            IdCampoDeFormacion: curso.IdCampoDeFormacion,
            IdEspecialidad: curso.IdEspecialidad,
            IdTipoConfidencialidad: curso.IdTipoConfidencialidad,
            IdModalidad: curso.IdModalidad,
            IdPlataformaLMSUtilizada: curso.IdPlataformaLMSUtilizada,
            ObjetivoGeneral: nuevoObjetivoGeneral,
            RegistroSTPS: curso.RegistroSTPS,
            Proposito: nuevoProposito,
            Objetivo: nuevoObjetivo,
            Notas: nuevoNotas,
            Codigo: nuevoCodigo,
            CodigoCliente: nuevoCodigoCliente,
            CodigoInterno: nuevoCodigoInterno,
            CodigoAlterno: nuevoCodigoAlterno,
            Activo: curso.Activo,
            IdEmpresa: curso.IdEmpresa
        )
        
        cursosViewModel.editarCurso(curso: CursoEditado)
        isPresented.toggle()
    }
}



struct AgregarCursoView: View {
    @StateObject var viewModel = CatalogoCursosCampoDeFormacionViewModel()
    @StateObject var viewModelEspecialidad = CatalogoCursosEspecialidadesViewModel()
    @StateObject var viewModelConfidencialidad = CatalogoCursosTipoConfidencialidadViewModel()
    @StateObject var viewModelModalidad = CatalogoCursosModalidadesViewModel()
    @StateObject var viewModelPlataforma = CatalogoCursosPlataformasViewModel()
    @State private var isShowingForm = false
    @State private var isShowingFormFormacion = false
    @State private var isShowingFormEspecialidad = false
    @State private var isShowingFormConfidencialidad = false
    @State private var isShowingFormModalidad = false
    @State private var isShowingFormPlataforma = false
    @State var seleccion: Int = 0
    @State var seleccionFormacion: Int = 0
    @State var seleccionEspecialidad: Int = 0
    @State var seleccionConfidencialidad: Int = 0
    @State var seleccionModalidad: Int = 0
    @State var seleccionPlataforma: Int = 0
    @Binding var isAddingNewCursos: Bool
    @ObservedObject var cursosViewModel: CursosViewModel
    @State private var nuevoCursoNombre = ""
    @State private var nuevaCursoVersion = ""
    @State private var nuevaCursoObjetivoGeneral = ""
    @State private var nuevoRegistroSTPS = ""
    @State private var nuevoCursoProposito = ""
    @State private var nuevoCursoObjetivo = ""
    @State private var nuevoCursoNotas = ""
    @State private var nuevoCursoCodigo = ""
    @State private var nuevoCursoCodigoCliente = ""
    @State private var nuevoCursoCodigoInterno = ""
    @State private var nuevoCursoCodigoAlterno = ""
    let camposFormacion = ["Etica", "Pnesamiento matematico"]
    let ecpecialidades = ["Master en ingles"]
    let tiposConfidencialidad = ["Operaciones de negocio", "Informacion al cliente"]
    let modalidades = ["String", "Persona moral"]
    let plataformasLMS = ["", ""]
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    TextField("Nombre ", text: $nuevoCursoNombre)
                        .padding()
                    TextField("Versión", text: $nuevaCursoVersion)
                        .padding()
                    TextField("Objetivo general", text: $nuevaCursoObjetivoGeneral)
                        .padding()
                    TextField("Registro stps", text: $nuevoRegistroSTPS)
                        .padding()
                    TextField("Propósito", text: $nuevoCursoProposito)
                        .padding()
                    TextField("Objetivo", text: $nuevoCursoObjetivo)
                        .padding()
                    TextField("Notas", text: $nuevoCursoNotas)
                        .padding()
                    TextField("Codigo", text: $nuevoCursoCodigo)
                        .padding()
                    TextField("Codigo cliente", text: $nuevoCursoCodigoCliente)
                        .padding()
                    TextField("Codigo interno", text: $nuevoCursoCodigoInterno)
                        .padding()
                    TextField("Codigo alterno", text: $nuevoCursoCodigoAlterno)
                        .padding()
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 16) {
                            
                            HStack{
                                Text(" Campo de formación")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                Button(action: {
                                    isShowingFormFormacion.toggle()
                                    
                                }) {
                                    Text("+").font(.title)
                                }.sheet(isPresented: $isShowingFormFormacion) {
                                    
                                    FormularioView(isAdding: $isShowingFormFormacion, callingScreen: "Formacion", tituloScreen: " Campo de formación" )
                                }.frame(width: 30, height: 40)
                            }
                            
                            
                            
                            Picker("Campo de formación", selection: $seleccionFormacion) {
                                ForEach(viewModel.catalogoCursosCampoDeFormacion.indices, id: \.self) { index in
                                    Text(viewModel.catalogoCursosCampoDeFormacion[index].Nombre)
                                        .tag(index)
                                }
                                
                            }
                            
                            .pickerStyle(.menu)
                            
                        }
                        .onAppear {
                            
                            viewModel.fetchCatalogoCursosCampoDeFormacion()
                            viewModelEspecialidad.fetchCatalogoCursosEspecialidades()
                        }
                        Spacer()
                    }
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 16) {
                            // Etiqueta para el segundo Picker
                            
                            HStack{
                                Text(" Especialidad")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                Button(action: {
                                    isShowingFormEspecialidad.toggle()
                                    
                                }) {
                                    Text("+").font(.title)
                                }.sheet(isPresented: $isShowingFormEspecialidad) {
                                    
                                    FormularioView(isAdding: $isShowingFormEspecialidad, callingScreen: "Especialidad",tituloScreen: "Especialidad")
                                }
                            }
                            
                            
                            Picker("Especialidad", selection: $seleccionEspecialidad) {
                                ForEach(viewModelEspecialidad.catalogoCursosEspecialidades.indices, id: \.self) { index in
                                    Text(viewModelEspecialidad.catalogoCursosEspecialidades[index].Nombre)
                                        .tag(index)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                        Spacer()
                    }
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 16) {
                            
                            
                            
                            HStack{
                                Text(" Tipo confidencialidad")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                Button(action: {
                                    isShowingFormConfidencialidad.toggle()
                                    
                                }) {
                                    Text("+").font(.title)
                                }.sheet(isPresented: $isShowingFormConfidencialidad) {
                                    
                                    FormularioView(isAdding: $isShowingFormConfidencialidad, callingScreen: "Confidencialidad", tituloScreen: "Tipo de Confidencialidad")
                                }
                            }
                            
                            
                            Picker("Tipo confidencialidad", selection: $seleccionConfidencialidad) {
                                ForEach(viewModelConfidencialidad.catalogoCursosTipoConfidencialidad.indices, id: \.self) { index in
                                    Text(viewModelConfidencialidad.catalogoCursosTipoConfidencialidad[index].Nombre)
                                        .tag(index)
                                }
                            }
                            .pickerStyle(.menu)
                        }.onAppear {
                            viewModelConfidencialidad.fetchCatalogoCursosTipoConfidencialidad()
                        }
                        
                        Spacer()
                    }
                    HStack{
                        VStack(alignment: .leading, spacing: 16) {
                            
                            
                            
                            HStack{
                                Text("Modalidad")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                Button(action: {
                                    isShowingFormModalidad.toggle()
                                    
                                }) {
                                    Text("+").font(.title)
                                }.sheet(isPresented: $isShowingFormModalidad) {
                                    
                                    FormularioView(isAdding: $isShowingFormModalidad ,callingScreen: "Modalidad", tituloScreen: "Modalidad")
                                }
                            }
                            
                            
                            
                            Picker("Modalidad", selection: $seleccionModalidad) {
                                ForEach(viewModelModalidad.catalogoCursosModalidades.indices, id: \.self) { index in
                                    Text(viewModelModalidad.catalogoCursosModalidades[index].Nombre)
                                        .tag(index)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        .onAppear {
                            viewModelModalidad.fetchCatalogoCursosModalidades()
                        }
                        Spacer()
                    }
                    HStack{
                        VStack(alignment: .leading, spacing: 16) {
                            
                            
                            
                            HStack{
                                Text(" Plataforma LMS Utilizada")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                Button(action: {
                                    isShowingFormPlataforma.toggle()
                                    
                                }) {
                                    Text("+").font(.title)
                                }.sheet(isPresented: $isShowingFormPlataforma) {
                                    
                                    FormularioView(isAdding:$isShowingFormPlataforma, callingScreen: "Plataforma", tituloScreen: " Plataforma").frame(width: 300, height: 400)
                                }
                            }
                            
                            
                            Picker("Plataforma LMS Utilizada", selection: $seleccionPlataforma) {
                                ForEach(viewModelPlataforma.catalogoCursosPlataformas.indices, id: \.self) { index in
                                    Text(viewModelPlataforma.catalogoCursosPlataformas[index].Nombre)
                                        .tag(index)
                                }
                            }
                            .pickerStyle(.menu)
                        } .onAppear {
                            viewModelPlataforma.fetchCatalogoCursosPlataformas()
                        }
                        
                        Spacer()
                    }
                    
                    Button("Agregar") {
                        agregarNuevoCurso()
                    }
                    .padding()
                }
                .navigationTitle("Agregar Curso")
                .navigationBarItems(trailing: Button("Cerrar") {
                    isAddingNewCursos.toggle()
                })
            }
        }
    }
    
    private func agregarNuevoCurso() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let currentDate = Date()
        
        let nuevoCurso = Curso(
            Id : "00000000-0000-0000-0000-000000000000",
            Nombre : nuevoCursoNombre,
            Version : nuevaCursoVersion,
            Fecha : "2024-01-30T19:06:05.675Z",
            Borrado : false,
            IdCampoDeFormacion: viewModel.catalogoCursosCampoDeFormacion[seleccionFormacion].Id,
            IdEspecialidad: viewModelEspecialidad.catalogoCursosEspecialidades[seleccionEspecialidad].Id,
            IdTipoConfidencialidad: viewModelConfidencialidad.catalogoCursosTipoConfidencialidad[seleccionConfidencialidad].Id,
            IdModalidad: viewModelModalidad.catalogoCursosModalidades[seleccionModalidad].Id,
            IdPlataformaLMSUtilizada: viewModelPlataforma.catalogoCursosPlataformas[seleccionPlataforma].Id,
            ObjetivoGeneral: nuevaCursoObjetivoGeneral,
            RegistroSTPS: nuevoRegistroSTPS,
            Proposito: nuevoCursoProposito,
            Objetivo: nuevoCursoObjetivo,
            Notas: nuevoCursoNotas,
            Codigo: nuevoCursoCodigo,
            CodigoCliente: nuevoCursoCodigoCliente,
            CodigoInterno: nuevoCursoCodigoInterno,
            CodigoAlterno: nuevoCursoCodigoAlterno,
            Activo: true,
            IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        )
        
        print(nuevoCurso)
        
        cursosViewModel.agregarNuevoCurso(nuevoCurso:nuevoCurso)
        isAddingNewCursos.toggle()
    }
}

struct FormularioView: View {
    @StateObject var viewModel = CatalogoCursosCampoDeFormacionViewModel()
    @StateObject var viewModelEspecialidad = CatalogoCursosEspecialidadesViewModel()
    @StateObject var viewModelConfidencialidad = CatalogoCursosTipoConfidencialidadViewModel()
    @StateObject var viewModelModalidad = CatalogoCursosModalidadesViewModel()
    @StateObject var viewModelPlataforma = CatalogoCursosPlataformasViewModel()
    @Binding var isAdding: Bool
    @State private var nombre: String = ""
    var callingScreen: String
    var tituloScreen: String
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Agrega un nuevo "+tituloScreen)
                TextField("Nombre", text: $nombre)
                    .padding()
                
                Button(action: {
                    
                    verificarSeleccion()
                }) {
                    Text("Agregar").padding().foregroundColor(.white)
                }
                .background(Color.blue)
                .cornerRadius(8)
                .padding()
            } .navigationBarItems(trailing: Button("Cerrar") {
                isAdding.toggle()
            })
        }
        .navigationTitle("Nuevo Registro")
        
    }
    
    func guardarNuevoCampoEspecialidad(nombre: String){
        
        
        let nuevoCatalogoCursosEspecialidades = CatalogoCursosEspecialidades(
            Id : "00000000-0000-0000-0000-000000000000",
            IdEmpresa : "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
            IdArea: "00000000-0000-0000-0000-000000000000",
            Fecha : "2024-01-30T19:06:05.675Z",
            Nombre : nombre,
            Notas : "",
            Observaciones: "",
            Status : true,
            Borrado: false
            
        )
        
        
        
        viewModelEspecialidad.agregarCatalogoCursosEspecialidades(nuevoCatalogoCursosEspecialidades: nuevoCatalogoCursosEspecialidades)
        isAdding.toggle()
    }
    
    
    func guardarNuevoCampoFormacion(nombre: String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Define el formato de la fecha que deseas obtener
        
        let currentDate = Date()
        
        let nuevoCatalogoCursosCampoDeFormacion = CatalogoCursosCampoDeFormacion(
            Id : "00000000-0000-0000-0000-000000000000",
            IdEmpresa : "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
            Fecha : "2024-01-30T19:06:05.675Z",
            Nombre : nombre,
            Notas : "",
            Status : true,
            Borrado: false
            
        )
        
        
        
        viewModel.agregarCatalogoCursosCampoDeFormacion(nuevoCatalogoCursosCampoDeFormacion: nuevoCatalogoCursosCampoDeFormacion)
        isAdding.toggle()
    }
    
    func guardarNuevoConfidencialidad(nombre: String){
        
        
        let nuevoCatalogoCursosTipoConfidencialidad = CatalogoCursosTipoConfidencialidad(
            Id : "00000000-0000-0000-0000-000000000000",
            IdEmpresa : "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
            Fecha : "2024-01-30T19:06:05.675Z",
            Nombre : nombre,
            Notas : "",
            Observaciones: "",
            Status : true,
            Borrado: false
            
        )
        
        
        
        viewModelConfidencialidad.agregarCatalogoCursosTipoConfidencialidad(nuevoCatalogoCursosTipoConfidencialidad: nuevoCatalogoCursosTipoConfidencialidad)
        isAdding.toggle()
    }
    
    func guardarNuevoModalidad(nombre: String){
        
        
        let nuevoCatalogoCursosModalidades = CatalogoCursosModalidades(
            Id : "00000000-0000-0000-0000-000000000000",
            IdEmpresa : "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
            Fecha : "2024-01-30T19:06:05.675Z",
            Nombre : nombre,
            Notas : "",
            Observaciones: "",
            Status : true,
            Borrado: false
            
        )
        
        
        
        viewModelModalidad.agregarCatalogoCursosModalidades(nuevoCatalogoCursosModalidades: nuevoCatalogoCursosModalidades)
        isAdding.toggle()
    }
    
    func guardarNuevoPlataforma(nombre: String){
        
        let nuevoCatalogoCursosPlataformas = CatalogoCursosPlataformas(
            Id : "00000000-0000-0000-0000-000000000000",
            IdEmpresa : "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
            Fecha : "2024-01-30T19:06:05.675Z",
            Nombre : nombre,
            Notas : "",
            Observaciones: "",
            Marca:"",
            LinkAcceso:"",
            Proveedor: "",
            Sincrona:true,
            Asincrona:true,
            Status : true,
            Borrado: false
            
        )
        
        viewModelPlataforma.agregarCatalogoCursosPlataformas(nuevoCatalogoCursosPlataformas: nuevoCatalogoCursosPlataformas)
        isAdding.toggle()
    }
    
    func verificarSeleccion() {
        print(callingScreen)
        switch callingScreen {
        case "Formacion":
            print("funciona? xxx")
            guardarNuevoCampoFormacion(nombre: nombre)
        case "Especialidad":
            guardarNuevoCampoEspecialidad(nombre: nombre)
        case "Confidencialidad":
            guardarNuevoConfidencialidad(nombre: nombre)
        case "Modalidad":
            guardarNuevoModalidad(nombre: nombre)
        default:
            guardarNuevoPlataforma(nombre: nombre)
        }
    }
}




//struct CursosView_Previews: PreviewProvider {
//    static var previews: some View {
//        CursosView(showSignInView: .constant(false))
//    }
//}

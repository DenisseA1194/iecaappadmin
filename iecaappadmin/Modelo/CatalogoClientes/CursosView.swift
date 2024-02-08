//
//  CursosView.swift
//  iecaappadmin
//
//  Created by Omar on 07/02/24.
//

import SwiftUI
import Alamofire

struct CursosView: View {
    
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
    
    @State private var nuevoNombre = ""
    @State private var nuevaVersion = ""
    @State private var nuevoObjetivoGeneral = ""
    @State private var nuevoProposito = ""
    
    init(curso: Curso, cursosViewModel: CursosViewModel, isPresented: Binding<Bool>) {
        self.curso = curso
        self.cursosViewModel = cursosViewModel
        self._isPresented = isPresented
        
        _nuevoNombre = State(initialValue: curso.Nombre)
        _nuevaVersion = State(initialValue: curso.Version)
        _nuevoObjetivoGeneral = State(initialValue: curso.ObjetivoGeneral)
        _nuevoProposito = State(initialValue: curso.Proposito)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Editar Curso")) {
                    
                    TextField("Nombre", text: $nuevoNombre)
                    TextField("Version", text: $nuevaVersion)
                    TextField("ObjetivoGeneral", text: $nuevoObjetivoGeneral)
                    TextField("Proposito", text: $nuevoProposito)
                    
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
            Nombre : curso.Nombre,
            Version : curso.Version,
            Fecha : curso.Fecha,
            Borrado : curso.Borrado,
            IdCampoDeFormacion: curso.IdCampoDeFormacion,
            IdEspecialidad: curso.IdEspecialidad,
            IdTipoConfidencialidad: curso.IdTipoConfidencialidad,
            IdModalidad: curso.IdModalidad,
            IdPlataformaLMSUtilizada: curso.IdPlataformaLMSUtilizada,
            ObjetivoGeneral: curso.ObjetivoGeneral,
            RegistroSTPS: curso.RegistroSTPS,
            Proposito: curso.Proposito,
            Objetivo: curso.Objetivo,
            Notas: curso.Notas,
            Codigo: curso.Codigo,
            CodigoCliente: curso.CodigoCliente,
            CodigoInterno: curso.CodigoInterno,
            CodigoAlterno: curso.CodigoAlterno,
            Activo: curso.Activo,
            IdEmpresa: curso.IdEmpresa
        )
        
        cursosViewModel.editarCurso(curso: CursoEditado)
        isPresented.toggle()
    }
}



struct AgregarCursoView: View {
    @Binding var isAddingNewCursos: Bool
    @ObservedObject var cursosViewModel: CursosViewModel
    @State private var nuevoCursoNombre = ""
    @State private var nuevaCursoVersion = ""
    @State private var nuevaCursoObjetivoGeneral = ""
    @State private var nuevoCursoProposito = ""
    let opciones = ["Persona fisica", "Persona moral"]
    @State private var seleccion = 0
    
    
    var body: some View {
        NavigationView {
            List {
                VStack {
                    TextField("Nombre ", text: $nuevoCursoNombre)
                        .padding()
                    TextField("Versión", text: $nuevaCursoVersion)
                        .padding()
                    TextField("Objetivo general", text: $nuevaCursoObjetivoGeneral)
                        .padding()
                    TextField("Propósito", text: $nuevoCursoProposito)
                        .padding()
                    TextField("Objetivo", text: $nuevoCursoProposito)
                        .padding()
                    TextField("Notas", text: $nuevoCursoProposito)
                        .padding()
                    TextField("Codigo", text: $nuevoCursoProposito)
                        .padding()
                    TextField("Codigo cliente", text: $nuevoCursoProposito)
                        .padding()
                    TextField("Codigo interno", text: $nuevoCursoProposito)
                        .padding()
                    TextField("Codigo alterno", text: $nuevoCursoProposito)
                        .padding()
                    
                    
                    
                    
                    Picker("Campo de formación", selection: $seleccion) {
                        ForEach(0 ..< opciones.count) {
                            Text(opciones[$0])
                                .tag(opciones[$0])
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Picker("Especialidad", selection: $seleccion) {
                        ForEach(0 ..< opciones.count) {
                            Text(opciones[$0])
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Picker("Tipo confidencialidad", selection: $seleccion) {
                        ForEach(0 ..< opciones.count) {
                            Text(opciones[$0])
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Picker("Modalidad:", selection: $seleccion) {
                        ForEach(0 ..< opciones.count) {
                            Text(opciones[$0])
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Picker("Plataforma LMS Utilizada:", selection: $seleccion) {
                        ForEach(0 ..< opciones.count) {
                            Text(opciones[$0])
                        }
                    }
                    .pickerStyle(.menu)
                    
                    
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
        dateFormatter.dateFormat = "yyyy-MM-dd" // Define el formato de la fecha que deseas obtener
        
        let currentDate = Date()
        
        let nuevoCurso = Curso(
            Id : "00000000-0000-0000-0000-000000000000",
            Nombre : "",
            Version : "",
            Fecha : "",
            Borrado : false,
            IdCampoDeFormacion: "00000000-0000-0000-0000-000000000000",
            IdEspecialidad: "00000000-0000-0000-0000-000000000000",
            IdTipoConfidencialidad: "00000000-0000-0000-0000-000000000000",
            IdModalidad: "00000000-0000-0000-0000-000000000000",
            IdPlataformaLMSUtilizada: "00000000-0000-0000-0000-000000000000",
            ObjetivoGeneral: "",
            RegistroSTPS: "",
            Proposito: "",
            Objetivo: "",
            Notas: "",
            Codigo: "",
            CodigoCliente: "",
            CodigoInterno: "",
            CodigoAlterno: "",
            Activo: true,
            IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C"
        )
        
        print(nuevoCurso)
        
        cursosViewModel.agregarNuevoCurso(nuevoCurso:nuevoCurso)
        isAddingNewCursos.toggle()
    }
}





struct CursosView_Previews: PreviewProvider {
    static var previews: some View {
        CursosView(showSignInView: .constant(false))
    }
}

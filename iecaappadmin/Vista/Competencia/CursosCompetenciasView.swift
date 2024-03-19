import SwiftUI

struct CursosCompetenciaView: View {
    // Variables para los pickers
    @State private var selectedCurso = 0
    @State private var selectedCompetencia = 0
    
    // Variable para el campo de notas
    @State private var notas = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Selecciona Curso")) {
                    Picker("Curso", selection: $selectedCurso) {
                        Text("Curso 1").tag(0)
                        Text("Curso 2").tag(1)
                        Text("Curso 3").tag(2)
                    }
                }
                
                Section(header: Text("Selecciona Competencia")) {
                    Picker("Competencia", selection: $selectedCompetencia) {
                        Text("Competencia 1").tag(0)
                        Text("Competencia 2").tag(1)
                        Text("Competencia 3").tag(2)
                    }
                }
                
                Section(header: Text("Notas")) {
                    TextEditor(text: $notas)
                        .frame(minHeight: 100)
                }
            }
            .navigationTitle("Cursos y Competencias")
        }
    }
}

struct CursosCompetenciaView_Previews: PreviewProvider {
    static var previews: some View {
        CursosCompetenciaView()
    }
}

//
//  InstitucionesView.swift
//  iecaappadmin
//
//  Created by Omar on 27/02/24.
//

import SwiftUI

struct InstitucionesView: View {
    @State private var nombreSucursal = ""
    @State private var direccion = ""
    @State private var ciudad = ""
    @State private var telefono = ""
    @State private var identificador = ""
    @State private var correo = ""
    @State private var pais = ""
    @State private var titular = ""
    @State private var razonSocial = ""
    @State private var zona = ""
    @State private var tipo = ""
    @State private var notas = ""
    @State private var regimenFiscal = RegimenFiscal.otro // Valor por defecto
    
    
    enum RegimenFiscal: String, CaseIterable, Identifiable {
        case regimen1 = "Razon social 1"
        case regimen2 = "Razon sociales 2"
        case regimen3 = "Razon sociales 3"
        case regimen4 = "Razon sociales 4"
        case regimen5 = "Razon sociales 5"
        case regimen6 = "Razon sociales 6"
        case otro = "Otro"
        
        var id: String { self.rawValue }
    }
    
    
    var body: some View {
        NavigationView {
           
            Form {
               
                Section(header: Text("")) {
                    TextField("Nombre", text: $nombreSucursal)
                    TextField("Correo", text: $direccion)
                    TextField("Telefono", text: $ciudad)
                    Picker("Razones sociales", selection: $regimenFiscal) {
                        
                        ForEach(RegimenFiscal.allCases) { regimen in
                            Text(regimen.rawValue)
                        }
                    }
                }
                
                Section(header: Text("Notas")) {
                    TextEditor(text: $notas)
                        .frame(minHeight: 200)
                }
                
                HStack{
                    Spacer()
                    Image("logo") // Reemplaza "tu_imagen" con el nombre de tu imagen en el catálogo de activos
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                               .frame(width: 200, height: 200) // Ajusta el tamaño según sea necesario
                               .clipShape(Circle()) // Opcional: recorta la imagen en forma de círculo
                               .overlay(Circle().stroke(Color.blue, lineWidth: 4)) // Opcional: agrega un borde alrededor de la imagen
                               .shadow(radius: 10)
                    Spacer()
                }
                
                
                
                Section {
                    Button("Guardar") {
                        // Acción para guardar los datos del formulario
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

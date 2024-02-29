//
//  UsuariosView.swift
//  iecaappadmin
//
//  Created by Omar on 26/02/24.
//

import SwiftUI

struct UsuariosView: View {
    @State private var nombre: String = ""
       @State private var apellidoPaterno: String = ""
       @State private var apellidoMaterno: String = ""
       @State private var fechaNacimiento: Date = Date()
       @State private var numeroIdentificador: String = ""
       @State private var telefonoMovil: String = ""
       @State private var telefonoFijo: String = ""
       @State private var correoInstitucional: String = ""
       @State private var correoPersonal: String = ""
       @State private var sucursal: String = ""
       @State private var departamento: String = ""
       @State private var puesto: String = ""
       @State private var estadoDocencia: String = ""
       @State private var fechaIngreso: Date = Date()
       @State private var estatus: Bool = false
       @State private var notas: String = ""
       
       var body: some View {
           NavigationView {
               Form {
                   Section(header: Text("Selecciona un usuario")) {
                       Picker("Estado de Docencia", selection: $estadoDocencia) {
                           Text("Docente").tag("Docente")
                           Text("Instructor").tag("Instructor")
                       }
                   }
                   Section(header: Text("")) {
                       TextField("Nombre", text: $nombre)
                       TextField("Apellido Paterno", text: $apellidoPaterno)
                       TextField("Apellido Materno", text: $apellidoMaterno)
                       DatePicker("Fecha de Nacimiento", selection: $fechaNacimiento, displayedComponents: .date)
                       TextField("Número o Identificador", text: $numeroIdentificador)
                       TextField("Teléfono Móvil", text: $telefonoMovil)
                       TextField("Teléfono Fijo", text: $telefonoFijo)
                       TextField("Correo Institucional", text: $correoInstitucional)
                       TextField("Correo Personal", text: $correoPersonal)
                       TextField("Sucursal", text: $sucursal)
                       TextField("Departamento", text: $departamento)
                       TextField("Puesto", text: $puesto)
                       
                       Picker("Estado de Docencia", selection: $estadoDocencia) {
                           Text("Activo").tag("Activo")
                           Text("Inactivo").tag("Inactivo")
                       }
                       
                       DatePicker("Fecha de Ingreso", selection: $fechaIngreso, displayedComponents: .date)
                       Toggle("Estatus", isOn: $estatus)
                   }
                   Section(header: Text("Notas")) {
                       TextEditor(text: $notas)
                           .frame(minHeight: 200) // Altura mínima del TextEditor
                           .padding()
                           .background(Color.gray.opacity(0.1)) // Fondo del TextEditor
                           .cornerRadius(8) // Bordes redondeados
                           .padding()
                   }
                   HStack{
                       Spacer()
                       Image("logo")
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

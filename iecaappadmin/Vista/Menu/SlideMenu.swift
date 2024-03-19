//
//  SlideMenu.swift
//  iecaappadmin
//
//  Created by Omar on 12/02/24.
//

import SwiftUI


struct HomeView: View {
    
    @Binding var presentSideMenu: Bool
  
    
    var body: some View {
        VStack{
            HStack{
                Button{
                    presentSideMenu.toggle()
                } label: {
                    Image("hamburguesa")
                        .resizable()
                        .frame(width: 32, height: 32)
                }
                Spacer()
            }
            
            Spacer()
            Text("IECA")
            Spacer()
        }
        .padding(.horizontal, 24)
    }
}

struct SideMenu: View {
    @Binding var isShowing: Bool
    var content: AnyView
    var edgeTransition: AnyTransition = .move(edge: .leading)
    var body: some View {
        ZStack(alignment: .bottom) {
            if (isShowing) {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                content
                    .transition(edgeTransition)
                    .background(
                        Color.clear
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
}

enum SideMenuRowType: Int, CaseIterable{
    case dashboard = 0
    case cursos
    
    case profile
    case evaluaciones
    case ingresos
    case statement
    case editarcurso
    case editarevaluacion
    case tipoSucursal
    case instituto
    case actividades
    case competencias
    case materiales
    case programas
    case temas
    case razonSocial
    case zona
    case puesto
    case departamentos
    case sucursales
    case cursosActividades
    case cursosAutorizaciones
    case cursosBibliografia
    case cursosCompetencias
    case cursosDocumentacion
    case cursosEquipos
    case cursosInstructores
    case cursosTemas
    case cursosMateriales
    case SectorTipoCliente
    
    
    var title: String{
        switch self {
        case .dashboard:
            return "Dashborad"
        case .cursos:
            return "Cursos"
        case .evaluaciones:
            return "Modalidad"
        case .ingresos:
            return "Tipo confidencialidad"
        case .statement:
            return "Campo formacion"
        case .editarcurso:
            return "Area"
        case .editarevaluacion:
            return "Especialidades"
        case .profile:
            return "Plataforma"
        case .tipoSucursal:
            return "Tipo sucursal"
        case .instituto:
            return "Institucion"
        case .actividades:
            return "actividades"
        case .competencias:
            return "competencias"
        case .materiales:
            return "materiales"
        case .programas:
            return "programas"
        case .temas:
            return "temas"
        case .razonSocial:
            return "Razon social"
        case .zona:
            return "Zona"
        case .puesto:
            return "Puestos"
        case .departamentos:
            return "Departamentos"
        case .sucursales:
            return "Sucursales"
        case .cursosActividades:
            return "Cursos Actividades"
        case .cursosAutorizaciones:
            return "Cursos Autorizaciones"
        case .cursosBibliografia:
            return "Cursos Bibliografia"
        case .cursosCompetencias:
            return "Cursos Competencias"
        case .cursosDocumentacion:
            return "Cursos Documentacion"
        case .cursosEquipos:
            return "Cursos Documentacion"
        case .cursosInstructores:
            return "Cursos Instructores"
        case .cursosTemas:
            return "Cursos Temas"
        case .cursosMateriales:
            return "Cursos Materiales"
        case .SectorTipoCliente:
            return "Sector tipo cliente"
       
            
        }
        
    }
    
    var iconName: String{
        switch self {
        case .dashboard:
            return "ECA_azul"
        case .cursos:
            return "ECA_azul"
        case .evaluaciones:
            return "ECA_azul"
        case .ingresos:
            return "ECA_azul"
        case .statement:
            return "ECA_azul"
        case .editarcurso:
            return "ECA_azul"
        case .editarevaluacion:
            return "ECA_azul"
        case .profile:
            return "ECA_azul"
        case .tipoSucursal:
            return "ECA_azul"
        case .instituto:
            return "ECA_azul"
        case .actividades:
            return "ECA_azul"
        case .competencias:
            return "ECA_azul"
        case .materiales:
            return "ECA_azul"
        case .programas:
            return "ECA_azul"
        case .temas:
            return "ECA_azul"
        case .razonSocial:
            return "ECA_azul"
        case .zona:
            return "ECA_azul"
        case .puesto:
            return "ECA_azul"
        case .departamentos:
            return "ECA_azul"
        case .sucursales:
            return "ECA_azul"
        case .cursosActividades:
            return "ECA_azul"
        case .cursosAutorizaciones:
            return "ECA_azul"
        case .cursosBibliografia:
            return "ECA_azul"
        case .cursosCompetencias:
            return "ECA_azul"
        case .cursosDocumentacion:
            return "ECA_azul"
        case .cursosEquipos:
            return "ECA_azul"
        case .cursosInstructores:
            return "ECA_azul"
        case .cursosTemas:
            return "ECA_azul"
        case .cursosMateriales:
            return "ECA_azul"
        case .SectorTipoCliente:
            return "ECA_azul"
      
        }
    }
}

enum SideMenuRowType2: Int, CaseIterable{
    case home = 0
    case cursos
    case chat
    case profile
    
    var title: String{
        switch self {
        case .home:
            return "Inicio"
        case .cursos:
            return "Cursos disponibles"
        case .chat:
            return "categorias"
        case .profile:
            return "Dashboard"
        }
    }
    
    var iconName: String{
        switch self {
        case .home:
            return "IECA_azul"
        case .cursos:
            return "IECA_azul"
        case .chat:
            return "IECA_azul"
        case .profile:
            return "IECA_azul"
        }
    }
}

struct SideMenuView: View {
    
    @Binding var selectedSideMenuTab: Int
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        
        HStack {
            
            ZStack{
                Rectangle()
                    .fill(.white)
                    .frame(width: 270)
                    .shadow(color: .purple.opacity(0.1), radius: 5, x: 0, y: 3)
                
                VStack(alignment: .leading, spacing: 0) {
                    ScrollView {
                        ProfileImageView()
                            .frame(height: 140)
                            .padding(.bottom, 30)
                        SectionHeader(title: "Instructor")
                        ForEach(SideMenuRowType.allCases, id: \.self){ row in
                            RowView(isSelected: selectedSideMenuTab == row.rawValue, imageName: row.iconName, title: row.title) {
                                selectedSideMenuTab = row.rawValue
                                presentSideMenu.toggle()
                            }
                        }
//                        SectionHeader(title: "Alumno")
//                        ForEach(SideMenuRowType2.allCases, id: \.self){ row in
//                            RowView(isSelected: selectedSideMenuTab == row.rawValue, imageName: row.iconName, title: row.title) {
//                                selectedSideMenuTab = row.rawValue
//                                presentSideMenu.toggle()
//                            }
//                        }
                        Spacer()
                    }
                }
                .padding(.top, 100)
                .frame(width: 270)
                .background(
                    Color.white
                )
            }
            
            
            Spacer()
        }
        .background(.clear)
    }
    
    func ProfileImageView() -> some View{
        VStack(alignment: .center){
            HStack{
                Spacer()
                Image("user")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(.purple.opacity(0.5), lineWidth: 10)
                    )
                    .cornerRadius(50)
                Spacer()
            }
            
            Text("Omar Campos")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
            
            Text("IOS Developer")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black.opacity(0.5))
        }
    }
    
    func RowView(isSelected: Bool, imageName: String, title: String, hideDivider: Bool = false, action: @escaping (()->())) -> some View{
        Button{
            action()
        } label: {
            VStack(alignment: .leading){
                HStack(spacing: 20){
                    Rectangle()
                        .fill(isSelected ? .blue : .white)
                        .frame(width: 5)
                    
                    ZStack{
                        Image(imageName)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(isSelected ? .black : .gray)
                            .frame(width: 26, height: 26)
                    }
                    .frame(width: 30, height: 30)
                    Text(title)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(isSelected ? .black : .gray)
                    Spacer()
                }
            }
        }
        .frame(height: 50)
        .background(
            LinearGradient(colors: [isSelected ? .purple.opacity(0.5) : .white, .white], startPoint: .leading, endPoint: .trailing)
        )
    }
}

struct MainTabbedView: View {
    
    @State var presentSideMenu = false
    @State var selectedSideMenuTab = 0
    
    var body: some View {
        ZStack{
            TabView(selection: $selectedSideMenuTab) {
                HomeView(presentSideMenu: $presentSideMenu)
                    .tag(0)
                CursosView()
                    .tag(1)
                PlataformaView()
                    .tag(2)
                ModalidadView()
                    .tag(3)
                TipoConfidencialidadView()
                    .tag(4)
                CamposFormacionView()
                    .tag(5)
                AreasView()
                    .tag(6)
                EspecialidadesView()
                    .tag(7)
                TipoSucursalView(presentSideMenu: $presentSideMenu, showSignInView: $presentSideMenu)
                    .tag(8)
                InstitucionesView()
                    .tag(9)
                ActividadView()
                    .tag(10)
                CompetenciaView()
                    .tag(11)
                MaterialView()
                    .tag(12)
                ProgramaView()
                    .tag(13)
                TemasView()
                    .tag(14)
                RazonesSocialesView()
                    .tag(15)
                ZonasView()
                    .tag(16)
                PuestosView(presentSideMenu: $presentSideMenu, showSignInView: $presentSideMenu)
                    .tag(17)
                DepartamentosView()
                    .tag(18)
                SucursalesView()
                    .tag(19)
                CursosActividadView()
                    .tag(20)
                CursosAutorizacionView()
                    .tag(21)
                CursosBibliografiasView()
                    .tag(22)
                CursosCompetenciaView()
                    .tag(23)
                CursosDocView()
                    .tag(24)
                CursosEquiposView()
                    .tag(25)
                CursosInstructoresView()
                    .tag(26)
                CursosTemasView()
                    .tag(27)
                CursosMaterialesView()
                    .tag(28)
                SectorTipoCliente()
                    .tag(29)
                
            }.overlay (
                HStack {
                  
                }
                , alignment: .bottom
            )
            
            SideMenu(isShowing: $presentSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)))
        }
    }
}

struct SectionHeader: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.gray)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
    }
}

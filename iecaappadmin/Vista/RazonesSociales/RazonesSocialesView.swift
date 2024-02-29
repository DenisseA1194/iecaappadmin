import SwiftUI



struct RazonesSocialesView: View {
    @StateObject var viewModel = RazonSocialViewModel()
    @State private var _RazonSocialName = ""
    @State private var _Representante = ""
    @State private var _RFC = ""
    @State private var _Direccion = ""
    @State private var _Colonia = ""
    @State private var _CodigoPotal = ""
    @State private var _Ciudad = ""
    @State private var _Estado = ""
    @State private var _Pais = ""
    @State private var _Telefono = ""
    @State private var _Notas = ""
    @State private var _idRazonSocial = ""
    @State private var buttonText = "Agregar"
    @State private var razonesSociales: [RazonSocial] = [] // Asegúrate de tener esta propiedad en tu ViewModel
    @State var seleccionRazonSocial: Int = 0
    
    func LimpiarForm(){
        _RazonSocialName = ""
        _Representante = ""
        _RFC = ""
        _Direccion = ""
        _Colonia = ""
        _CodigoPotal = ""
        _Ciudad = ""
        _Estado = ""
        _Pais = ""
        _Telefono = ""
        _Notas = ""
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Selecciona una Razón Social")) {
                    Picker("Razones sociales", selection: $seleccionRazonSocial) {
                        
                        let i = 0
                        ForEach([0] + viewModel.razonSocials.indices.map { $0 + 1 }, id: \.self) { index in
                            if index == 0 {
                                Text("") // Agregar texto vacío al principio
                                    .tag(0)
                            } else {
                                Text(viewModel.razonSocials[index - 1].Nombre)
                                    .tag(index)
                            }
                        }
                        
                    }.onChange(of: seleccionRazonSocial) { index in
                        // Aquí puedes acceder a los campos de la razón social seleccionada
                        print(index)
                        if index != 0 {
                            let razonSocialSeleccionada = viewModel.razonSocials[index-1]
                            print(razonSocialSeleccionada.Nombre)
                            _RazonSocialName = razonSocialSeleccionada.Nombre
                            _Representante = razonSocialSeleccionada.Representante
                            _Direccion = razonSocialSeleccionada.Direccion
                            _Colonia = razonSocialSeleccionada.Colonia
                            _CodigoPotal = razonSocialSeleccionada.CodigoPostal
                            _Ciudad = razonSocialSeleccionada.Ciudad
                            _Estado = razonSocialSeleccionada.Estado
                            _Pais = razonSocialSeleccionada.Pais
                            _Telefono = razonSocialSeleccionada.Telefono
                            _idRazonSocial = razonSocialSeleccionada.id
                            //_Notas = razonSocialSeleccionada.Notas
                            
                            buttonText = "Actualizar"
                        }else{
                            LimpiarForm()
                        }
                        
                        // Asigna otros campos según sea necesario
                    }
                    .onAppear {
                        // Llama a tu función para recuperar las razones sociales
                        viewModel.fetchRazonSocials()
                        
                        seleccionRazonSocial = 0
                    }.toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                seleccionRazonSocial = 0
                                LimpiarForm()
                            }) {
                                
                                Image(systemName: "plus")
                                
                            }
                        }
                    }
                }
                
                Section(header: Text("Razón Social")) {
                    TextField("Razon social", text: $_RazonSocialName)
                    TextField("Representante", text: $_Representante)
                    TextField("RFC", text: $_RFC)
                    TextField("Direccion", text: $_Direccion)
                    TextField("Colonia", text: $_Colonia)
                    TextField("Codigo postal", text: $_CodigoPotal)
                    TextField("Ciudad", text: $_Ciudad)
                    TextField("Estado", text: $_Estado)
                    TextField("Pais", text: $_Pais)
                    TextField("Telefono", text: $_Telefono)
                    TextField("Notas", text: $_Notas)
                    
                    Picker("Regimen Fiscal", selection: $seleccionRazonSocial) {
                        
                        ForEach(razonesSociales, id: \.id) { razonSocial in
                            Text(razonSocial.Nombre) // Asegúrate de tener un atributo "nombre" en tu modelo RazonSocial
                        }
                    }
                    
                    HStack {
                        Spacer()
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100) // Ajusta el tamaño según tus necesidades
                            .pickerStyle(.menu)
                        Spacer()
                        
                        // Agrega un espacio vertical flexible para centrar verticalmente la imagen
                    }
                    
                    
                }
                
                Button(action: {
                    if buttonText == "Agregar"{
                        let nuevaRazonSocial = RazonSocial(Id: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
                                                           IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
                                                           Nombre: _RazonSocialName,
                                                           Fecha: "2024-01-30T19:06:05.675Z",
                                                           Representante: _Representante,
                                                           RFC: _RFC,
                                                           Direccion: _Direccion,
                                                           CodigoPostal: _CodigoPotal,
                                                           Ciudad: _Ciudad,
                                                           Colonia: _Colonia,
                                                           Estado: _Estado,
                                                           Pais:_Pais,
                                                           Regimen1: " ",
                                                           Telefono: _Telefono,
                                                           IMGFIREBASE: " "
                                                           )
                        viewModel.agregarNuevaRazonSocial(nuevaRazonSocial: nuevaRazonSocial)
                    }else{
                        let RazonSocial = RazonSocial(Id: _idRazonSocial,
                                                           IdEmpresa: "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C",
                                                           Nombre: _RazonSocialName,
                                                           Fecha: "2024-01-30T19:06:05.675Z",
                                                           Representante: _Representante,
                                                           RFC: _RFC,
                                                           Direccion: _Direccion,
                                                           CodigoPostal: _CodigoPotal,
                                                           Ciudad: _Ciudad,
                                                           Colonia: _Colonia,
                                                           Estado: _Estado,
                                                           Pais:_Pais,
                                                           Regimen1: " ",
                                                           Telefono: _Telefono,
                                                           IMGFIREBASE: " "
                                                           )
                        viewModel.editarRazonSocial(razonSocial: RazonSocial)
                    }
                    
                                           LimpiarForm()
                    }) {
                        Text(buttonText)
                            .frame(maxWidth: .infinity) // Asegura que el texto ocupe todo el ancho disponible
                            .multilineTextAlignment(.center) // Centra el texto
                    }
            }
            .navigationTitle("Razón Social")
        }
    }
}



struct RazonesSocialesView_Previews: PreviewProvider {
    static var previews: some View {
        RazonesSocialesView()
    }
}

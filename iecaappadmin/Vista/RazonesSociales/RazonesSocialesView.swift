import SwiftUI
import FirebaseStorage


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
    @State private var _idRegimenFiscal = ""
    @State private var buttonText = "Agregar"
    @State private var avisoText = ""
    @State private var searchText: String = ""
    
    
    @State private var image: Image?
    
    
    
    
    @State private var showAlert = false
    @State private var showAlertAgregarModificar = false
    
    @State private var razonesSociales: [RazonSocial] = [] // Asegúrate de tener esta propiedad en tu ViewModel
    @State var seleccionRazonSocial: Int = 0
    @StateObject var viewModelRF = CatalogoClientesRegimenFiscalViewModel()
    @State private var seleccionRegimenFiscal: Int = 0
    
    @StateObject var viewModelZona = ZonasViewModel()
    @State var seleccionZona: Int = 0
    
    
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
   
    
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
        urlImagenFirebase = ""
    }
    
    
    func todosLosCamposEstanCompletos() -> Bool {
        // Verificar si todos los campos necesarios están llenos
        guard !_RazonSocialName.isEmpty,
              !_Representante.isEmpty,
              !_RFC.isEmpty,
              !_Direccion.isEmpty,
              !_CodigoPotal.isEmpty,
              !_Ciudad.isEmpty,
              !_Colonia.isEmpty,
              !_Estado.isEmpty,
              !_Pais.isEmpty,
              !_idRegimenFiscal.isEmpty,
              !_Telefono.isEmpty,
              let urlImagenFirebase = urlImagenFirebase else {
                  // Si algún campo está vacío, retornar falso
                  return false
              }
        
        // Si todos los campos están llenos, retornar verdadero
        return true
    }
    
//    @StateObject var viewModel = RazonSocialViewModel()
       // Otros estados y variables de tu vista
       // ...
       
       // Instancia de Firebase Storage
       let storage = Storage.storage()

       // URL de la imagen almacenada en Firebase Storage
//       @State private var urlImagenFirebase: String = ""
    
    @State private var imageUrl: String?
    @State private var urlImagenFirebase: String? = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    Picker("Razones sociales", selection: $seleccionRazonSocial) {
                        let i = 0
                        ForEach([0] + viewModel.razonSocials.indices.map { $0 + 1 }, id: \.self) { index in
                            if index == 0 {
                                Text("")
                                    .tag(0)
                            } else {
                                Text(viewModel.razonSocials[index - 1].Nombre)
                                    .tag(index)
                            }
                        }
                    }.onChange(of: seleccionRazonSocial) { index in
                        
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
                            _Notas = razonSocialSeleccionada.Notas
                            _RFC = razonSocialSeleccionada.RFC
                            _idRegimenFiscal = razonSocialSeleccionada.Regimen1
                            urlImagenFirebase = razonSocialSeleccionada.IMGFIREBASE
                           
                            if let posicionRegistro = viewModelRF.regimenesFiscales.firstIndex(where: { $0.Id.uppercased() == razonSocialSeleccionada.Regimen1.uppercased() }) {
                                seleccionRegimenFiscal = posicionRegistro
                                print(razonSocialSeleccionada.Regimen1)
                                
                            }
                            
                            buttonText = "Actualizar"
                        }else{
                            LimpiarForm()
                        }
                        
                        
                    }
                    .onAppear {
                        
                        viewModel.fetchRazonSocials()
                        viewModelRF.fetch()
                        seleccionRazonSocial = 0
                        
                        
                    }.toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                showAlert.toggle()
                                seleccionRazonSocial = 0
                                LimpiarForm()
                            }) {
                                
                                Image(systemName: "plus")
                                
                            }
                        }
                    }.alert(isPresented: $showAlert) {
                        Alert(title: Text("Aviso"), message: Text("Agrega una nueva razon social"), dismissButton: .default(Text("Aceptar")))
                    }
                }
                
                Section() {
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
                    
                    Picker("Regimen Fiscal", selection: $seleccionRegimenFiscal) {
                        
                        ForEach(viewModelRF.regimenesFiscales.indices.map { $0}, id: \.self) { index in
                            
                            Text(viewModelRF.regimenesFiscales[index].C_RegimenFiscal+" "+viewModelRF.regimenesFiscales[index].Descripcion)
                                .tag(index)
                        }
                        
                    }.onChange(of: seleccionRegimenFiscal) { index in
                        let regimenFiscalSeleccionada = viewModelRF.regimenesFiscales[seleccionRegimenFiscal]
                        _idRegimenFiscal = regimenFiscalSeleccionada.Id
                        print(regimenFiscalSeleccionada.Id)
                    }
                    
                    
                }
                
                Section() {
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
                            imageUrl = "4BBC69B0-F299-4033-933F-2DE7DC8B9E8C/LogoRazonSocial/"
                            isShowingImagePicker.toggle()
                        }
                        .sheet(isPresented: $isShowingImagePicker) {
                            ImagePicker(image: $image, isPresented: $isShowingImagePicker, imageUrl: $imageUrl, urlImagenFirebase: $urlImagenFirebase)
                        }
                    }
                   
                }
                
                
                HStack {
                    
                    Button(action: {
                        if todosLosCamposEstanCompletos() {
                            if buttonText == "Agregar"{
                                avisoText = "Registro Agregado"
                                showAlertAgregarModificar.toggle()
                                
                                
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
                                                                   Regimen1: _idRegimenFiscal,
                                                                   Telefono: _Telefono,
                                                                   IMGFIREBASE: urlImagenFirebase!,
                                                                   Notas: _Notas
                                )
                                viewModel.agregarNuevaRazonSocial(nuevaRazonSocial: nuevaRazonSocial)
                                viewModel.fetchRazonSocials()
                            }else{
                                avisoText = "Registro Modificado"
                                showAlertAgregarModificar.toggle()
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
                                                              Regimen1: _idRegimenFiscal,
                                                              Telefono: _Telefono,
                                                              IMGFIREBASE: urlImagenFirebase!,
                                                              Notas: _Notas
                                )
                                viewModel.editarRazonSocial(razonSocial: RazonSocial)
                                viewModel.fetchRazonSocials()
                                
                            }
                            LimpiarForm()
                            
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
                .navigationTitle("Razón Social")
            }
        }
    }
    
    
    
    struct RazonesSocialesView_Previews: PreviewProvider {
        static var previews: some View {
            RazonesSocialesView()
        }
    }
    
//    struct ImagePicker: UIViewControllerRepresentable {
//        @Binding var image: Image?
//        @Binding var isPresented: Bool
//        let storage = Storage.storage()
//        @State private var urlImagenFirebase: String = ""
//        @Binding var imageUrl: String?
//        
//        
//        func uploadImageToFirebaseStorage(_ image: UIImage) {
//                guard let imageData = image.jpegData(compressionQuality: 0.5) else {
//                    print("No se pudo convertir la imagen a datos")
//                    return
//                }
//                
//                let storageRef = storage.reference()
//                let ruta = "\(imageUrl ?? "")\(UUID().uuidString).jpg"
//                print(ruta)
//                let imageRef = storageRef.child(ruta)
//                
//                let metadata = StorageMetadata()
//                metadata.contentType = "image/jpeg"
//                
//                // Subir la imagen
//                imageRef.putData(imageData, metadata: metadata) { (metadata, error) in
//                    guard let metadata = metadata else {
//                        print("Error al subir la imagen: \(error?.localizedDescription ?? "Unknown error")")
//                        return
//                    }
//                    print("Imagen cargada exitosamente. Tamaño: \(metadata.size)")
//                    
//                    // Aquí puedes obtener la URL de descarga de la imagen si la necesitas
//                    imageRef.downloadURL { (url, error) in
//                        if let downloadURL = url {
//                            print("URL de descarga de la imagen: \(downloadURL.absoluteString)")
//                            // Asigna la URL de descarga de la imagen a tu variable urlImagenFirebase
//                            self.urlImagenFirebase = downloadURL.absoluteString
//                        } else {
//                            print("Error al obtener la URL de descarga de la imagen: \(error?.localizedDescription ?? "Unknown error")")
//                        }
//                    }
//                }
//            }
//        
//        func makeUIViewController(context: Context) -> UIImagePickerController {
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = context.coordinator
//            return imagePicker
//        }
//        
//        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//        
//        func makeCoordinator() -> Coordinator {
//            Coordinator(parent: self)
//        }
//        
//        class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//            let parent: ImagePicker
//            
//            init(parent: ImagePicker) {
//                self.parent = parent
//            }
//            
//            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//                if let uiImage = info[.originalImage] as? UIImage {
//                    parent.image = Image(uiImage: uiImage)
//                    
//                    parent.uploadImageToFirebaseStorage(uiImage)
//                    
//                    
//                }
//                
//                
//                
//                parent.isPresented = false
//            }
//        }
//    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

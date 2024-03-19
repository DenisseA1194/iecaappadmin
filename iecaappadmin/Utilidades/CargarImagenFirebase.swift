import FirebaseStorage
import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: Image?
    @Binding var isPresented: Bool
    let storage = Storage.storage()
//    @State private var urlImagenFirebase: String = ""
    @Binding var imageUrl: String?
    @Binding var urlImagenFirebase: String?
    
    
    func uploadImageToFirebaseStorage(_ image: UIImage) {
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                print("No se pudo convertir la imagen a datos")
                return
            }
            
            let storageRef = storage.reference()
            let ruta = "\(imageUrl ?? "")\(UUID().uuidString).jpg"
            print(ruta)
            let imageRef = storageRef.child(ruta)
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            // Subir la imagen
            imageRef.putData(imageData, metadata: metadata) { (metadata, error) in
                guard let metadata = metadata else {
                    print("Error al subir la imagen: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                print("Imagen cargada exitosamente. Tamaño: \(metadata.size)")
                
                // Aquí puedes obtener la URL de descarga de la imagen si la necesitas
                imageRef.downloadURL { (url, error) in
                    if let downloadURL = url {
                        print("URL de descarga de la imagen: \(downloadURL.absoluteString)")
                        // Asigna la URL de descarga de la imagen a tu variable urlImagenFirebase
                        self.urlImagenFirebase = downloadURL.absoluteString
                    } else {
                        print("Error al obtener la URL de descarga de la imagen: \(error?.localizedDescription ?? "Unknown error")")
                    }
                }
            }
        }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = Image(uiImage: uiImage)
                
                parent.uploadImageToFirebaseStorage(uiImage)
                
                
            }
            
            
            
            parent.isPresented = false
        }
    }
}

import SwiftUI
import MobileCoreServices
import FirebaseStorage

struct DocumentPicker: UIViewControllerRepresentable {
    
    @Binding var selectedFile: URL?
    let storage = Storage.storage()
    
    
    func uploadFile(from url: URL) {
        // Configura una referencia al archivo en Firebase Storage
        let storageRef = storage.reference().child("uploads").child("Archivo.pdf")
        
        // Sube el archivo al Firebase Storage
        storageRef.putFile(from: url, metadata: nil) { metadata, error in
            if let error = error {
                print("Error al cargar el archivo: \(error)")
            } else {
                print("¡Archivo cargado exitosamente!")
                // Aquí puedes realizar cualquier acción adicional después de cargar el archivo, si es necesario
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf, .text])
        documentPicker.delegate = context.coordinator
        return documentPicker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPicker

        init(_ parent: DocumentPicker) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            if let selectedFileURL = urls.first {
                parent.selectedFile = selectedFileURL
                
                if isValidURL(selectedFileURL.absoluteString) {
                    parent.uploadFile(from: selectedFileURL)
                    // La URL es válida, puedes proceder con la carga del archivo u otras operaciones
                } else {
                    print("Url inválida")
                }
            }
        }
        
        func isValidURL(_ urlString: String) -> Bool {
            if let _ = URL(string: urlString) {
                // Si la instancia de URL no es nil, la URL es válida
                return true
            } else {
                return false
            }
        }
    }
}

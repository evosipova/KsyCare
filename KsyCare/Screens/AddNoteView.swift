import SwiftUI

struct NoteEntry {
    var sugarLevel: Double
    var breadUnits: Double
    var shortInsulinDose: Double
    var longInsulinDose: Double
    var notes: String
    var photo: UIImage?
    var date: Date
}

class NotesViewModel: ObservableObject {
    @Published var entries: [NoteEntry] = []
    @Published var sugarLevel: Double = 0.0
    @Published var breadUnits: Double = 0.0
    @Published var shortInsulinDose: Double = 0.0
    @Published var longInsulinDose: Double = 0.0
    @Published var notes: String = ""
    @Published var photo: UIImage?
    
    @Published var isShowingImagePicker = false
    
    func showImagePicker(sourceType: UIImagePickerController.SourceType) {
        self.isShowingImagePicker = true
    }
    
    func addEntry() {
        let newEntry = NoteEntry(
            sugarLevel: sugarLevel,
            breadUnits: breadUnits,
            shortInsulinDose: shortInsulinDose,
            longInsulinDose: longInsulinDose,
            notes: notes,
            photo: photo,
            date: Date()
        )
        entries.append(newEntry)
        resetFields()
    }
    
    func resetFields() {
        sugarLevel = 0.0
        breadUnits = 0.0
        shortInsulinDose = 0.0
        longInsulinDose = 0.0
        notes = ""
        photo = nil
    }
}

struct LabeledSlider: View {
    var label: String
    @Binding var value: Double
    var range: (Double, Double)
    var step: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(label): \(value, specifier: "%.1f")")
                .bold()
            Slider(value: $value, in: range.0...range.1, step: step)
        }
        .padding()
    }
}

struct AddNoteView: View {
    @ObservedObject var viewModel: NotesViewModel
    
    @State private var showingSourceSelection = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    
    var body: some View {
        VStack {
            LabeledSlider(label: "Сахар (ммоль/л)", value: $viewModel.sugarLevel, range: (0.0, 20.0), step: 0.1)
            
            LabeledSlider(label: "Хлебные единицы (XE)", value: $viewModel.breadUnits, range: (0.0, 10.0), step: 0.5)
            
            LabeledSlider(label: "Короткий инсулин (ед.)", value: $viewModel.shortInsulinDose, range: (0.0, 50.0), step: 1)
            
            LabeledSlider(label: "Продленный инсулин (ед.)", value: $viewModel.longInsulinDose, range: (0.0, 50.0), step: 1)
            
            TextField("Что-нибудь еще?", text: $viewModel.notes)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Добавить фото") {
                self.showingSourceSelection = true
            }
            
            HStack {
                Button("Сбросить") {
                    viewModel.resetFields()
                }
                
                Button("Сохранить") {
                    viewModel.addEntry()
                }
            }
            .actionSheet(isPresented: $showingSourceSelection) {
                ActionSheet(
                    title: Text("Откуда?"),
                    buttons: [
                        .default(Text("Галерея"), action: {
                            self.sourceType = .photoLibrary
                            viewModel.showImagePicker(sourceType: self.sourceType)
                        }),
                        .default(Text("Камера"), action: {
                            self.sourceType = .camera
                            viewModel.showImagePicker(sourceType: self.sourceType)
                        }),
                        .cancel(Text("Отменить"))
                    ]
                )
            }
            .sheet(isPresented: $viewModel.isShowingImagePicker) {
                ImagePicker(image: self.$viewModel.photo, sourceType: self.sourceType)
            }
        }
    }
    
    struct AddNoteView_Previews: PreviewProvider {
        static var previews: some View {
            AddNoteView(viewModel: NotesViewModel())
        }
    }
    
    
    
    
    struct ImagePicker: UIViewControllerRepresentable {
        @Binding var image: UIImage?
        @Environment(\.presentationMode) var presentationMode
        let sourceType: UIImagePickerController.SourceType
        
        func makeUIViewController(context: Context) -> UIImagePickerController {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator
            picker.sourceType = sourceType
            return picker
        }
        
        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
        
        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
        
        class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
            let parent: ImagePicker
            
            init(_ parent: ImagePicker) {
                self.parent = parent
            }
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                if let uiImage = info[.originalImage] as? UIImage {
                    parent.image = uiImage
                }
                parent.presentationMode.wrappedValue.dismiss()
            }
            
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                parent.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
}

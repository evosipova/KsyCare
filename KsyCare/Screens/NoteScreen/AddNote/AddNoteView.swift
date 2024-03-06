import SwiftUI

struct AddNoteView: View {
    @ObservedObject var viewModel: AddNoteViewModel
    @Binding var showingPopup: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Добавить запись")
                .font(.custom("Amiko", size: 20).bold())
                .foregroundColor(.black)
                .padding(.top, 7)
                .padding(.leading, 28)
            
            Divider()
                .padding(.horizontal, 28)
            
            ForEach(viewModel.getButtons(), id: \.title) { button in
                Button(action: { button.showingView.wrappedValue = true }) {
                    HStack {
                        Image(systemName: button.systemImage)
                        Text(button.title)
                            .font(.custom("Amiko", size: 20))
                        Spacer()
                    }
                }
                .fullScreenCover(isPresented: button.showingView) {
                    button.destinationView
                }
                .frame(maxWidth: .infinity)
                .padding(.leading, 28)
                .padding(.bottom, 30)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .foregroundColor(.black)
        .cornerRadius(40)
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView(viewModel: AddNoteViewModel(), showingPopup: .constant(true))
    }
}

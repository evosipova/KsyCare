import SwiftUI

struct AddNoteView: View {
    @ObservedObject var viewModel: AddNoteViewModel
    @Binding var showingPopup: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Добавить запись")
                .font(.custom("Amiko", size: 20).bold())
                .foregroundColor(Color("2A2931-CCF6FF"))
                .padding(.top, 7)
                .padding(.leading, 28)

            Rectangle()
                .frame(height: 3)
                .foregroundColor(Color("B6E4EF-548493"))
                .padding(.horizontal, 28)

            ForEach(viewModel.getButtons(), id: \.title) { button in
                Button(action: { button.showingView.wrappedValue = true }) {
                    HStack {
                        Image(button.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 28, height: 28)
                            .foregroundColor(Color("58EEE5"))
                        Text(button.title)
                            .font(.custom("Amiko", size: 20))
                            .foregroundColor(Color("2A2931-CCF6FF"))
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
        .background(Color("F1FDFB-365E7A"))
        .foregroundColor(Color("2A2931-CCF6FF"))
        .cornerRadius(40)
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView(viewModel: AddNoteViewModel(), showingPopup: .constant(true))
    }
}

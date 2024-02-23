import SwiftUI

struct AddNoteView: View {
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
                .font(.custom("Amiko", size: 50))

            ForEach(buttons, id: \.title) { button in
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
            }
            .padding(.leading, 28)
            .padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .foregroundColor(.black)
        .cornerRadius(40)
    }


    private struct ButtonInfo {
        let title: String
        let systemImage: String
        let showingView: Binding<Bool>
        let destinationView: AnyView
    }

    @State private var showingFoodView = false
    @State private var showingBloodSugarView = false
    @State private var showingInsulinView = false
    @State private var showingCombinedView = false

    private var buttons: [ButtonInfo] {
        [
            ButtonInfo(title: "Еда", systemImage: "circle.fill", showingView: $showingFoodView, destinationView: AnyView(FoodView())),
            ButtonInfo(title: "Сахар крови", systemImage: "circle.fill", showingView: $showingBloodSugarView, destinationView: AnyView(BloodSugarView())),
            ButtonInfo(title: "Инсулин", systemImage: "circle.fill", showingView: $showingInsulinView, destinationView: AnyView(InsulinView())),
            ButtonInfo(title: "Еда, Сахар крови, Инсулин", systemImage: "circle.fill", showingView: $showingCombinedView, destinationView: AnyView(CombinedView()))
        ]
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView(showingPopup: .constant(true))
            .padding(.horizontal, 10)
    }
}

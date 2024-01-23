import SwiftUI

struct AddNoteView: View {
    @Binding var showingPopup: Bool

    @State private var showingFoodView = false
    @State private var showingBloodSugarView = false
    @State private var showingInsulinView = false
    @State private var showingCombinedView = false


    var body: some View {
        VStack(alignment: .leading) {
            Text("Добавить запись")
                .font(.custom("Amiko", size: 18).bold())
                .foregroundColor(.black)
                .padding(.top, 21)
                .padding(.leading, 28)

            Divider()
                .padding(.vertical, 7)
                .padding(.horizontal, 28)

            Group {
                Button(action: { showingFoodView = true }) {
                    HStack {
                        Image(systemName: "applelogo")
                        Text("Еда")
                        Spacer()
                    }
                }
                .fullScreenCover(isPresented: $showingFoodView) {
                    FoodView()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)

                Button(action: { showingBloodSugarView = true }) {
                    HStack {
                        Image(systemName: "drop.fill")
                        Text("Сахар крови")
                        Spacer()
                    }
                }
                .fullScreenCover(isPresented: $showingBloodSugarView) {
                    BloodSugarView()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)

                Button(action: { showingInsulinView = true }) {
                    HStack {
                        Image(systemName: "cross.case.fill")
                        Text("Инсулин")
                        Spacer()
                    }
                }
                .fullScreenCover(isPresented: $showingInsulinView) {
                    InsulinView()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)

                Button(action: { showingCombinedView = true }) {
                    HStack {
                        Image(systemName: "tray.fill")
                        Text("Еда, Сахар крови, Инсулин")
                        Spacer()
                    }
                }
                .fullScreenCover(isPresented: $showingCombinedView) {
                    CombinedView()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            }
            .padding(.horizontal, 28)

            Button("Закрыть") {
                showingPopup = false
            }
            .padding(.leading, 28)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(40)
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView(showingPopup: .constant(true))
    }
}

import SwiftUI

struct MealCardDetailView: View {
    var card: MealCardModel
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var mealCardsData: MealCardViewModel

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                content
                Spacer()
                actionButtons
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(true)
    }

    private var content: some View {
        VStack {
            VStack() {
                header
                info
                Spacer()
            }
        }
    }

    private var header: some View {
        VStack {
            HStack {
                backButton
                Spacer()
            }
            .padding()
        }
    }

    private var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 13, height: 26)
        }
        .padding(.leading, 13)
    }

    private var info: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(card.mealTime)
                        .font(.headline)
                    Spacer()
                    Text(card.creationTime.description)
                        .font(.body)
                }
                .padding(.top, 5)

                Divider().background(Color.gray)

                if let bloodSugar = card.bloodSugar {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Сахар крови")
                            .padding(.trailing, 40)
                        infoRow(label: "Сахар крови", value: String(format: "%.2f", bloodSugar), color: .black)
                    }
                }

                if let insulin = card.insulin {

                    VStack(alignment: .leading, spacing: 20) {
                        Text("Инсулин")
                            .padding(.trailing, 40)
                        infoRow(label: "Инсулин", value: String(format: "%.2f", insulin), color: .black)
                    }
                }


                if let breadUnits = card.breadUnits {
                    Text("Еда: \(breadUnits, specifier: "%.2f")")
                }

                if let comments = card.comments, !comments.isEmpty {
                    Divider().background(Color.gray)
                    Text(comments).font(.body)
                }
            }
            .padding()
        }
        .navigationTitle("Детали записи")
        .navigationBarHidden(true)
    }

    private func infoRow(label: String, value: String, color: Color) -> some View {
        HStack {
            Image(systemName: "circle.fill")
                .foregroundColor(color)
            Text(label)
                .font(.body)
            Spacer()
            Text(value)
                .font(.body)
        }
    }

    private var actionButtons: some View {
        HStack(spacing: -20) {
            Button(action: {
                withAnimation {
                    mealCardsData.deleteCard(card)
                    presentationMode.wrappedValue.dismiss()
                }
            }) {
                HStack {
                    Image(systemName: "trash")
                        .foregroundColor(.gray)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.bottom, 30)
                .padding(.horizontal, 20)
            }


            Button(action: {
                // Implement edit action
            }) {
                Text("Изменить запись")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(10)
                    .padding(.bottom, 30)
                    .padding(.horizontal, 20)
            }
        }
        .background(Color.white)
    }
}

struct MealCardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealCardDetailView(card: MealCardModel(mealTime: "Обед", creationTime: Date.now, bloodSugar: 4.8, insulin: 3.5, comments: "hi"))
    }
}

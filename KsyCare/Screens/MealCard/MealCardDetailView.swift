import SwiftUI

struct MealCardDetailView: View {
    var card: MealCardModel
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var mealCardsData: MealCardViewModel

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.349, green: 0.624, blue: 0.859),
                                                           Color(red: 0.8, green: 0.965, blue: 1),
                                                           Color(red: 0.948, green: 0.992, blue: 0.985)

                                                          ]),
                               startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

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
                .foregroundColor(Color("4579A5-B5E3EE"))
        }
        .padding(.leading, 8)
    }

    private var info: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(card.mealTime)
                        .font(.largeTitle)
                        .foregroundColor(Color("2A2931-CCF6FF"))

                    Spacer()

                    Text(formatDate(card.creationTime))
                        .font(.title)
                        .foregroundColor(Color("2A2931-CCF6FF"))
                }
                .padding(.top, 5)

                Rectangle()
                    .frame(height: 3)
                    .foregroundColor(Color("B6E4EF-548493"))

                if let bloodSugar = card.bloodSugar {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Image(systemName: "circle.fill")
                                .foregroundColor(Color("58EEE5-27D8CD"))
                            Text("Сахар крови")
                                .font(.title2)
                                .padding(.trailing, 40)
                                .foregroundColor(Color("2A2931-CCF6FF"))
                        }
                        infoRow(label: "Ммоль/л", value: String(format: "%.2f", bloodSugar))
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("CCF6FF")))
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.top, 30)
                }

                if let insulin = card.insulin {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Image(systemName: "circle.fill")
                                .foregroundColor(Color("58EEE5-27D8CD"))
                            Text("Инсулин")
                                .font(.title2)
                                .padding(.trailing, 40)
                                .foregroundColor(Color("2A2931-CCF6FF"))
                        }
                        infoRow(label: "Единицы", value: String(format: "%.2f", insulin))
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("CCF6FF")))
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.top, 30)
                }

                if let breadUnits = card.breadUnits {
                    Text("Еда: \(breadUnits, specifier: "%.2f")")
                }

                if let comments = card.comments, !comments.isEmpty {
                    Rectangle()
                        .frame(height: 3)
                        .foregroundColor(Color("B6E4EF-548493"))

                    VStack(alignment: .leading, spacing: 20) {
                        Text("Комментарий")
                            .font(.title2)

                        Text(comments)
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color("2A2931-CCF6FF"))
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("CCF6FF")))
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Детали записи")
        .navigationBarHidden(true)
    }

    private func infoRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(.title2)
                .foregroundColor(Color("2A2931-CCF6FF"))
            Spacer()

            Text(value)
                .font(.title2)
                .foregroundColor(Color("2A2931-CCF6FF"))
        }
    }

    private var actionButtons: some View {
        Button(action: {
            withAnimation {
                mealCardsData.deleteCard(card)
                presentationMode.wrappedValue.dismiss()
            }
        }) {
            Text("Удалить запись")
                .foregroundColor(Color("2A2931-CCF6FF"))
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color("58EEE5-27D8CD")))
                .padding(.horizontal, 20)
        }
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm"
        return formatter.string(from: date)
    }
}

struct MealCardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealCardDetailView(card: MealCardModel(mealTime: "Обед", creationTime: Date.now, bloodSugar: 4.8, insulin: 3.5, comments: "hi"))
    }
}

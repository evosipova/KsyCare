import SwiftUI

struct MealCardView: View {
    @ObservedObject var viewModel: MealCardViewModel
    var card: MealCardModel

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                if !card.mealTime.isEmpty {
                    Image("mainPlus-pdf")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("58EEE5"))

                    Text(card.mealTime)
                        .font(.headline)
                        .foregroundColor(Color("2A2931-CCF6FF"))
                }

                Spacer()
                Text(viewModel.formatCreationTime(for: card))
                    .font(.body)
                    .foregroundColor(Color("7A9DA8"))
            }
            .padding(.top, 5)

            Rectangle()
                .frame(height: 3)
                .foregroundColor(Color("B6E4EF-548493"))

            if let breadUnits = card.breadUnits {
                infoRow(label: "ХЕ", value: String(format: "%.2f", breadUnits), color:  Color("ABF1ED-84EBE5"))
            }

            if let bloodSugar = card.bloodSugar {
                infoRow(label: "Сахар крови", value: String(format: "%.2f", bloodSugar), color:  Color("ABF1ED-84EBE5"))
            }

            if let insulin = card.insulin {
                infoRow(label: "Инсулин", value: String(format: "%.2f", insulin), color: Color("ABF1ED-84EBE5"))
            }

            if let comments = card.comments, !comments.isEmpty {
                Rectangle()
                    .frame(height: 3)
                    .foregroundColor(Color("B6E4EF-548493"))
                Text(comments).font(.body)
                    .foregroundColor(Color("2A2931-CCF6FF"))
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(Color("cardBackground"))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 0)
    }

    private func infoRow(label: String, value: String, color: Color) -> some View {
        HStack {
            Image(iconName(forLabel: label))
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(color)
            Text(label)
                .font(.body)
                .foregroundColor(Color("2A2931-CCF6FF"))
            Spacer()
            Text(value)
                .font(.body)
                .foregroundColor(Color("2A2931-CCF6FF"))
        }
    }

    private func iconName(forLabel label: String) -> String {
        switch label {
        case "Сахар крови":
            return "bloodPlus-pdf"
        case "ХЕ":
            return "foodPlus-pdf"
        case "Инсулин":
            return "insulinPlus-pdf"
        default:
            return "circle.fill"
        }
    }
}

struct MealCardView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MealCardViewModel()
        viewModel.addCard(card: MealCardModel(mealTime: "Обед", creationTime: Date(), bloodSugar: 5.0, breadUnits: 5.4, insulin: 3.0, comments: "Все хорошо!"))

        return MealCardView(viewModel: viewModel, card: viewModel.cards.first!)
            .padding(.horizontal, 10)
            .previewLayout(.sizeThatFits)
    }
}

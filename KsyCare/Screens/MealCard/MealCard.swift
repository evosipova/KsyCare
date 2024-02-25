import SwiftUI

struct MealCard: View {
    @ObservedObject var viewModel: MealCardViewModel
    var card: MealCardModel

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Text(card.mealTime)
                    .font(.headline)
                Spacer()
                Text(viewModel.formatCreationTime(for: card))
                    .font(.body)
            }
            .padding(.top, 5)

            Divider().background(Color.gray)

            if let bloodSugar = card.bloodSugar {
                infoRow(label: "Сахар крови", value: String(format: "%.2f", bloodSugar), color: .black)
            }

            if let breadUnits = card.breadUnits {
                infoRow(label: "ХЕ", value: String(format: "%.2f", breadUnits), color: .black)
            }

            if let insulin = card.insulin {
                infoRow(label: "Инсулин", value: String(format: "%.2f", insulin), color: .black)
            }

            if let comments = card.comments, !comments.isEmpty {
                Divider().background(Color.gray)
                Text(comments).font(.body)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 0)
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
}

struct MealCard_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MealCardViewModel()
        viewModel.addCard(card: MealCardModel(mealTime: "Обед", creationTime: Date(), bloodSugar: 5.0, breadUnits: 5.4, insulin: 3.0, comments: "Все хорошо!"))

        return MealCard(viewModel: viewModel, card: viewModel.cards.first!)
            .padding(.horizontal, 10)
            .previewLayout(.sizeThatFits)
    }
}

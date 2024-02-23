import Foundation

class MealCardViewModel: ObservableObject {
    @Published var cards: [MealCardModel] = []

    func addCard(card: MealCardModel) {
        cards.append(card)
    }

    func formatCreationTime(for card: MealCardModel) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm"
        return formatter.string(from: card.creationTime)
    }
}



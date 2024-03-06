import Foundation

class MealCardViewModel: ObservableObject {
    @Published var cards: [MealCardModel] = []
    @Published var allCards: [MealCardModel] = []

    func addCard(card: MealCardModel) {
        allCards.append(card)

        if Calendar.current.isDateInToday(card.creationTime) {
            cards.append(card)
        }
    }

    func formatCreationTime(for card: MealCardModel) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm"
        return formatter.string(from: card.creationTime)
    }

    func cardsGroupedByDate(from cardsList: [MealCardModel]) -> [Date: [MealCardModel]] {
        let groups = Dictionary(grouping: cardsList) { (card) -> Date in
            return Calendar.current.startOfDay(for: card.creationTime)
        }
        return groups
    }
}



import Foundation

class MealCardViewModel: ObservableObject {
    @Published var cards: [MealCardModel] = []
    @Published var allCards: [MealCardModel] = []
    private var midnightUpdater: Timer?

    var insulinProgress: CGFloat {
        let count = cards.filter { $0.insulin != nil && Calendar.current.isDateInToday($0.creationTime) }.count
        return min(CGFloat(count) / 3.0, 1.0)
    }

    var bloodProgress: CGFloat {
        let count = cards.filter { $0.bloodSugar != nil && Calendar.current.isDateInToday($0.creationTime) }.count
        return min(CGFloat(count) / 3.0, 1.0)
    }

    var foodProgress: CGFloat {
        let count = cards.filter { $0.breadUnits != nil && Calendar.current.isDateInToday($0.creationTime) }.count
        return min(CGFloat(count) / 3.0, 1.0)
    }

    func addCard(card: MealCardModel) {
        allCards.append(card)

        if Calendar.current.isDateInToday(card.creationTime) {
            cards.append(card)
        }
    }

    func deleteCard(_ card: MealCardModel) {
        if let index = allCards.firstIndex(where: { $0.id == card.id }) {
            allCards.remove(at: index)
        }

        if let todayIndex = cards.firstIndex(where: { $0.id == card.id }) {
            cards.remove(at: todayIndex)
        }
    }

    func updateTodaysCards() {
        cards = allCards.filter { Calendar.current.isDateInToday($0.creationTime) }
    }

    private func setupMidnightUpdater() {
        let currentCalendar = Calendar.current
        let now = Date()
        let midnight = currentCalendar.startOfDay(for: now)
        let nextMidnight = currentCalendar.date(byAdding: .day, value: 1, to: midnight)!

        midnightUpdater = Timer(fireAt: nextMidnight, interval: 0, target: self, selector: #selector(midnightUpdate), userInfo: nil, repeats: false)

        RunLoop.main.add(midnightUpdater!, forMode: .common)
    }

    @objc func midnightUpdate() {
        updateTodaysCards()

        setupMidnightUpdater()
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

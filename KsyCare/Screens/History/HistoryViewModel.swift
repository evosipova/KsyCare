import SwiftUI

class HistoryViewModel: ObservableObject {
    @Published var selectedMonth = Date()
    @EnvironmentObject var mealCardsData: MealCardViewModel

    private let calendar = Calendar.current
    private let historyModel = HistoryModel()

    var dateFormatter: DateFormatter {
        historyModel.dateFormatter
    }

    func incrementMonth(by value: Int) {
        if let newMonth = calendar.date(byAdding: .month, value: value, to: selectedMonth) {
            selectedMonth = newMonth
        }
    }

    func filterCardsByMonth() -> [Date: [MealCardModel]] {
        let filteredCards = mealCardsData.allCards.filter {
            calendar.isDate($0.creationTime, equalTo: selectedMonth, toGranularity: .month)
        }
        return mealCardsData.cardsGroupedByDate(from: filteredCards)
    }

    func headerView(for date: Date) -> String {
        historyModel.dateFormatter.string(from: date)
    }

    func itemFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter
    }
}

extension Calendar {
    func startOfMonth(for date: Date) -> Date {
        let components = dateComponents([.year, .month], from: date)
        return self.date(from: components)!
    }

    func endOfMonth(for date: Date) -> Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return self.date(byAdding: components, to: startOfMonth(for: date))!
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

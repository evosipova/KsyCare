import Foundation

class MealCardsData: ObservableObject {
    @Published var cards: [MealCardModel] = []
}


struct MealCardModel {
    let id: UUID = UUID() 
    var mealTime: String
    var creationTime: Date
    var bloodSugar: Double?
    var breadUnits: Double?
    var insulin: Double?
    var comments: String?
}

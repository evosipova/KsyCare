import Foundation

struct MealCardModel: Identifiable {
    let id: UUID = UUID() 
    var mealTime: String
    var creationTime: Date
    var bloodSugar: Double?
    var breadUnits: Double?
    var insulin: Double?
    var comments: String?
}

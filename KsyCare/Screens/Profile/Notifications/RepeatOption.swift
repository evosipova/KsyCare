import Foundation
import SwiftUI

enum RepeatOption: String, CaseIterable {
    case never = "Без повтора"
    case daily = "Каждый день"
    case everyMonday = "Каждый понедельник"
    case everyTuesday = "Каждый вторник"
    case everyWednesday = "Каждую среду"
    case everyThursday = "Каждый четверг"
    case everyFriday = "Каждую пятницу"
    case everySaturday = "Каждую субботу"
    case everySunday = "Каждое воскресенье"
}

extension RepeatOption {
    var weekday: Int {
        switch self {
        case .everyMonday: return 2
        case .everyTuesday: return 3
        case .everyWednesday: return 4
        case .everyThursday: return 5
        case .everyFriday: return 6
        case .everySaturday: return 7
        case .everySunday: return 1
        default: return 0
        }
    }
}

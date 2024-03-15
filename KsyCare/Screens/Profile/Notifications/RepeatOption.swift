import Foundation
import SwiftUI

enum RepeatOption: String, CaseIterable {
    case never = "Без повтора"
    case daily = "Каждый день"
    case weekly = "Каждую неделю"
    case everyMonday = "Каждый понедельник"
    case everyTuesday = "Каждый вторник"
    case everyWednesday = "Каждую среду"
    case everyThursday = "Каждый четверг"
    case everyFriday = "Каждую пятницу"
    case everySaturday = "Каждую субботу"
    case everySunday = "Каждое воскресенье"
}

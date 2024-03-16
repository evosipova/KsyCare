import SwiftUI

struct NotificationModel: Hashable, Identifiable {
    let id = UUID() 
    var title: String
    var time: Date
    var repeatOption: RepeatOption
}

import Foundation
import UserNotifications

class NotificationsViewModel: ObservableObject {
    @Published var showingAddNotificationsPopup: Bool = false
    @Published var notifications: [NotificationModel] = []

    func addNotification(title: String, time: Date, repeatOption: RepeatOption) {
        let newNotification = NotificationModel(title: title, time: time, repeatOption: repeatOption)
        notifications.append(newNotification)
        scheduleNotification(for: newNotification)
    }

    func scheduleNotification(for model: NotificationModel) {
        let content = UNMutableNotificationContent()
        content.title = "Напоминание"
        content.body = model.title
        content.sound = .default

        var dateComponents = Calendar.current.dateComponents([.hour, .minute], from: model.time)

        switch model.repeatOption {
        case .daily:
            break
        case .everyMonday, .everyTuesday, .everyWednesday, .everyThursday, .everyFriday, .everySaturday, .everySunday:
            let weekday = model.repeatOption.weekday
            dateComponents.weekday = weekday
        case .never:
            break
        }

        let trigger: UNNotificationTrigger
        if model.repeatOption == .never {
            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        } else {
            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        }

        let request = UNNotificationRequest(identifier: model.id.uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(" \(error.localizedDescription)")
            }
        }
    }

    func deleteNotification(_ model: NotificationModel) {
        notifications.removeAll { $0.id == model.id }
    }

    func updateNotification(_ model: NotificationModel, title: String, time: Date, repeatOption: RepeatOption) {
        if let index = notifications.firstIndex(where: { $0.id == model.id }) {
            notifications[index].title = title
            notifications[index].time = time
            notifications[index].repeatOption = repeatOption

            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [model.id.uuidString])

            scheduleNotification(for: notifications[index])
        }
    }
}

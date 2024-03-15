import Foundation

class NotificationsViewModel: ObservableObject {
    @Published var showingAddNotificationsPopup: Bool = false
    @Published var notifications: [NotificationModel] = [
        NotificationModel(title: "Название напоминания", time: "12:30", repeatInterval: "Каждый день"),
    ]

    func addNotification(notification: NotificationModel) {
        notifications.append(notification)
    }
}

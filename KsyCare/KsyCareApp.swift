import SwiftUI

@main
struct KsyCareApp: App {
    var viewModel = MealCardViewModel()
    private let notificationDelegate = NotificationDelegate()

    var body: some Scene {
        WindowGroup {
            ScreensaverView()
                .environmentObject(viewModel)
        }
    }

    init() {
        UNUserNotificationCenter.current().delegate = notificationDelegate
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else if let error = error {
                debugPrint("\(error.localizedDescription)")
            }
        }
    }
}

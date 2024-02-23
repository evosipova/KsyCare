import SwiftUI

@main
struct KsyCareApp: App {
    var viewModel = MealCardViewModel()

    var body: some Scene {
        WindowGroup {
           ScreensaverView()
                .environmentObject(viewModel)
        }
    }
}

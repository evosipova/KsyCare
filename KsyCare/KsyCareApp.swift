import SwiftUI

@main
struct KsyCareApp: App {
    var mealCardsData = MealCardsData()

    var body: some Scene {
        WindowGroup {
           ScreensaverView()
                .environmentObject(mealCardsData)
        }
    }
}

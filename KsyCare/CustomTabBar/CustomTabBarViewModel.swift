import Foundation

class CustomTabBarViewModel: ObservableObject {
    @Published var selectedTab: Int = 0
    @Published var showingAddNotePopup: Bool = false
}

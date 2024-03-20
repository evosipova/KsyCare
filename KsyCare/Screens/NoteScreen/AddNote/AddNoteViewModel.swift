import SwiftUI

class AddNoteViewModel: ObservableObject {
    @Published var showingFoodView = false
    @Published var showingBloodSugarView = false
    @Published var showingInsulinView = false
    @Published var showingCombinedView = false

    func getButtons() -> [ButtonInfo] {
        [
            ButtonInfo(title: "Еда", imageName: "foodPlus-pdf", showingView: Binding(get: { self.showingFoodView }, set: { self.showingFoodView = $0 }), destinationView: AnyView(FoodView())),
            ButtonInfo(title: "Сахар крови", imageName: "bloodPlus-pdf", showingView: Binding(get: { self.showingBloodSugarView }, set: { self.showingBloodSugarView = $0 }), destinationView: AnyView(BloodSugarView())),
            ButtonInfo(title: "Инсулин", imageName: "insulinPlus-pdf", showingView: Binding(get: { self.showingInsulinView }, set: { self.showingInsulinView = $0 }), destinationView: AnyView(InsulinView())),
            ButtonInfo(title: "Еда, Сахар крови, Инсулин", imageName: "mainPlus-pdf", showingView: Binding(get: { self.showingCombinedView }, set: { self.showingCombinedView = $0 }), destinationView: AnyView(CombinedView()))
        ]
    }

    struct ButtonInfo {
        let title: String
        let imageName: String
        let showingView: Binding<Bool>
        let destinationView: AnyView
    }
}

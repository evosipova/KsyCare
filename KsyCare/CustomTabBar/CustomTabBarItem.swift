import SwiftUI

struct CustomTabBarItem: View {
    let iconName: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: iconName)
                    .font(.system(size: 28))
                    .foregroundColor(isSelected ? .blue : .gray)
            }
        }
    }
}

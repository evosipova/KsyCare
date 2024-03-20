import SwiftUI

struct CustomTabBarItem: View {
    let iconName: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                if iconName == "plus.circle.fill" {
                    Image(systemName: iconName)
                        .font(.system(size: 45))
                        .foregroundColor(isSelected ? Color("58EEE5") : Color("CCF6FF"))
                } else {
                    Image(iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 28, height: 28)
                        .foregroundColor(isSelected ? Color("58EEE5") : Color("CCF6FF"))
                }
            }
        }
    }
}

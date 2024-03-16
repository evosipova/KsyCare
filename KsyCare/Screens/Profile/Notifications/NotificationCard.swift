import SwiftUI

struct NotificationCard: View {
    let title: String
    let time: String
    let repeatInterval: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(repeatInterval)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(time)
                .font(.headline)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

#Preview {
    NotificationCard(title: "Название", time: "10:40", repeatInterval: "Без повтора")
}

import SwiftUI

struct NotificationCard: View {
    let title: String
    let time: String
    let repeatInterval: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .foregroundColor(Color("lightDetail"))
                    .font(.headline)
                Text(repeatInterval)
                    .font(.subheadline)
                    .foregroundColor(Color("additionalDetail"))
            }
            Spacer()
            Text(time)
                .font(.headline)
                .foregroundColor(Color("lightDetail"))
        }
        .padding()
        .background(Color("notificationCard"))
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

#Preview {
    NotificationCard(title: "Название", time: "10:40", repeatInterval: "Без повтора")
}

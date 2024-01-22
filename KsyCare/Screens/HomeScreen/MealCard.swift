import SwiftUI

struct MealCard: View {
    var mealTime: String
    var creationTime: Date
    var bloodSugar: Double
    var breadUnits: Double
    var insulin: Double
    var comments: String?

    private var creationTimeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm"
        return formatter.string(from: creationTime)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Text(mealTime)
                    .font(.headline)
                Spacer()
                Text(creationTimeString)
            }
            .padding(.top, 5)


            Divider()
                .background(.gray)

            HStack {
                Image(systemName: "1.square.fill")
                Text("Сахар крови")
                Spacer()
                Text("\(bloodSugar, specifier: "%.2f")")
            }

            HStack {
                Image(systemName: "2.square.fill")
                Text("ХЕ")
                Spacer()
                Text("\(breadUnits, specifier: "%.2f")")
            }

            HStack {
                Image(systemName: "3.square.fill")
                Text("Инсулин")
                Spacer()
                Text("\(insulin, specifier: "%.2f")")
            }

            if let comments = comments, !comments.isEmpty {
                Divider()
                    .background(.gray)
                Text(comments)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 0)
    }
}

struct MealCard_Previews: PreviewProvider {
    static var previews: some View {
        MealCard(mealTime: "Обед", creationTime: Date(), bloodSugar: 5, breadUnits: 5.4, insulin: 3, comments: "Все хорошо!")
            .padding(.horizontal, 10)
    }
}

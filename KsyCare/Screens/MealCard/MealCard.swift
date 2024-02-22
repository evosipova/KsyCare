import SwiftUI

struct MealCard: View {
    var card: MealCardModel
    
    private var creationTimeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm"
        return formatter.string(from: card.creationTime)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Text(card.mealTime)
                    .font(.headline)
                Spacer()
                Text(creationTimeString)
            }
            .padding(.top, 5)
            
            Divider()
                .background(.gray)
            
            if let bloodSugar = card.bloodSugar {
                HStack {
                    Image(systemName: "circle.fill")
                    Text("Сахар крови")
                    Spacer()
                    Text("\(bloodSugar, specifier: "%.2f")")
                }
            }
            
            if let breadUnits = card.breadUnits {
                HStack {
                    Image(systemName: "circle.fill")
                    Text("ХЕ")
                    Spacer()
                    Text("\(breadUnits, specifier: "%.2f")")
                }
            }
            
            if let insulin = card.insulin {
                HStack {
                    Image(systemName: "circle.fill")
                    Text("Инсулин")
                    Spacer()
                    Text("\(insulin, specifier: "%.2f")")
                }
            }
            
            if let comments = card.comments, !comments.isEmpty { 
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
        MealCard(card: MealCardModel(mealTime: "Обед", creationTime: Date(), bloodSugar: 5, breadUnits: 5.4, insulin: 3, comments: "Все хорошо!"))
            .padding(.horizontal, 10)
    }
}

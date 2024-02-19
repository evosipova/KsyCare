import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Добрый день!")
                        .font(.custom("Amiko", size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .padding(.top, 57)
                        .padding(.leading, 27)
                    Spacer()
                }
                .padding(.bottom, 38)
                
                Circle()
                    .stroke(Color.gray, lineWidth: 60)
                    .frame(width: 214, height: 214)
                    .padding(.bottom, 45)

                VStack {
                    Text("Сегодня")
                        .font(.custom("Amiko", size: 24))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 20)

                    
                    MealCard(mealTime: "Обед", creationTime: Date(), bloodSugar: 5, breadUnits: 5.4, insulin: 3, comments: "Все хорошо!")
                        .padding(.horizontal, 10)

                    MealCard(mealTime: "Ужин", creationTime: Date(), bloodSugar: 5, breadUnits: 5.4, insulin: 3)
                        .padding(.horizontal, 10)

                    MealCard(mealTime: "Обед", creationTime: Date(), bloodSugar: 5, comments: "Все хорошо!")
                        .padding(.horizontal, 10)
                }
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            }
        }
        .frame(maxHeight: .infinity)
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.gray.opacity(0.1))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

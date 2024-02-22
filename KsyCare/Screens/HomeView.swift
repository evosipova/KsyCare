import SwiftUI

struct HomeView: View {
    @EnvironmentObject var mealCardsData: MealCardsData
    
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
                    
                    
                    ForEach(mealCardsData.cards.indices, id: \.self) { index in
                        MealCard(card: mealCardsData.cards[index])
                            .padding(.bottom, 10)
                            .padding(.horizontal)
                    }
                    
                    
                }
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            }
            .padding(.bottom, 100)
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

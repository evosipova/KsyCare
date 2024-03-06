import SwiftUI

struct HomeView: View {
    @EnvironmentObject var mealCardsData: MealCardViewModel

    private var todaysCards: [MealCardModel] {
         mealCardsData.allCards.filter { Calendar.current.isDateInToday($0.creationTime) }
     }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                greetingSection
                circleSection
                todaySection
            }
            .padding(.bottom, 10)
        }
        .frame(maxHeight: .infinity)
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.gray.opacity(0.1))
    }

    private var greetingSection: some View {
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
    }

    private var circleSection: some View {
        Circle()
            .stroke(Color.gray, lineWidth: 60)
            .frame(width: 214, height: 214)
            .padding(.bottom, 45)
    }

    private var todaySection: some View {
        VStack {
            Text("Сегодня")
                .font(.custom("Amiko", size: 24))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 20)

            ForEach(mealCardsData.cards, id: \.id) { card in
                MealCard(viewModel: mealCardsData, card: card)
                    .padding(.bottom, 10)
                    .padding(.horizontal)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(MealCardViewModel())
    }
}

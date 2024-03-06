import SwiftUI

struct HomeView: View {
    @EnvironmentObject var mealCardsData: MealCardViewModel
    @State private var lastCheckedDate = Date()

    private var todaysCards: [MealCardModel] {
        mealCardsData.allCards.filter { Calendar.current.isDateInToday($0.creationTime) }
    }

    var body: some View {
        ScrollView {
            VStack() {
                circleSection
                todaySection
            }
            .padding(.top, 30)
        }
        .frame(maxHeight: .infinity)
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.gray.opacity(0.1))
        .onAppear {
            setUpTimer()
        }
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

    private func setUpTimer() {
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { timer in
            let currentDate = Date()
            if !Calendar.current.isDate(lastCheckedDate, inSameDayAs: currentDate) {
                mealCardsData.updateTodaysCards()
                lastCheckedDate = currentDate
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(MealCardViewModel())
    }
}

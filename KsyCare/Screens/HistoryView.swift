import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var mealCardsData: MealCardViewModel
    var body: some View {


        ScrollView {
            VStack() {
                headingSection
                filterSection
                cardsSection
            }
            .padding(.bottom, 10)
        }
        .frame(maxHeight: .infinity)
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.gray.opacity(0.1))
    }

    private var headingSection: some View {
        HStack {
            Text("История")
                .font(.system(size: 24, weight: .bold))
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .padding(.leading, 27)
            Spacer()
        }
    }

    private var filterSection: some View {
        HStack {
            Rectangle()
                .background(Color.red)
        }
    }

    private var cardsSection: some View {
        let groupedCards = mealCardsData.cardsGroupedByDate(from: mealCardsData.allCards)
        return VStack {
            ForEach(groupedCards.keys.sorted(), id: \.self) { date in
                let cardsForDate = groupedCards[date]!
                Section(header: Text("\(date, formatter: itemFormatter)")) {
                    ForEach(cardsForDate, id: \.id) { card in
                        MealCard(viewModel: mealCardsData, card: card)
                            .padding(.bottom, 10)
                            .padding(.horizontal)
                    }
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }

    private var itemFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }

}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView().environmentObject(MealCardViewModel())
    }
}

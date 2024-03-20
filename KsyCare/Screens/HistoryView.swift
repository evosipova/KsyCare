import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var mealCardsData: MealCardViewModel
    @State private var selectedMonth = Date()

    let calendar = Calendar.current
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "LLLL yyyy"
        return formatter
    }()

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.349, green: 0.624, blue: 0.859),
                                                           Color(red: 0.8, green: 0.965, blue: 1),
                                                           Color(red: 0.948, green: 0.992, blue: 0.985)
                                                          ]),
                               startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

                if mealCardsData.allCards.isEmpty {
                    ScrollView {
                        VStack {
                            headingSection
                                .padding(.bottom, 171)
                            Spacer()
                            Image("noRecord-pdf")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 250, height: 250)
                                .foregroundColor(Color("5AA0DB"))

                            Text("Нет записей")
                                .font(.system(size: 24))
                                .foregroundColor(Color("2A2931"))
                        }
                    }
                } else {
                    ScrollView {
                        VStack {
                            headingSection
                            filterSection
                            cardsSection
                        }
                    }
                }
            }
        }
        .padding(.bottom, 80)
        .navigationBarHidden(true)
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
        HStack() {
            Spacer()

            Button(action: {
                if let newMonth = calendar.date(byAdding: .month, value: -1, to: selectedMonth) {
                    selectedMonth = newMonth
                }
            }) {
                Image(systemName: "arrowshape.left.fill")
                    .foregroundColor(Color("4579A5-B5E3EE"))
                    .font(.largeTitle)
            }
            .padding([.leading, .trailing], 0)

            Text(dateFormatter.string(from: selectedMonth).capitalizingFirstLetter())
                .lineLimit(1)

                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                .font(.largeTitle)
                .foregroundColor(Color("2A2931-CCF6FF"))
                .padding()

            Button(action: {
                if let newMonth = calendar.date(byAdding: .month, value: 1, to: selectedMonth) {
                    selectedMonth = newMonth
                }
            }) {
                Image(systemName: "arrowshape.right.fill")
                    .foregroundColor(Color("4579A5-B5E3EE"))
                    .font(.largeTitle)
            }
            .padding([.leading, .trailing], 0)

            Spacer()
        }
        .padding()
    }

    private var cardsSection: some View {
        let filteredCards = mealCardsData.allCards.filter {
            Calendar.current.isDate($0.creationTime, equalTo: selectedMonth, toGranularity: .month)
        }
        let groupedCards = mealCardsData.cardsGroupedByDate(from: filteredCards)

        return VStack {
            ForEach(groupedCards.keys.sorted(), id: \.self) { month in
                let cardsForMonth = groupedCards[month]!
                Section(header: headerView(for: month)) {
                    ForEach(cardsForMonth, id: \.id) { card in
                        NavigationLink(destination: MealCardDetailView(card: card)) {
                            MealCardView(viewModel: mealCardsData, card: card)
                                .padding(.bottom, 10)
                                .padding(.horizontal)
                        }
                    }
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }

    private func filterCardsByMonth(cards: [MealCardModel], month: Date) -> [Date: [MealCardModel]] {
        let calendar = Calendar.current
        let startOfMonth = calendar.startOfMonth(for: month)
        let endOfMonth = calendar.endOfMonth(for: month)

        let filteredCards = cards.filter {
            $0.creationTime >= startOfMonth && $0.creationTime <= endOfMonth
        }

        return mealCardsData.cardsGroupedByDate(from: filteredCards)
    }

    private func headerView(for date: Date) -> some View {
        Text(date, formatter: itemFormatter)
            .font(.custom("Amiko-Bold", size: 18))
            .frame(height: 24)
            .padding(.leading, 27)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var itemFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter
    }
}

extension Calendar {
    func startOfMonth(for date: Date) -> Date {
        let components = dateComponents([.year, .month], from: date)
        return self.date(from: components)!
    }

    func endOfMonth(for date: Date) -> Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return self.date(byAdding: components, to: startOfMonth(for: date))!
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView().environmentObject(MealCardViewModel())
    }
}

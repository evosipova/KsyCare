import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var mealCardsData: MealCardViewModel
    @StateObject private var viewModel = HistoryViewModel()

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
                .accessibilityHint("Экран")
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
                viewModel.incrementMonth(by: -1)
            }) {
                Image(systemName: "arrowshape.left.fill")
                    .foregroundColor(Color("4579A5-B5E3EE"))
                    .font(.largeTitle)
                    .accessibilityLabel("Предыдущий месяц")
            }
            .padding([.leading, .trailing], 0)

            Text(viewModel.dateFormatter.string(from: viewModel.selectedMonth).capitalizingFirstLetter())
                .lineLimit(1)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                .font(.largeTitle)
                .foregroundColor(Color("2A2931-CCF6FF"))
                .padding()

            Button(action: {
                viewModel.incrementMonth(by: 1)
            }) {
                Image(systemName: "arrowshape.right.fill")
                    .foregroundColor(Color("4579A5-B5E3EE"))
                    .font(.largeTitle)
                    .accessibilityLabel("Следующий месяц")
            }
            .padding([.leading, .trailing], 0)

            Spacer()
        }
        .padding()
    }

    private var cardsSection: some View {
        let groupedCards = viewModel.filterCardsByMonth()

        return VStack {
            ForEach(groupedCards.keys.sorted(), id: \.self) { month in
                let cardsForMonth = groupedCards[month]!
                Section(header: Text(viewModel.headerView(for: month)).font(.custom("Amiko-Bold", size: 18)).frame(height: 24).padding(.leading, 27).frame(maxWidth: .infinity, alignment: .leading)) {
                    ForEach(cardsForMonth, id: \.id) { card in
                        NavigationLink(destination: MealCardDetailView(card: card)) {
                            MealCardView(viewModel: mealCardsData, card: card)
                                .padding(.bottom, 10)
                                .padding(.horizontal, 20)
                        }
                    }
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView().environmentObject(MealCardViewModel())
    }
}

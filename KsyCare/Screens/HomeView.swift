import SwiftUI

struct HomeView: View {
    @EnvironmentObject var mealCardsData: MealCardViewModel
    @State private var lastCheckedDate = Date()

    @State private var showingDetail = false
    @State private var selectedCard: MealCardModel?

    private var todaysCards: [MealCardModel] {
        mealCardsData.allCards.filter { Calendar.current.isDateInToday($0.creationTime) }
    }

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.349, green: 0.624, blue: 0.859),
                                                           Color(red: 0.8, green: 0.965, blue: 1),
                                                           Color(red: 0.948, green: 0.992, blue: 0.985)

                                                          ]),
                               startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

                if todaysCards.isEmpty {
                    ScrollView {
                        VStack {
                            Spacer()
                            Image("noRecord-pdf")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 250, height: 250)
                                .foregroundColor(Color("5AA0DB"))
                                .accessibilityLabel("Нет записей")
                                .accessibilityHint("Изображение")

                            Text("Нет записей")
                                .font(.system(size: 24))
                                .foregroundColor(Color("2A2931"))
                        }
                        .padding(.top, 200)
                    }
                } else {
                    ScrollView {
                        VStack {
                            circleSection
                                .padding(.top, 10)
                            todaySection
                        }
                    }
                }
            }
            .onAppear {
                setUpTimer()
            }
        }
        .padding(.bottom, 80)
        .navigationBarHidden(true)
    }

    private var circleSection: some View {
        ZStack {
            RingView(progress: mealCardsData.insulinProgress, color: Color("58EEE5"))
                .frame(width: 214, height: 214)

            RingView(progress: mealCardsData.bloodProgress, color: Color("2BBEBE"))
                .frame(width: 174, height: 174)

            RingView(progress: mealCardsData.foodProgress, color: Color("ABF1ED"))
                .frame(width: 134, height: 134)

            Image(systemName: "heart")
                .font(.system(size: 60))
                .foregroundColor(Color("58EEE5"))
        }
        .padding(.bottom, 20)
    }

    private var todaySection: some View {
        VStack {
            Text("Сегодня")
                .font(.custom("Amiko", size: 24))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 20)

            ForEach(mealCardsData.cards, id: \.id) { card in
                Button(action: {
                    self.selectedCard = card
                    self.showingDetail = true
                }) {
                    MealCardView(viewModel: mealCardsData, card: card)
                        .padding(.bottom, 10)
                        .padding(.horizontal, 20)
                }
            }
            .fullScreenCover(item: $selectedCard) { card in
                MealCardDetailView(card: card)
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

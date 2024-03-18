import SwiftUI

struct HomeView: View {
    @EnvironmentObject var mealCardsData: MealCardViewModel
    @State private var lastCheckedDate = Date()
    
    private var todaysCards: [MealCardModel] {
        mealCardsData.allCards.filter { Calendar.current.isDateInToday($0.creationTime) }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.349, green: 0.624, blue: 0.859),
                                                           Color(red: 0.549, green: 0.832, blue: 0.921),
                                                           Color(red: 0.8, green: 0.965, blue: 1)
                                                          ]),
                               startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                
                if todaysCards.isEmpty {
                    Text("пока нет записей :(")
                } else {
                    ScrollView {
                        VStack {
                            circleSection
                                .padding(.top, 15)
                            todaySection
                        }
                    }
                }
            }
            .onAppear {
                setUpTimer()
            }
        }
        .navigationBarHidden(true)
    }
    
    private var circleSection: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .frame(width: 214, height: 214)
                .foregroundColor(mealCardsData.hasInsulinInfoToday ? .blue : Color.gray.opacity(0.5))
            Circle()
                .stroke(lineWidth: 10)
                .frame(width: 174, height: 174)
                .foregroundColor(mealCardsData.hasBloodInfoToday ? .red : Color.gray.opacity(0.5))
            Circle()
                .stroke(lineWidth: 10)
                .frame(width: 134, height: 134)
                .foregroundColor(mealCardsData.hasFoodInfoToday ? Color("FoodColor") : Color.gray.opacity(0.5))
            Image(systemName: "heart.fill")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
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
                NavigationLink(destination: MealCardDetailView(card: card)) {
                    MealCardView(viewModel: mealCardsData, card: card)
                        .padding(.bottom, 10)
                        .padding(.horizontal)
                }
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

extension MealCardViewModel {
    var hasInsulinInfoToday: Bool {
        cards.contains { $0.insulin != nil }
    }
    
    var hasBloodInfoToday: Bool {
        cards.contains { $0.bloodSugar != nil }
    }
    
    var hasFoodInfoToday: Bool {
        cards.contains { $0.breadUnits != nil }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(MealCardViewModel())
    }
}

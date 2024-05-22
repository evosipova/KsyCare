import SwiftUI

struct StatisticsView: View {
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
        ScrollView {
            
            VStack {
                headingSection
                
                filterSection
                
                LineChartView(data: insulinDataForChart(month: selectedMonth),
                              title: "Инсулин",
                              form: ChartForm.large, rateValue: calculateRateValue(data: insulinDataForChart(month: selectedMonth)))
                
                Spacer()
                    .padding(.top, 20)
                
                LineChartView(data: bloodSugarDataForChart(month: selectedMonth),
                              title: "Кровь",
                              form: ChartForm.large,
                              rateValue: calculateRateValue(data: bloodSugarDataForChart(month: selectedMonth)))
            }
            
        }
        .background(            LinearGradient(gradient: Gradient(colors: [Color(red: 0.349, green: 0.624, blue: 0.859),
                                                                           Color(red: 0.8, green: 0.965, blue: 1),
                                                                           Color(red: 0.948, green: 0.992, blue: 0.985)]),
                                               startPoint: .top, endPoint: .bottom)
        )
        .navigationTitle("Статистика")
    }
    
    private var headingSection: some View {
        HStack {
            Text("Статистика")
                .accessibilityHint("Экран")
                .font(.system(size: 24, weight: .bold))
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .padding(.leading, 27)
            Spacer()
        }
    }
    
    private func calculateRateValue(data: [Double]) -> Int? {
        guard data.count >= 2 else { return nil }
        let lastValue = data.last!
        let secondLastValue = data[data.count - 2]
        
        if secondLastValue == 0 {
            return lastValue == 0 ? 0 : nil
        } else {
            let rateChange = (lastValue - secondLastValue) / secondLastValue
            return Int(rateChange * 100)
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
                    .accessibilityLabel("Предыдущий месяц")
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
                    .accessibilityLabel("Следующий месяц")
            }
            .padding([.leading, .trailing], 0)
            
            Spacer()
        }
        .padding()
    }
    
    private func insulinDataForChart(month: Date) -> [Double] {
        let sortedInsulinData = mealCardsData.allCards
            .filter { calendar.isDate($0.creationTime, equalTo: month, toGranularity: .month) }
            .sorted(by: { $0.creationTime < $1.creationTime })
            .compactMap { $0.insulin }
        return sortedInsulinData.isEmpty ? [0.0] : sortedInsulinData
    }
    
    private func bloodSugarDataForChart(month: Date) -> [Double] {
        let sortedBloodSugarData = mealCardsData.allCards
            .filter { calendar.isDate($0.creationTime, equalTo: month, toGranularity: .month) }
            .sorted(by: { $0.creationTime < $1.creationTime }) 
            .compactMap { $0.bloodSugar }
        return sortedBloodSugarData.isEmpty ? [0.0] : sortedBloodSugarData
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView().environmentObject(MealCardViewModel())
    }
}

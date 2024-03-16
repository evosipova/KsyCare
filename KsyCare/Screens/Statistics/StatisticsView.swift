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
                filterSection

                LineChartView(data: insulinDataForChart(month: selectedMonth),
                              title: "Инсулин",
                              form: ChartForm.large, rateValue: calculateRateValue(data: insulinDataForChart(month: selectedMonth)))
                .frame(maxWidth: .infinity)

                LineChartView(data: bloodSugarDataForChart(month: selectedMonth),
                              title: "Кровь",
                              form: ChartForm.large, rateValue: calculateRateValue(data: bloodSugarDataForChart(month: selectedMonth)))
                .frame(maxWidth: .infinity)
            }
        }
        .background(Color("Test"))
        .navigationTitle("Статистика")
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
        HStack(alignment: .center) {
            Spacer()
                .padding()

            Button(action: {
                if let newMonth = calendar.date(byAdding: .month, value: -1, to: selectedMonth) {
                    selectedMonth = newMonth
                }
            }) {
                Image(systemName: "chevron.left")
            }

            Text(dateFormatter.string(from: selectedMonth).capitalizingFirstLetter())
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)

            Button(action: {
                if let newMonth = calendar.date(byAdding: .month, value: 1, to: selectedMonth) {
                    selectedMonth = newMonth
                }
            }) {
                Image(systemName: "chevron.right")
            }
            Spacer()
                .padding()
        }
        .padding()
    }

    private func insulinDataForChart(month: Date) -> [Double] {
        let insulinData = mealCardsData.allCards
            .filter { calendar.isDate($0.creationTime, equalTo: month, toGranularity: .month) }
            .compactMap { $0.insulin }
        return insulinData.isEmpty ? [0.0] : insulinData
    }

    private func bloodSugarDataForChart(month: Date) -> [Double] {
        let bloodSugarData = mealCardsData.allCards
            .filter { calendar.isDate($0.creationTime, equalTo: month, toGranularity: .month) }
            .compactMap { $0.bloodSugar }
        return bloodSugarData.isEmpty ? [0.0] : bloodSugarData
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView().environmentObject(MealCardViewModel())
    }
}

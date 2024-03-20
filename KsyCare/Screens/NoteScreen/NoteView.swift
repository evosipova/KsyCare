import SwiftUI

struct NoteView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String = ""
    @State private var comments: String = ""
    @State private var selectedDate = Date()
    @State private var isShowingDatePicker = false
    @State private var showingNavigationBarView = false
    
    @EnvironmentObject var mealCardsData: MealCardViewModel
    @Binding var selectedSugarLevel: Double
    
    let displayText: String
    var cardType: CardType
    
    var body: some View {
        NavigationStack {
            
            ZStack(alignment: .bottom) {
                content
                
                VStack {
                    doneButton
                }
                .padding(.bottom, 30)
            }
            .background(Color("F1FDFB-365E7A"))
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true)
            .environment(\.locale, Locale(identifier: "ru_RU"))
        }
    }
    
    private var content: some View {
        ScrollView {
            VStack() {
                header
                titleField
                datePickerSection
                Spacer()
                commentField
            }
            Spacer()
        }
    }
    
    private var header: some View {
        VStack {
            HStack {
                backButton
                Spacer()
                twoRectangles
                Spacer()
                Rectangle().foregroundColor(.clear).frame(width: 33, height: 26)
            }
            .padding()
            
            HStack {
                Text(displayText)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color("4579A5-B5E3EE"))
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
    
    private var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 13, height: 26)
                .foregroundColor(Color("4579A5-B5E3EE"))
        }
        .padding(.leading, 8)
    }
    
    private var twoRectangles: some View {
        HStack {
            ForEach(0..<2) { _ in
                Rectangle()
                    .frame(width: 50, height: 5)
                    .cornerRadius(2.5)
                    .foregroundColor(Color("rectanglesStroke"))
            }
        }
    }
    
    private var titleField: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Заголовок")
                .foregroundColor(Color("2A2931-CCF6FF"))
                .font(.system(size: 20))
                .padding(.leading, 20)
            
            TextField("", text: $title, prompt: Text("Без заголовка")
                .foregroundColor(Color("7A9DA8")))
            .padding()
            .background(Color("CCF6FF"))
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("B6E4EF-548493"), lineWidth: 2)
            )
            .padding(.horizontal, 20)
        }
        .padding(.top, 10)
    }
    
    private var datePickerSection: some View {
        HStack() {
            Text("Дата и время")
                .foregroundColor(Color("2A2931-CCF6FF"))
                .font(.system(size: 20))
            
            Spacer()
            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(CompactDatePickerStyle())
                .labelsHidden()
                .foregroundColor(Color("2A2931-CCF6FF"))
                .accentColor(Color("2A2931-CCF6FF"))
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("B6E4EF-548493"), lineWidth: 2)
                )
            
            DatePicker("", selection: $selectedDate, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .foregroundColor(Color("2A2931-CCF6FF"))
                .accentColor(Color("2A2931-CCF6FF"))
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("B6E4EF-548493"), lineWidth: 2)
                    
                )
        }
        .padding(.top, 10)
        .padding(.horizontal, 20)
    }
    
    private var datePickerButton: some View {
        Button(action: {
            self.isShowingDatePicker.toggle()
        }) {
            HStack {
                Text(selectedDate, style: .date)
                Text(selectedDate, style: .time)
                Spacer()
                Image(systemName: "calendar")
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(5)
    }
    
    private var commentField: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Комментарий")
                .font(.system(size: 20))
                .padding(.leading, 20)
                .foregroundColor(Color("2A2931-CCF6FF"))
            
            TextField("", text: $comments, prompt: Text("Введи комментарий")
                .foregroundColor(Color("7A9DA8")))
            .padding()
            .background(Color("CCF6FF"))
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("B6E4EF-548493"), lineWidth: 2)
            )
            .padding(.horizontal, 20)
            .padding(.bottom, 100)
        }
        .padding(.top, 10)
    }
    
    private var doneButton: some View {
        Button(action: {
            let newCard: MealCardModel
            switch cardType {
            case .bloodSugar:
                newCard = MealCardModel(mealTime: title, creationTime: selectedDate, bloodSugar: selectedSugarLevel, comments: comments)
            case .insulin:
                newCard = MealCardModel(mealTime: title, creationTime: selectedDate, insulin: selectedSugarLevel, comments: comments)
            }
            mealCardsData.addCard(card: newCard)
            showingNavigationBarView = true
        }) {
            Text("Готово").frame(minWidth: 0, maxWidth: .infinity).padding().contentShape(Rectangle())
        }
        .foregroundColor(Color("2A2931-CCF6FF"))
        .background(Color("58EEE5-27D8CD"))
        .cornerRadius(10)
        .padding(.horizontal, 20)
        .fullScreenCover(isPresented: $showingNavigationBarView) {
            CustomTabBarView(viewModel: CustomTabBarViewModel())
        }
    }
    
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(selectedSugarLevel: .constant(5.0), displayText: "Сахар крови", cardType: .bloodSugar).environmentObject(MealCardViewModel())
    }
}


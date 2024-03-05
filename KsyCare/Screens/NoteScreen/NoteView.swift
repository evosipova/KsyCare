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
                doubleRectangle
                Spacer()
                Rectangle().foregroundColor(.clear).frame(width: 33, height: 26)
            }
            .padding()

            HStack {
                Text(displayText)
                    .font(.system(size: 24, weight: .bold))
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
        }
        .padding(.leading, 13)
    }

    private var doubleRectangle: some View {
        HStack {
            Rectangle().frame(width: 50, height: 5).cornerRadius(5).foregroundColor(.blue)
            Rectangle().frame(width: 50, height: 5).cornerRadius(5).foregroundColor(.blue)
        }
    }

    private var titleField: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Заголовок").font(.system(size: 20)).padding(.leading, 20)
            TextField("Без зоголовка", text: $title)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
                .padding(.horizontal, 20)
        }
        .padding(.top, 10)
    }

    private var datePickerSection: some View {
        HStack {
            Text("Дата и время")
                .font(.system(size: 20))
                .frame(width: 150, alignment: .leading)

           Spacer(minLength: 20)

            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                   .datePickerStyle(.compact)
                   .frame(width: 120, alignment: .trailing)

            DatePicker("", selection: $selectedDate, displayedComponents: .hourAndMinute)
                .datePickerStyle(.compact)
                .frame(width: 60)
        }
        .padding(.top, 10)
        .padding(.trailing, 30)
        .padding(.leading, 20)

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


    private var datePicker: some View {
        DatePicker(
            "",
            selection: $selectedDate,
            in: ...Date(),
            displayedComponents: [.date, .hourAndMinute]
        )
        .datePickerStyle(GraphicalDatePickerStyle())

        .fixedSize(horizontal: false, vertical: true)
    }

    private var commentField: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Комментарий").font(.system(size: 20)).padding(.leading, 20)
            TextField("Введи комментарий", text: $comments)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
                .padding(.horizontal, 20)
                .padding(.bottom, 100)
        }
        .padding(.top, 10)
    }

    private var doneButton: some View {
        Button(action: {
            switch cardType {
            case .bloodSugar:
                let newCard = MealCardModel(mealTime: title, creationTime: selectedDate, bloodSugar: selectedSugarLevel, comments: comments)
                mealCardsData.cards.append(newCard)
            case .insulin:
                let newCard = MealCardModel(mealTime: title, creationTime: selectedDate, insulin: selectedSugarLevel, comments: comments)
                mealCardsData.cards.append(newCard)
            }
            showingNavigationBarView = true
        }) {
            Text("Готово").frame(minWidth: 0, maxWidth: .infinity).padding().contentShape(Rectangle())
        }
        .foregroundColor(.white)
        .background(Color.blue)
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


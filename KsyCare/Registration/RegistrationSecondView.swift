import SwiftUI

struct RegistrationSecondView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedGender: Gender?
    @State private var selectedDiabetesType: DiabetesType = .type1

    @State private var birthDate = Date()
    @State private var height: Int?
    @State private var weight: Int?

    @StateObject private var viewModel = ProfileViewModel()

    @State private var selectedHeight: Int? = 170
    @State private var selectedWeight: Int? = 70
    @State private var showingHeightPicker = false
    @State private var showingWeightPicker = false

    let heightRange = 100...250
    let weightRange = 30...200

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.349, green: 0.624, blue: 0.859),
                                                           Color(red: 0.549, green: 0.832, blue: 0.921),
                                                           Color(red: 0.8, green: 0.965, blue: 1)
                                                          ]),
                               startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

                content
            }
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
    }

    private var content: some View {
        ScrollView {
            VStack() {
                header
                Spacer()

                genderField
                birthDateField
                diabetesTypePicker
                heightPicker
                weightPicker
            }
            Spacer()

            VStack {
                Spacer()
                NavigationLink(destination: WarningScreen()) {
                    Text("Продолжить")
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(Color("startText"))
                        .background(Color("startButton"))
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }

    private var header: some View {
        VStack {
            HStack {
                backButton
                Spacer()
                threeRectangles
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 33, height: 26)
                Spacer()
            }
            .padding()

            HStack {
                Text("Узнаем тебя ближе!")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color("startText"))
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }

    private var genderField: some View {
        VStack(alignment: .leading) {
            Text("Пол")
                .font(.system(size: 20))
                .padding(.leading, 20)
                .foregroundColor(Color("startText"))
            HStack {
                ForEach(Gender.allCases, id: \.self) { gender in
                    Button(action: {
                        self.selectedGender = gender
                    }) {
                        HStack {
                            Text(gender.rawValue)
                                .fontWeight(.semibold)
                        }
                        .padding()

                        .frame(maxWidth: .infinity)
                        .background(self.selectedGender == gender ? Color("registrationChoose") : Color("registrationField"))
                        .foregroundColor(Color("startText"))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("registrationStroke"), lineWidth: 2)
                        )
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.top, 10)
    }

    private var birthDateField: some View {
        HStack() {
            Text("Дата рождения")
                .font(.system(size: 20))
                .padding(.leading, 20)
                .foregroundColor(Color("startText"))
            DatePicker("", selection: $birthDate, displayedComponents: .date)
                .padding(.horizontal, 20)
                .colorMultiply(Color("startText"))
                .accentColor(Color("rectanglesStroke"))
                .cornerRadius(5)

        }
        .padding(.top, 10)
    }

    private var diabetesTypePicker: some View {
        VStack(alignment: .leading) {
            Text("Тип диабета")
                .font(.system(size: 20))
                .padding(.leading, 20)
                .foregroundColor(Color("startText"))

            Picker("", selection: $selectedDiabetesType) {
                ForEach(DiabetesType.allCases) { type in
                    Text(type.rawValue)
                        .tag(type)
                        .foregroundColor(Color("startText"))
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 20)
        }
        .padding(.top, 10)
    }

    private var heightPicker: some View {
        VStack(alignment: .leading) {
            Text("Рост")
                .font(.system(size: 20))
                .padding(.leading, 20)
                .foregroundColor(Color("startText"))

            VStack {
                Button(action: {
                    withAnimation {
                        self.showingHeightPicker.toggle()
                    }
                }) {
                    HStack {
                        Text(selectedHeight != nil ? "\(selectedHeight!) см" : "")
                            .foregroundColor(Color("startText"))
                        Spacer()
                        Image(systemName: "chevron.right.circle")
                            .foregroundColor(Color("startText"))
                            .rotationEffect(.degrees(showingHeightPicker ? 90 : 0))
                    }
                }
                .padding()
                .background(Color("registrationField"))
                .cornerRadius(5)

                if showingHeightPicker {
                    Picker("", selection: $selectedHeight) {
                        ForEach(heightRange, id: \.self) { height in
                            Text("\(height) см")
                                .tag(height as Int?)
                                .foregroundColor(Color("startText"))
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .labelsHidden()
                    .transition(.opacity)
                }
            }
            .padding(.horizontal, 20)

        }
    }

    private var weightPicker: some View {
        VStack(alignment: .leading) {
            Text("Вес")
                .font(.system(size: 20))
                .padding(.leading, 20)
                .foregroundColor(Color("startText"))
            VStack {
                Button(action: {
                    withAnimation {
                        self.showingWeightPicker.toggle()
                    }
                }) {
                    HStack {
                        Text(selectedWeight != nil ? "\(selectedWeight!) кг" : "")
                            .foregroundColor(Color("startText"))
                        Spacer()
                        Image(systemName: "chevron.right.circle")
                            .foregroundColor(Color("startText"))
                            .rotationEffect(.degrees(showingWeightPicker ? 90 : 0))
                    }
                }
                .padding()
                .background(Color("registrationField"))
                .cornerRadius(5)

                if showingWeightPicker {
                    Picker("", selection: $selectedWeight) {
                        ForEach(weightRange, id: \.self) { weight in
                            Text("\(weight) кг")
                                .tag(weight as Int?)
                                .foregroundColor(Color("startText"))
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .labelsHidden()
                    .transition(.opacity)
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.top, 10)
    }

    private var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 13, height: 26)
                .foregroundColor(Color("xmark"))
        }
        .padding(.leading, 13)
    }

    enum Gender: String, CaseIterable {
        case male = "Мужской"
        case female = "Женский"
    }

    enum DiabetesType: String, CaseIterable, Identifiable {
        case type1 = "I тип"
        case type2 = "II тип"
        case gestational = "Гестационный"

        var id: String { self.rawValue }
    }

    private var threeRectangles: some View {
        HStack {
            ForEach(0..<2) { _ in
                Rectangle()
                    .frame(width: 50, height: 5)
                    .cornerRadius(2.5)
                    .foregroundColor(Color("rectanglesStroke"))
            }
            Rectangle()
                .frame(width: 50, height: 5)
                .cornerRadius(2.5)
                .foregroundColor(Color("registrationStroke"))
        }
    }
}

struct RegistrationSecondView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationSecondView()
    }
}

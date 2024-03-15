import SwiftUI

struct AddNotificationsView: View {
    @EnvironmentObject var viewModel: NotificationsViewModel
    @Binding var showingPopup: Bool
    @State private var title: String = ""
    @State private var time: Date = Date()
    @State private var repeatOption: RepeatOption = .never


    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Новое напоминание")
                .font(.custom("Amiko", size: 20).bold())
                .foregroundColor(.black)
                .padding(.top, 7)
                .padding(.leading, 20)

            Divider()
                .padding(.horizontal, 20)

            titleField
            timeField
            repeatField

            Button(action: {
                let newNotification = NotificationModel(title: title,
                                                        time: dateFormatter.string(from: time),
                                                        repeatInterval: repeatOption.rawValue)
                viewModel.addNotification(notification: newNotification)
                showingPopup = false
            }) {
                HStack {
                    Spacer()
                    Text("Добавить")
                    Spacer()
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .frame(height: 50)
            .padding(.horizontal, 20)

        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .foregroundColor(.black)
        .cornerRadius(40)
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }

    private var titleField: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Название напоминания").font(.system(size: 20)).padding(.leading, 20)
            TextField("Название", text: $title)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
                .padding(.horizontal, 20)
        }
        .padding(.top, 10)
    }

    private var timeField: some View {
        HStack() {
            Text("Время").font(.system(size: 20)).padding(.leading, 20)
            Spacer()
            DatePicker("Выбрать время", selection: $time, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                .padding(.horizontal, 20)
        }
    }

    private var repeatField: some View {
        HStack() {
            Text("Повтор").font(.system(size: 20)).padding(.leading, 20)
            Spacer()
            Picker("Повтор", selection: $repeatOption) {
                ForEach(RepeatOption.allCases, id: \.self) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
            .background(Color.gray.opacity(0.2))
            .cornerRadius(5)
            .padding(.horizontal, 20)
        }
    }
}

struct AddNotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        AddNotificationsView(showingPopup: .constant(true))
    }
}

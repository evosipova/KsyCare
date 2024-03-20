import SwiftUI

struct AddNotificationsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: NotificationsViewModel
    @Binding var showingPopup: Bool
    @State private var title: String = ""
    @State private var time: Date = Date()
    @State private var repeatOption: RepeatOption = .never
    
    var notificationToEdit: NotificationModel?
    var onDismiss: (() -> Void)?
    
    init(showingPopup: Binding<Bool>, notificationToEdit: NotificationModel?, onDismiss: (() -> Void)? = nil) {
        self._showingPopup = showingPopup
        self.notificationToEdit = notificationToEdit
        self.onDismiss = onDismiss
        if let notificationToEdit = notificationToEdit {
            self._title = State(initialValue: notificationToEdit.title)
            self._time = State(initialValue: notificationToEdit.time)
            self._repeatOption = State(initialValue: notificationToEdit.repeatOption)
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack {
                    HStack {
                        Spacer()
                        Text("Новое напоминание")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                    }
                    .padding()
                    .overlay(
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 13, height: 26)
                                .foregroundColor(Color("chevron.left"))
                        }
                            .padding(.leading, 15),
                        alignment: .leading
                    )
                    
                    Rectangle()
                        .frame(height: 3)
                        .padding(.horizontal)
                        .padding(.top, -10)
                        .foregroundColor(Color("divider"))
                    
                    titleField
                    timeField
                    repeatField
                    
                    Spacer()
                    
                    HStack {
                        if notificationToEdit != nil {
                            deleteButton
                                .padding(.trailing, -20)
                        }
                        doneButton
                    }
                    .padding(.bottom, 30)
                }
            }
            .background(Color("backgroundApp"))
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    private var deleteButton: some View {
        Button(action: {
            if let model = notificationToEdit {
                viewModel.deleteNotification(model)
                showingPopup = false
                self.presentationMode.wrappedValue.dismiss()
                onDismiss?()
            }
        }) {
            Image(systemName: "trash")
                .font(Font.title.weight(.bold))
                .foregroundColor(Color("ABF1ED-84EBE5"))
                .frame(width: 44, height: 44)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("ABF1ED-84EBE5"), lineWidth: 4)
                )
                .cornerRadius(5)
        }
        .padding(.leading, 20)
    }
    
    private var doneButton: some View {
        Button(action: {
            let finalTitle = title.isEmpty ? "Без названия" : title
            
            if let model = notificationToEdit {
                viewModel.updateNotification(model, title: finalTitle, time: time, repeatOption: repeatOption)
            } else {
                viewModel.addNotification(title: finalTitle, time: time, repeatOption: repeatOption)
            }
            showingPopup = false
            self.presentationMode.wrappedValue.dismiss()
            onDismiss?()
        }) {
            Text(notificationToEdit != nil ? "Обновить" : "Добавить")
                .foregroundColor(Color("2A2931-CCF6FF"))
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .background(Color("58EEE5-27D8CD"))
                .cornerRadius(10)
                .padding(.horizontal, 20)
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
    
    private var titleField: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Название напоминания")
                .font(.system(size: 20))
                .foregroundColor(Color("2A2931-CCF6FF"))
                .padding(.leading, 20)
            TextField("Название", text: $title)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("B6E4EF-548493"), lineWidth: 2)
                )
                .padding(.horizontal, 20)
            
        }
        .padding(.top, 10)
    }
    
    private var timeField: some View {
        HStack() {
            Text("Время")
                .font(.system(size: 20))
                .foregroundColor(Color("2A2931-CCF6FF"))
                .padding(.leading, 20)
            Spacer()
            DatePicker("Выбрать время", selection: $time, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .foregroundColor(Color("2A2931-CCF6FF"))
                .accentColor(Color("2A2931-CCF6FF"))
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("B6E4EF-548493"), lineWidth: 2)
                    
                )
                .padding(.horizontal, 20)
        }
    }
    
    private var repeatField: some View {
        HStack() {
            Text("Повтор")
                .font(.system(size: 20))
                .foregroundColor(Color("2A2931-CCF6FF"))
                .padding(.leading, 20)
            Spacer()
            Picker("Повтор", selection: $repeatOption) {
                ForEach(RepeatOption.allCases, id: \.self) { option in
                    Text(option.rawValue)
                        .tag(option)
                }
            }
            .accentColor(Color("2A2931-CCF6FF"))
            .pickerStyle(MenuPickerStyle())
            .background(Color.gray.opacity(0.2))
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("B6E4EF-548493"), lineWidth: 2)
            )
            .padding(.horizontal, 20)
        }
    }
}

struct AddNotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        AddNotificationsView(showingPopup: .constant(true), notificationToEdit: nil)
    }
}

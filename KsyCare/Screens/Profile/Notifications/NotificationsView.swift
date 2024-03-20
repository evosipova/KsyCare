import SwiftUI

struct NotificationsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: NotificationsViewModel
    @State private var showingAddNotificationView = false

    @State private var selectedNotification: NotificationModel?

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack {
                    header

                    Rectangle()
                        .frame(height: 3)
                        .padding(.horizontal)
                        .padding(.top, -10)
                        .foregroundColor(Color("divider"))

                    if viewModel.notifications.isEmpty {
                        ScrollView {
                            VStack {
                                Image("noRecord-pdf")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 250, height: 250)
                                    .foregroundColor(Color("5AA0DB"))

                                Text("Нет уведомлений")
                                    .font(.system(size: 24))
                                    .foregroundColor(Color("2A2931"))
                            }
                            .padding(.top, 150)
                        }
                    } else {
                        ScrollView {
                            VStack(spacing: 10) {
                                ForEach(viewModel.notifications, id: \.self) { notification in
                                    NotificationCard(title: notification.title,
                                                     time: formatTime(notification.time),
                                                     repeatInterval: notification.repeatOption.rawValue)
                                    .onTapGesture {
                                        selectedNotification = notification
                                        showingAddNotificationView = true
                                    }
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
            .fullScreenCover(isPresented: $showingAddNotificationView) {
                if let notificationToEdit = selectedNotification {
                    AddNotificationsView(showingPopup: $showingAddNotificationView, notificationToEdit: notificationToEdit, onDismiss: {
                        self.selectedNotification = nil
                    })
                    .environmentObject(viewModel)
                } else {
                    AddNotificationsView(showingPopup: $showingAddNotificationView, notificationToEdit: nil, onDismiss: {
                        self.selectedNotification = nil
                    })
                    .environmentObject(viewModel)
                }
            }
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
            .background(Color("backgroundApp"))
        }
        .navigationBarHidden(true)
    }

    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    private var header: some View {
        HStack {
            backButton
            Spacer()
            actionButtons
        }
        .padding()
        .overlay(
            Text("Уведомления")
                .font(.title2)
                .foregroundColor(Color("lightDetail")),
            alignment: .center
        )
    }

    private var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .resizable()
                .foregroundColor(Color("chevron.left"))
                .aspectRatio(contentMode: .fit)
                .frame(width: 13, height: 26)
        }
        .padding(.leading, 0)
    }

    private var actionButtons: some View {
        Button(action: {
            viewModel.showingAddNotificationsPopup = true
            showingAddNotificationView = true
        }) {
            Image(systemName: "plus")
                .foregroundColor(Color("backgroundApp"))
                .frame(width: 13, height: 13)
                .padding(10)
                .background(Color("chevron.left"))
                .cornerRadius(5)
        }
        .frame(width: 40, height: 40)
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView(viewModel: NotificationsViewModel())
    }
}

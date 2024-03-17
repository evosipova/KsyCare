import SwiftUI

struct NotificationsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: NotificationsViewModel


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
                        Spacer()
                        Text("пока нет уведомлений :(")
                            .foregroundColor(Color("lightDetail"))
                            .font(.title2)
                        Spacer()
                    } else {
                        ScrollView {
                            VStack(spacing: 10) {
                                ForEach(viewModel.notifications, id: \.self) { notification in
                                    NotificationCard(title: notification.title,
                                                     time: formatTime(notification.time),
                                                     repeatInterval: notification.repeatOption.rawValue)
                                }
                            }
                        }
                    }
                    Spacer()
                }
                .padding(.bottom, 10)

                if viewModel.showingAddNotificationsPopup {
                    addNotificationPopup
                        .frame(height: UIScreen.main.bounds.height / 2)
                        .transition(.move(edge: .bottom))
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

    private var addNotificationPopup: some View {
        VStack {
            Spacer()
            AddNotificationsView(showingPopup: $viewModel.showingAddNotificationsPopup)
                .environmentObject(viewModel)
                .frame(maxWidth: .infinity)
                .transition(.move(edge: .bottom))
                .animation(.default, value: viewModel.showingAddNotificationsPopup)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView(viewModel: NotificationsViewModel())
    }
}


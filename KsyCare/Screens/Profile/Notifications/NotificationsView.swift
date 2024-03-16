import SwiftUI

struct NotificationsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: NotificationsViewModel

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack {
                    header
                    Divider().background(Color.gray)

                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(viewModel.notifications, id: \.self) { notification in
                                NotificationCard(title: notification.title,
                                                 time: formatTime(notification.time),
                                                 repeatInterval: notification.repeatOption.rawValue)
                            }
                            .padding(.top)
                        }
                        .padding(.top)
                    }

                    Spacer()
                }

                if viewModel.showingAddNotificationsPopup {
                    addNotificationPopup
                        .frame(height: UIScreen.main.bounds.height / 2)
                        .transition(.move(edge: .bottom))
                }
            }
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
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
            Text("Уведомления")
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .center)
            Spacer()
            actionButtons
        }
        .padding()
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

    private var actionButtons: some View {
        Button(action: {
            viewModel.showingAddNotificationsPopup = true
        }) {
            Image(systemName: "plus")
                .foregroundColor(.white)
                .padding(10)
                .background(Color.blue)
                .cornerRadius(5)
        }
        .background(Color.white)
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


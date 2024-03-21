import SwiftUI
import PhotosUI

struct ProfileView: View {
    @State private var showTeamView = false
    @State private var showTeamScreen = false
    @State private var showScreensaverView = false
    @State private var showNotificationsView = false
    @StateObject private var viewModel = ProfileViewModel()
    @State private var inputImage: UIImage?
    @State private var isShowingPhotosPicker = false
    @State private var selectedPhotoItem: PhotosPickerItem? = nil

    private func navigationButton<Destination: View>(_ title: String, destination: Destination, color: Color) -> some View {
        NavigationLink(destination: destination) {
            HStack {
                Text(title)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "arrow.right")
                    .foregroundColor(.black)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(color)
            .cornerRadius(8)
        }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack() {
                    headingSection
                    avatarSection
                    personalInfoSection
                    therapySection
                    Spacer()
                }
                .padding(.bottom, 10)
            }
            .padding(.horizontal, 7)
            .frame(maxHeight: .infinity)
            .edgesIgnoringSafeArea(.bottom)
            .background(            LinearGradient(gradient: Gradient(colors: [Color(red: 0.349, green: 0.624, blue: 0.859),
                                                                               Color(red: 0.8, green: 0.965, blue: 1),
                                                                               Color(red: 0.948, green: 0.992, blue: 0.985)]),
                                                   startPoint: .top, endPoint: .bottom))
        }

        .fullScreenCover(isPresented: $showTeamView) {
            TeamScreen()
        }
        .fullScreenCover(isPresented: $showTeamScreen) {
            TeamScreen()
        }
        .fullScreenCover(isPresented: $showScreensaverView) {
            ScreensaverView()
        }
        .fullScreenCover(isPresented: $showNotificationsView) {
            NotificationsView(viewModel: NotificationsViewModel())
        }
    }

    private var headingSection: some View {
        HStack {
            Text("Профиль")
                .accessibilityHint("Экран")
                .font(.system(size: 24, weight: .bold))
                .fontWeight(.bold)
                .foregroundColor(Color("2A2931"))
                .padding(.leading, 20)
            Spacer()
            Menu {
                Button("Редактировать профиль") {
                    showTeamView.toggle()
                }
                Button("О команде") {
                    showTeamScreen.toggle()
                }
                Button("Выход") {
                    showScreensaverView.toggle()
                }
            } label: {
                Image("settings-pdf")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color("2A2931"))
                    .padding(.trailing, 20)
                    .accessibilityHidden(true)
                    //.accessibilityLabel("Настройки")
                   // .accessibilityHint("Кнопка")
            }
            .accessibilityLabel("Настройки")
            .accessibilityHint("Кнопка")
           // .accessibilityHidden(true)
        }
    }

    private var avatarSection: some View {
        VStack {
            Button(action: {
                isShowingPhotosPicker = true
            }) {
                ZStack {
                    Circle()
                        .foregroundColor(.gray)
                        .frame(width: 190, height: 190)

                    if let inputImage = inputImage {
                        Image(uiImage: inputImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 190, height: 190)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                            .foregroundColor(.white)
                            .accessibilityLabel("Аватар пользователя")
                            .accessibilityHint("Кнопка")
                    }
                }
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Аватар пользователя")
            .photosPicker(isPresented: $isShowingPhotosPicker, selection: $selectedPhotoItem, matching: .images)
            .onChange(of: selectedPhotoItem) { newItem in
                Task {
                    guard let selectedItem = newItem,
                          let data = try? await selectedItem.loadTransferable(type: Data.self),
                          let image = UIImage(data: data) else { return }

                    inputImage = image
                    loadImage()
                }
            }
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .padding(.top)
        }
    }

    private func loadImage() {
        guard let inputImage = inputImage else { return }
        viewModel.userProfile.avatar = inputImage
    }

    private var personalInfoSection: some View {
        VStack(alignment: .leading, spacing: 10) {

            HStack(alignment: .center) {
                Text(viewModel.userProfile.name)
                    .font(.headline)
                    .foregroundColor(Color("2A2931"))

                Text(viewModel.userProfile.surname)
                    .font(.headline)
                    .foregroundColor(Color("2A2931"))
            }
            .frame(maxWidth: .infinity)

            HStack {
                Text("Личная информация")
                    .foregroundColor(Color("F1FDFB-365E7A"))
                    .font(.headline)
                    .padding()
                Spacer()
            }
            .background(Color("599FDB-B6E4EF"))
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("B6E4EF-548493"), lineWidth: 2)
            )
            .accessibilityLabel(Text("Личная информация"))

            HStack {
                Text("Почта:")
                    .foregroundColor(Color("2A2931"))
                Spacer()
                Text(viewModel.userProfile.email)
                    .foregroundColor(.gray)
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(Text("Почта, \(viewModel.userProfile.email)"))


            HStack {
                Text("Дата рождения:")
                    .foregroundColor(Color("2A2931"))
                Spacer()
                Text("\(viewModel.userProfile.birthDate, formatter: dateFormatter)")
                    .foregroundColor(.gray)
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(Text("Почта, \(   Text("\(viewModel.userProfile.birthDate, formatter: dateFormatter)"))"))


            HStack {
                Text("Пол:")
                    .foregroundColor(Color("2A2931"))
                Spacer()
                Text(viewModel.userProfile.gender)
                    .foregroundColor(.gray)
            }
            HStack {
                Text("Вес:")
                    .foregroundColor(Color("2A2931"))
                Spacer()
                Text("\(viewModel.userProfile.weight, specifier: "%.1f") кг")
                    .foregroundColor(.gray)
            }
            HStack {
                Text("Рост:")
                    .foregroundColor(Color("2A2931"))
                Spacer()
                Text("\(viewModel.userProfile.height, specifier: "%.0f") см")
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }


    private var therapySection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Терапия")
                    .font(.headline)
                    .foregroundColor(Color("F1FDFB-365E7A"))
                    .padding()
                Spacer()
            }
            .background(Color("599FDB-B6E4EF"))
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("B6E4EF-548493"), lineWidth: 2)
            )

            HStack {
                Text("Тип диабета:")
                    .foregroundColor(Color("2A2931-CCF6FF"))
                Spacer()
                Text(viewModel.userProfile.diabetesType)
                    .foregroundColor(.gray)
            }

            Button(action: {
                showNotificationsView.toggle()
            }) {
                Text("Уведомления")
                    .foregroundColor(Color("2A2931"))
                Spacer()

                Image(systemName: "arrowshape.right.fill")
                    .foregroundColor(Color("2A2931"))
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color("ABF1ED"))
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("B6E4EF-548493"), lineWidth: 2)
            )
        }
        .padding()
    }

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

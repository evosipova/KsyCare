import SwiftUI

struct ProfileView: View {
    @State private var showTeamView = false
    @State private var showTeamScreen = false
    @State private var showScreensaverView = false

    @StateObject private var viewModel = ProfileViewModel()
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

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
            .frame(maxHeight: .infinity)
            .edgesIgnoringSafeArea(.bottom)
            .background(Color.gray.opacity(0.1))
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
    }

    private var headingSection: some View {
        HStack {
            Text("Профиль")
                .font(.system(size: 24, weight: .bold))
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .padding(.leading, 27)
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
                Image(systemName: "gear")
                    .font(.system(size: 28))
                    .foregroundColor(Color.black)
                    .padding(.trailing, 27)
            }
        }
    }

    private var avatarSection: some View {
        VStack {
            Button(action: {
                showingImagePicker = true
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
                    }
                }
            }
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .padding(.top)
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
            }
        }
    }


    private func loadImage() {
        guard let inputImage = inputImage else { return }
        viewModel.userProfile.avatar = inputImage
    }

    private var personalInfoSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Личная информация")
                    .font(.headline)
                    .padding()
                Spacer()
            }
            .background(Color.secondary)
            .cornerRadius(15)

            HStack {
                Text("Почта:")
                Spacer()
                Text(viewModel.userProfile.email)
                    .foregroundColor(.gray)
            }
            HStack {
                Text("Дата рождения:")
                Spacer()
                Text("\(viewModel.userProfile.birthDate, formatter: dateFormatter)")
                    .foregroundColor(.gray)
            }
            HStack {
                Text("Пол:")
                Spacer()
                Text(viewModel.userProfile.gender)
                    .foregroundColor(.gray)
            }
            HStack {
                Text("Вес:")
                Spacer()
                Text("\(viewModel.userProfile.weight, specifier: "%.1f") кг")
                    .foregroundColor(.gray)
            }
            HStack {
                Text("Рост:")
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
                    .padding()
                Spacer()
            }
            .background(Color.secondary)
            .cornerRadius(15)

            HStack {
                Text("Тип диабета:")
                Spacer()
                Text(viewModel.userProfile.diabetesType)
                    .foregroundColor(.gray)
            }
            HStack {
                Text("Норма сахара:")
                Spacer()
                Text(viewModel.userProfile.bloodSugarNorm)
                    .foregroundColor(.gray)
            }

            navigationButton("Уведомления", destination: NotificationsView(), color: Color("Test"))
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

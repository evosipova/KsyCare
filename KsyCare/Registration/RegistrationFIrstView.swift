import SwiftUI

struct RegistrationFirstView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @StateObject private var viewModel = ProfileViewModel()
    @State private var showSuccessScreen = false

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
                avatarSection
                nameField
                surnameField
                emailField
                passwordField

                Spacer()

//                NavigationLink(destination: RegistrationSecondView()) {
//                    Text("Продолжить")
//                        .bold()
//                        .frame(minWidth: 0, maxWidth: .infinity)
//                        .padding()
//                        .foregroundColor(Color("startText"))
//                        .background(Color("startButton"))
//                        .cornerRadius(10)
//                }
//                .padding()
                Button(action: {
                    Task {
                        do {
                            let user = try await NetworkService.shared.register(name: name, login: email, password: password, role: surname)
//                            viewModel.user = user

                            // Переключаемся на экран успешной регистрации или любой другой экран по вашему выбору
                            showSuccessScreen = true
                        } catch {
                            // Обработка ошибок регистрации
                            print("Ошибка регистрации: \(error)")
                        }
                    }
                }) {
                    Text("Продолжить")
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(Color("startText"))
                        .background(Color("startButton"))
                        .cornerRadius(10)
                }
                .sheet(isPresented: $showSuccessScreen) {
                    // Предположим, что после успешной регистрации вы хотите показать CustomTabBarView
                    // Или измените на другой экран, который сочтете нужным
                    CustomTabBarView(viewModel: CustomTabBarViewModel())
                }

            }
            Spacer()
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
                Text("Привет!")
                    .foregroundColor(Color("startText"))
                    .font(.system(size: 24, weight: .bold))

                Spacer()
            }
            .padding(.horizontal, 20)

            HStack {
                Text("Давай знакомиться!")
                    .font(.system(size: 24))
                    .foregroundColor(Color("startText"))
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }

    private var nameField: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Имя")
                .font(.system(size: 20)).padding(.leading, 20)
                .foregroundColor(Color("startText"))
            TextField("", text: $name, prompt: Text("Введи имя")
                .foregroundColor(Color("loginText")))
            .padding()
            .foregroundColor(Color("startText"))
            .background(Color("registrationField"))
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("registrationStroke"), lineWidth: 2)
            )
            .padding(.horizontal, 20)
        }
        .padding(.top, 10)
    }

    private var surnameField: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Фамилия")
                .font(.system(size: 20)).padding(.leading, 20)
                .foregroundColor(Color("startText"))
            TextField("", text: $surname, prompt: Text("Введи фамилию")
                .foregroundColor(Color("loginText")))
            .padding()
            .foregroundColor(Color("startText"))
            .background(Color("registrationField"))
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("registrationStroke"), lineWidth: 2)
            )
            .padding(.horizontal, 20)
        }
        .padding(.top, 10)
    }

    private var emailField: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Почта")
                .font(.system(size: 20)).padding(.leading, 20)
                .foregroundColor(Color("startText"))


            TextField("", text: $email, prompt: Text("Введи почту")
                .foregroundColor(Color("loginText")))
            .padding()
            .foregroundColor(Color("startText"))
            .background(Color("registrationField"))
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("registrationStroke"), lineWidth: 2)
            )
            .padding(.horizontal, 20)
        }
        .padding(.top, 10)
    }

    private var passwordField: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Пароль")
                .font(.system(size: 20)).padding(.leading, 20)
                .foregroundColor(Color("startText"))

            TextField("", text: $password, prompt: Text("Введи пароль")
                .foregroundColor(Color("loginText")))
            .padding()
            .foregroundColor(Color("startText"))
            .background(Color("registrationField"))
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("registrationStroke"), lineWidth: 2)
            )
            .padding(.horizontal, 20)
        }
        .padding(.top, 10)
    }

    private var avatarSection: some View {
        VStack {
            Button(action: {
                showingImagePicker = true
            }) {
                ZStack {
                    Circle()
                        .foregroundColor(Color("registrationAvatar"))
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

    private var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "xmark")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 23, height: 26)
                .foregroundColor(Color("xmark"))
        }
        .padding(.leading, 5)
    }

    private var threeRectangles: some View {
        HStack {
            Rectangle()
                .frame(width: 50, height: 5)
                .cornerRadius(2.5)
                .foregroundColor(Color("rectanglesStroke"))
            ForEach(0..<2) { _ in
                Rectangle()
                    .frame(width: 50, height: 5)
                    .cornerRadius(2.5)
                    .foregroundColor(Color("registrationStroke"))
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationFirstView()
    }
}

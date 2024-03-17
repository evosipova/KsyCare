import SwiftUI

struct ScreensaverView: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.349, green: 0.624, blue: 0.859),
                                                           Color(red: 0.8, green: 0.965, blue: 1),
                                                           Color(red: 0.945, green: 0.992, blue: 0.984)]),
                               startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()

                    NavigationLink(destination: CustomTabBarView(viewModel: CustomTabBarViewModel())) {
                        Text("Не нажимать!")
                            .foregroundColor(Color("startText"))
                    }
                    .padding()

                    Spacer()

                    NavigationLink(destination: RegistrationFirstView()) {
                        Text("Начнем")
                            .bold()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(Color("startText"))
                            .background(Color("startButton"))
                            .cornerRadius(10)
                    }

                    NavigationLink(destination: LoginView()) {
                        HStack(spacing: 5) {
                            Text("Уже зарегистрированы?")
                                .foregroundColor(Color("loginText"))
                            Text("Войти")
                                .foregroundColor(Color("startText"))
                        }
                    }
                    .padding()
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
}

struct ScreensaverView_Previews: PreviewProvider {
    static var previews: some View {
        ScreensaverView()
    }
}

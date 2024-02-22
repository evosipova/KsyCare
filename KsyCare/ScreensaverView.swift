import SwiftUI

struct ScreensaverView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "heart.fill")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                    .padding(8)

                Text("KsyCare")

                NavigationLink("Регистрация", destination: RegistrationView())
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(8)

                NavigationLink("Авторизация", destination: LoginView())
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)

                NavigationLink("Основной экран", destination: NavigationBarView())
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(8)
            }
            .padding()
        }
    }
}

struct ScreensaverView_Previews: PreviewProvider {
    static var previews: some View {
        ScreensaverView()
    }
}

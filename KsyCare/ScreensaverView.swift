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
                
                navigationButton("Регистрация", destination: RegistrationView(), color: .green)
                navigationButton("Авторизация", destination: LoginView(), color: .blue)
                navigationButton("Основной экран", destination: CustomTabBarView(viewModel: CustomTabBarViewModel()), color: .red)
            }
            .padding()
        }
    }
    
    private func navigationButton<Destination: View>(_ title: String, destination: Destination, color: Color) -> some View {
        NavigationLink(title, destination: destination)
            .padding()
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(8)
    }
}

struct ScreensaverView_Previews: PreviewProvider {
    static var previews: some View {
        ScreensaverView()
    }
}

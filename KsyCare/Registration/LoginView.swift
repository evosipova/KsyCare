import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var inputImage: UIImage?
    @StateObject private var viewModel = ProfileViewModel()
    
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
                
                VStack {
                    Spacer()
                    NavigationLink(destination: CustomTabBarView(viewModel: CustomTabBarViewModel())) {
                        Text("Войти")
                            .bold()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(Color("startText"))
                            .background(Color("startButton"))
                            .cornerRadius(10)
                    }
                }
                .padding()
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
                emailField
                passwordField
            }
            Spacer()
        }
    }
    
    private var header: some View {
        VStack {
            HStack {
                backButton
                Spacer()
                
            }
            .padding()
            
            HStack {
                Text("Вход")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color("startText"))
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
    
    private var emailField: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Почта")
                .font(.system(size: 20))
                .padding(.leading, 20)
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
                .font(.system(size: 20))
                .padding(.leading, 20)
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
        .padding(.leading, 9)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


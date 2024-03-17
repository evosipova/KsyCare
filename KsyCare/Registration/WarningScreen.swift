import SwiftUI

struct WarningScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingImagePicker = false
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
                NavigationLink(destination: CustomTabBarView(viewModel: CustomTabBarViewModel())) {
                    Text("Продолжить")
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(Color("startText"))
                        .background(Color("startButton"))
                        .cornerRadius(10)
                }
                .padding()
                .padding(.bottom)
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
                Text("ВАЖНО")
                    .foregroundColor(Color("startText"))
                    .font(.system(size: 24, weight: .bold))

                Spacer()
            }
            .padding(.horizontal, 20)

            HStack {
                Text("Приложение предназначено для ведения дневника самоконтроля при инсулинозависимом сахарном диабете 1-го и 2-го типов.\n\nПредупреждаем, что вся информация, получаемая с помощью приложения, носит исключительно информативный характер.\n\nДля постановки диагноза и назначения лекарственных препаратов, а также установки дозы их применения, обратитесь к лечащему врачу.")
                    .font(.custom("Amiko", size: 18))
                    .foregroundColor(Color("startText"))
                    .fontWeight(.regular)
                    .padding(.top, 8)
                Spacer()
            }
            .padding(.horizontal, 20)
        }
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
            ForEach(0..<3) { _ in
                Rectangle()
                    .frame(width: 50, height: 5)
                    .cornerRadius(2.5)
                    .foregroundColor(Color("rectanglesStroke"))
            }
        }
    }
}

struct WarningScreen_Previews: PreviewProvider {
    static var previews: some View {
        WarningScreen()
    }
}

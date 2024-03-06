import SwiftUI

struct WarningScreen: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack {
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 13, height: 26)
                        }
                        .padding(.leading, 13)

                        Spacer()

                        HStack {
                            ForEach(0..<6) { _ in
                                Rectangle()
                                    .frame(width: 20, height: 5)
                                    .cornerRadius(5)
                                    .foregroundColor(.blue)
                            }
                        }

                        Spacer()

                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 33, height: 26)
                    }
                    .padding()

                    HStack {
                        Text("ВАЖНО")
                            .font(.system(size: 24, weight: .bold))
                        Spacer()
                    }
                    .padding(.leading, 20)

                    Text("Приложение предназначено для ведения дневника самоконтроля при инсулинозависимом сахарном диабете 1-го и 2-го типов.\n\nПредупреждаем, что вся информация, получаемая с помощью приложения, носит исключительно информативный характер.\n\nДля постановки диагноза и назначения лекарственных препаратов, а также установки дозы их применения, обратитесь к лечащему врачу.")
                        .font(.custom("Amiko", size: 18))
                        .fontWeight(.regular)
                        .padding(.horizontal, 20)
                        .padding(.top, 8)

                    Spacer()

                    NavigationLink(destination: CustomTabBarView(viewModel: CustomTabBarViewModel())) {
                        Text("Продолжить")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.bottom, 30)
                            .padding(.horizontal, 20)
                    }
                }
            }
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct WarningScreen_Previews: PreviewProvider {
    static var previews: some View {
        WarningScreen()
    }
}

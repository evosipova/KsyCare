import SwiftUI

struct TeamScreen: View {
    @Environment(\.presentationMode) var presentationMode
    let teamMembers = ["Шаповалов Артём", "Осипова Елизавета"]
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack {
                    HStack {
                        Spacer()
                        Text("О команде")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                    }
                    .padding()
                    .overlay(
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 13, height: 26)
                                .foregroundColor(Color("chevron.left"))
                                .accessibilityLabel("Назад")
                        }
                            .padding(.leading, 15),
                        alignment: .leading
                    )

                    Rectangle()
                        .frame(height: 3)
                        .padding(.horizontal)
                        .padding(.top, -10)
                        .foregroundColor(Color("divider"))

                    VStack(alignment: .center, spacing: 10) {
                        Text("Разработчики:")
                            .font(.headline)
                            .padding(.vertical, 10)
                            .foregroundColor(Color("textDark"))
                            .accessibilityLabel("Разработчики")
                            .accessibilityHint("Текст")
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color("box"))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()

                    ForEach(teamMembers, id: \.self) { member in
                        Text(member)
                            .foregroundColor(Color("lightDetail"))
                            .font(.custom("Amiko", size: 20))
                            .padding(.bottom, 10)
                    }
                    
                    Spacer()
                }
            }
            .background(Color("backgroundApp"))
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct TeamScreen_Previews: PreviewProvider {
    static var previews: some View {
        TeamScreen()
    }
}


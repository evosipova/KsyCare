import SwiftUI

struct NotificationsView: View {
    @Environment(\.presentationMode) var presentationMode
    let teamMembers = ["Осипова Елизавета", "Шаповалов Артём"]

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

                        Text("О команде")
                            .font(.title2)

                        Spacer()

                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 33, height: 26)
                    }
                    .padding()

                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 2)
                        .padding(.horizontal, 20)


                    VStack(alignment: .center, spacing: 10) {
                        Text("Разработчики:")
                            .font(.headline)
                            .padding(.vertical, 5)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color.gray)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()

                    ForEach(teamMembers, id: \.self) { member in
                        Text(member)
                            .font(.custom("Amiko", size: 20))
                            .padding(.bottom, 10)
                    }

                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    NotificationsView()
}

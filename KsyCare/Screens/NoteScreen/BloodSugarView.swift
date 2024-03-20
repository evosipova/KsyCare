import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }

}

struct BloodSugarView: View {
    @Environment(\.presentationMode) var presentationMode
    private let bloodSugarLevels = Array(stride(from: 0.0, through: 30.0, by: 0.1))
    @State private var selectedSugarLevel: Double = 5.0
    @State private var scrollViewProxy: ScrollViewProxy?
    private let itemWidth: CGFloat = 150
    private let itemHeight: CGFloat = 150
    private let frameWidth: CGFloat = 300
    private let frameHeight: CGFloat = 450
    private let spacing: CGFloat = 5

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.349, green: 0.624, blue: 0.859),
                                                           Color(red: 0.549, green: 0.832, blue: 0.921),
                                                           Color(red: 0.8, green: 0.965, blue: 1)
                                                          ]),
                               startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(Color("F1FDFB-365E7A"))
                    .frame(maxHeight: 763)
                    .edgesIgnoringSafeArea(.bottom)


                VStack {
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 13, height: 26)
                                .foregroundColor(Color("4579A5-B5E3EE"))
                        }
                        .padding(.leading, 8)

                        Spacer()

                        twoRectangles

                        Spacer()

                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 33, height: 26)
                    }
                    .padding()

                    HStack {
                        Text("Сахар крови")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color("2A2931-CCF6FF"))
                        Spacer()
                    }
                    .padding(.leading, 20)

                    Spacer()

                    Text("ММОЛЬ/Л")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color("2A2931-CCF6FF"))
                        .padding(.top, 100)

                    GeometryReader { fullView in
                        ScrollViewReader { proxy in
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: spacing) {
                                    ForEach(bloodSugarLevels, id: \.self) { level in
                                        let isSelected = level == selectedSugarLevel
                                        Text("\(level, specifier: "%.1f")")


                                            .font(.system(size: isSelected ? 70 : 40))
                                            .foregroundColor(isSelected ? Color("2A2931-CCF6FF") : Color("7A9DA8"))
                                            .frame(width: itemWidth, height: itemHeight)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 5)

                                                    .stroke(isSelected ? Color("2BBEBE-B6E4EF") : Color.clear, lineWidth: 3)
                                                    .padding(5)
                                            )
                                            .onTapGesture {
                                                selectedSugarLevel = level
                                                scrollViewProxy?.scrollTo(level, anchor: .center)
                                            }
                                            .id(level)
                                    }
                                }
                                .padding(.horizontal, fullView.size.width / 2 - itemWidth / 2)
                                .background(GeometryReader {
                                    Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self,
                                                           value: -$0.frame(in: .named("scrollView")).origin.x + fullView.size.width / 2 + itemWidth / 2)
                                })
                            }
                            .coordinateSpace(name: "scrollView")
                            .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { offset in
                                let center = offset - fullView.size.width  + itemWidth
                                let centerIndex = Int(round(center / (itemWidth + spacing)))

                                if centerIndex >= 0 && centerIndex < bloodSugarLevels.count {
                                    let centeredItem = bloodSugarLevels[centerIndex]
                                    if selectedSugarLevel != centeredItem {
                                        withAnimation(.easeInOut(duration: 0.7)) {
                                            selectedSugarLevel = centeredItem
                                            scrollViewProxy?.scrollTo(centeredItem, anchor: .center)
                                        }
                                    }
                                }
                            }
                            .onAppear {
                                scrollViewProxy = proxy
                                DispatchQueue.main.async {
                                    scrollViewProxy?.scrollTo(5.0, anchor: .center)
                                }
                            }

                        }
                        .frame(height: fullView.size.height / 2)
                    }
                    .frame(height: frameHeight)

                    Spacer()

                    NavigationLink(destination: NoteView(selectedSugarLevel: $selectedSugarLevel, displayText: "Сахар крови", cardType: .bloodSugar)) {
                        Text("Далее")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .foregroundColor(Color("2A2931-CCF6FF"))
                            .padding()
                            .background(Color("58EEE5-27D8CD"))
                            .cornerRadius(10)
                            .padding(.bottom, 30)
                            .padding(.horizontal, 20)
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }

    private var twoRectangles: some View {
        HStack {
            Rectangle()
                .frame(width: 50, height: 5)
                .cornerRadius(2.5)
                .foregroundColor(Color("rectanglesStroke"))
            Rectangle()
                .frame(width: 50, height: 5)
                .cornerRadius(2.5)
                .foregroundColor(Color("registrationStroke"))
        }
    }
}

struct BloodSugarScaleView_Previews: PreviewProvider {
    static var previews: some View {
        BloodSugarView()
    }
}

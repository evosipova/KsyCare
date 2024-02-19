import SwiftUI

struct InsulinView: View {
    @Environment(\.presentationMode) var presentationMode

    private let bloodSugarLevels = Array(stride(from: 3.0, through: 7.0, by: 0.1))
    @State private var selectedSugarLevel: Double = 3.0
    @State private var scrollViewProxy: ScrollViewProxy?
    private let itemWidth: CGFloat = 100
    private let itemHeight: CGFloat = 80
    private let frameWidth: CGFloat = 200
    private let frameHeight: CGFloat = 300
    private let spacing: CGFloat = 20

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {

                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(Color("Test"))
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
                        }
                        .padding(.leading, 13)

                        Spacer()

                        HStack {
                            Rectangle()
                                .frame(width: 50, height: 5)
                                .cornerRadius(5)
                                .foregroundColor(.blue)
                            Rectangle()
                                .frame(width: 50, height: 5)
                                .cornerRadius(5)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 33, height: 26)
                    }
                    .padding()

                    HStack {
                        Text("Инсулин")
                            .font(.system(size: 24, weight: .bold))
                        Spacer()
                    }
                    .padding(.leading, 20)

                    Spacer()

                    Text("ММОЛЬ/Л")
                        .font(.system(size: 18, weight: .bold))
                        .padding(.top, 100)



                    GeometryReader { fullView in
                        ScrollViewReader { proxy in
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: spacing) {
                                    ForEach(bloodSugarLevels, id: \.self) { level in
                                        let isSelected = level == selectedSugarLevel
                                        Text("\(level, specifier: "%.1f")")
                                            .font(.system(size: isSelected ? 64 : 52))
                                            .foregroundColor(isSelected ? .red : .black)
                                            .frame(width: itemWidth, height: itemHeight)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 5)
                                                    .stroke(isSelected ? Color.red : Color.clear, lineWidth: 5)
                                            )
                                            .contentShape(Rectangle())
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
                                                           value: -$0.frame(in: .named("scrollView")).origin.x + fullView.size.width / 2 - itemWidth / 2)
                                })
                            }
                            .coordinateSpace(name: "scrollView")
                            .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { offset in
                                let center = offset - (fullView.size.width / 2 - itemWidth / 2) + (itemWidth / 2)
                                let centerIndex = Int(round(center / (itemWidth + spacing)))

                                if centerIndex >= 0 && centerIndex < bloodSugarLevels.count {
                                    let centeredItem = bloodSugarLevels[centerIndex]
                                    if selectedSugarLevel != centeredItem {
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            selectedSugarLevel = centeredItem
                                            scrollViewProxy?.scrollTo(centeredItem, anchor: .center)
                                        }
                                    }
                                }
                            }
                            .onAppear {
                                scrollViewProxy = proxy
                            }
                        }
                        .frame(height: fullView.size.height / 2)
                    }
                    .frame(height: frameHeight)

                    Spacer()

                    NavigationLink(destination: NoteView(displayText: "Сахар крови")) {
                        Text("Далее")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.bottom, 30)
                            .padding(.horizontal, 20)
                    }
                    .padding()
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct InsulinView_Previews: PreviewProvider {
    static var previews: some View {
        InsulinView()
    }
}

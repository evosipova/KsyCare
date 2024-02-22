import SwiftUI

struct CustomTabBarView: View {
    @State private var selectedTab: Int = 0
    @State private var previousTab: Int = 0
    @State private var showingAddNotePopup: Bool = false

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                switch selectedTab {
                case 0:
                    HomeView()
                case 1:
                    HistoryView()
                case 3:
                    StatisticsView()
                case 4:
                    ProfileView()
                default:
                    Text("Остальные вкладки")
                }

                Spacer()

                HStack {
                    ForEach(0..<5) { index in
                        CustomTabBarItem(iconName: self.getIconName(for: index), isSelected: selectedTab == index) {
                            if index == 2 {
                                self.showingAddNotePopup = true
                                self.previousTab = self.selectedTab
                            } else {
                                self.selectedTab = index
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .padding()
                .background(Color(.systemBackground))
            }
            .disabled(showingAddNotePopup)

            if showingAddNotePopup {
                Button(action: {
                    showingAddNotePopup = false
                }) {
                    Color.clear
                        .edgesIgnoringSafeArea(.all)
                }

                AddNoteView(showingPopup: $showingAddNotePopup)
                    .padding(.bottom)
                    .transition(.move(edge: .bottom))
                    .animation(.default, value: showingAddNotePopup)
                    .zIndex(2)
            }
        }
        .navigationBarHidden(true)
    }

    func getIconName(for index: Int) -> String {
        switch index {
        case 0: return "house.fill"
        case 1: return "heart.fill"
        case 2: return "plus.circle.fill"
        case 3: return "chart.line.uptrend.xyaxis"
        case 4: return "person.fill"
        default: return ""
        }
    }
}

struct CustomTabBarItem: View {
    let iconName: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: iconName)
                    .font(.system(size: 28))
                    .foregroundColor(isSelected ? .blue : .gray)
            }
        }
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarView()
    }
}

import SwiftUI

struct CustomTabBarView: View {
    @ObservedObject var viewModel: CustomTabBarViewModel

    var body: some View {
        ZStack(alignment: .bottom) {
            switch viewModel.selectedTab {
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
                    CustomTabBarItem(iconName: self.getIconName(for: index), isSelected: viewModel.selectedTab == index) {
                        if index == 2 {
                            viewModel.showingAddNotePopup = true
                        } else {
                            viewModel.selectedTab = index
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            .padding()
            .background(Color("599FDB-B6E4EF"))
            .padding(.horizontal, 10)
            .edgesIgnoringSafeArea(.bottom)

            if viewModel.showingAddNotePopup {
                Button(action: {
                    viewModel.showingAddNotePopup = false
                }) {
                    Color.clear
                        .edgesIgnoringSafeArea(.all)
                }

                AddNoteView(viewModel: AddNoteViewModel(), showingPopup: $viewModel.showingAddNotePopup)
                    .transition(.move(edge: .bottom))
                    .animation(.default, value: viewModel.showingAddNotePopup)
                    .zIndex(2)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(true)
    }

    func getIconName(for index: Int) -> String {
        switch index {
        case 0: return "tap1-pdf"
        case 1: return "tap2-pdf"
        case 2: return "plus.circle.fill"
        case 3: return "tap3-pdf"
        case 4: return "tap4-pdf"
        default: return ""
        }
    }
}

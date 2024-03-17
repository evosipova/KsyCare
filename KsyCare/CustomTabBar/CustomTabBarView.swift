import SwiftUI

struct CustomTabBarView: View {
    @ObservedObject var viewModel: CustomTabBarViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
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
                .background(Color(.systemBackground))

            }
            .disabled(viewModel.showingAddNotePopup)
            
            if viewModel.showingAddNotePopup {
                Button(action: {
                    viewModel.showingAddNotePopup = false
                }) {
                    Color.clear
                        .edgesIgnoringSafeArea(.all)
                }
                
                AddNoteView(viewModel: AddNoteViewModel(), showingPopup: $viewModel.showingAddNotePopup)
                    .padding(.bottom)
                    .transition(.move(edge: .bottom))
                    .animation(.default, value: viewModel.showingAddNotePopup)
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

import SwiftUI

struct MainScreenView: View {



    init() {
        let appearance = UITabBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .regular)
        appearance.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                    .tag(0)
                HealthView()
                    .tabItem {
                        Image(systemName: "heart.fill")
                    }
                    .tag(1)
                Color.clear
                    .tabItem {
                        Image(systemName: "plus.circle.fill")
                    }
                    .tag(2)
                StatisticsView()
                    .tabItem {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                    }
                    .tag(3)
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                    }
                    .tag(4)
            }
            .onChange(of: selectedTab) { newValue in
                if newValue == 2 {
                    showingAddNotePopup = true
                    selectedTab = previousTab
                } else {
                    previousTab = newValue
                }
            }
            
            if showingAddNotePopup {
                Button(action: {
                    showingAddNotePopup = false
                }) {
                    Color.clear
                        .edgesIgnoringSafeArea(.all)
                }
                
                AddNoteView(showingPopup: $showingAddNotePopup)
                    .transition(.move(edge: .bottom))
                    .animation(.default, value: showingAddNotePopup)
                    .zIndex(2)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }

    
    @State private var selectedTab: Int = 0
    @State private var previousTab: Int = 0
    @State private var showingAddNotePopup: Bool = false
}



struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}

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
        TabView {
            HomeView()
                .tabItem {
                    Image(uiImage: tabBarItemImage(systemName: "house.fill") ?? UIImage())
                }
            HealthView()
                .tabItem {
                    Image(uiImage: tabBarItemImage(systemName: "heart.fill") ?? UIImage())
                }
            AddNoteView()
                .tabItem {
                    Image(uiImage: tabBarItemImage(systemName: "plus.circle.fill") ?? UIImage())
                }
            StatisticsView()
                .tabItem {
                    Image(uiImage: tabBarItemImage(systemName: "chart.line.uptrend.xyaxis") ?? UIImage())
                }
            ProfileView()
                .tabItem {
                    Image(uiImage: tabBarItemImage(systemName: "person.fill") ?? UIImage())
                }
        }
    }
}

func tabBarItemImage(systemName: String) -> UIImage? {
    let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular)
    guard let image = UIImage(systemName: systemName, withConfiguration: config) else { return nil }

    let newSize = CGSize(width: image.size.width, height: image.size.height + 20)
    let renderer = UIGraphicsImageRenderer(size: newSize)

    return renderer.image { _ in
        image.draw(at: CGPoint(x: 0, y: 20))
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}

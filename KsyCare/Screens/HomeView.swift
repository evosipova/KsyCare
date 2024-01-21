import SwiftUI

struct HomeView: View {
    var body: some View {
        Text("HomeView")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.orange)
            .edgesIgnoringSafeArea(.all)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

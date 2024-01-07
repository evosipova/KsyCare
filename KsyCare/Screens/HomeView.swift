//import SwiftUI
//
//struct HomeView: View {
//    var body: some View {
//        Text("HomeView")
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(Color.orange)
//            .edgesIgnoringSafeArea(.all)
//    }
//}
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}


import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: NotesViewModel

    var body: some View {
        ScrollView {
            ForEach(viewModel.entries, id: \.date) { entry in
                VStack(alignment: .leading) {
                    Text("Сахар: \(entry.sugarLevel) ммоль/л")
                    Text(entry.notes)
                }
                .padding()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: NotesViewModel())
    }
}

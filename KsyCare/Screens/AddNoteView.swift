import SwiftUI

struct AddNoteView: View {
    var body: some View {
        Text("AddNoteView")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.orange)
            .edgesIgnoringSafeArea(.all)
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

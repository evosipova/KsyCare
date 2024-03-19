import SwiftUI

struct RingView: View {
    var progress: CGFloat
    var color: Color
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 10)
            .opacity(0.3)
            .foregroundColor(Color("ABF1ED"))
            .overlay(
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .foregroundColor(color)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 1), value: progress)
            )
    }
}

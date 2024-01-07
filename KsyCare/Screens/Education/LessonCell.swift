import SwiftUI

struct Lesson {
    var number: Int
    var title: String
    var image: Image
}

struct LessonCell: View {
    var lesson: Lesson

    var body: some View {
        VStack {
            lesson.image
                .resizable()
                .aspectRatio(contentMode: .fill)
               // .frame(height: 250)
                .clipped()
            VStack {
                Text("Урок \(lesson.number)")
                    .font(.system(size: 30, weight: .bold))
                Text(lesson.title)
                    .font(.system(size: 15))
            }
            .padding()
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct LessonCell_Previews: PreviewProvider {
    static var previews: some View {
        LessonCell(lesson: Lesson(number: 1, title: "О диабете", image: Image("test")))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

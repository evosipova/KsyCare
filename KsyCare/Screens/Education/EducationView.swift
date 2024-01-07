import SwiftUI

struct EducationView: View {
       let lessons = [
           Lesson(number: 1, title: "О диабете", image: Image("test")),
           Lesson(number: 2, title: "Самоконтроль", image: Image("test")),
           Lesson(number: 3, title: "Правильное питание", image: Image("test")),
           Lesson(number: 4, title: "Физическая активность", image: Image("test")),
           Lesson(number: 5, title: "Управление стрессом", image: Image("test")),
           Lesson(number: 6, title: "Профилактика осложнений", image: Image("test"))

       ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 50), 
                GridItem(.flexible())
            ], spacing: 20) {
                ForEach(lessons, id: \.number) { lesson in
                    LessonCell(lesson: lesson)
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct EducationView_Previews: PreviewProvider {
    static var previews: some View {
        EducationView()
    }
}


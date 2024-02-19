import SwiftUI

struct NoteView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String = ""
    @State private var comments: String = ""
    @State private var selectedDate = Date()
    @State private var isShowingDatePicker = false
    
    private let buttonHeight: CGFloat = 50
    private let horizontalPadding: CGFloat = 20
    private let verticalPadding: CGFloat = 30

    let displayText: String
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                
                ScrollView {
                    VStack() {
                        HStack {
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "chevron.left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 13, height: 26)
                            }
                            .padding(.leading, 13)
                            
                            Spacer()
                            
                            HStack {
                                Rectangle()
                                    .frame(width: 50, height: 5)
                                    .cornerRadius(5)
                                    .foregroundColor(.blue)
                                Rectangle()
                                    .frame(width: 50, height: 5)
                                    .cornerRadius(5)
                                    .foregroundColor(.blue)
                            }
                            
                            Spacer()
                            
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 33, height: 26)
                        }
                        .padding()
                        
                        
                        
                        HStack {
                            Text(displayText)
                                .font(.system(size: 24, weight: .bold))
                            Spacer()
                        }
                        .padding(.leading, 20)
                        
                        
                        HStack {
                            Text("Заголовок")
                                .font(.system(size: 20))
                                .padding(.leading, 20)
                            Spacer()
                        }
                        .padding(.top, 10)
                        
                        
                        TextField("Без зоголовка", text: $title)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(5)
                            .padding(.horizontal, horizontalPadding)
                        
                        HStack {
                            Text("Дата и время")
                                .font(.system(size: 20))
                                .padding(.leading, 20)
                            Spacer()
                        }
                        .padding(.top, 10)
                        
                        
                        Section {
                            Button(action: {
                                self.isShowingDatePicker.toggle()
                            }) {
                                HStack {
                                    Text("\(selectedDate, style: .date) \(selectedDate, style: .time)")
                                    Spacer()
                                    Image(systemName: "calendar")
                                }
                            }
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(5)
                            .environment(\.locale, Locale(identifier: "ru_RU"))
                            
                            if isShowingDatePicker {
                                DatePicker("",
                                           selection: $selectedDate,
                                           displayedComponents: [.date])
                                .datePickerStyle(GraphicalDatePickerStyle())
                                .labelsHidden()
                                .environment(\.locale, Locale(identifier: "ru_RU"))
                                
                                
                                HStack {
                                    Text("Время")
                                        .font(.headline)
                                    Spacer()
                                    DatePicker("",
                                               selection: $selectedDate,
                                               displayedComponents: [.hourAndMinute])
                                    .labelsHidden()
                                    .environment(\.locale, Locale(identifier: "ru_RU"))
                                }
                            }
                            
                            
                            
                            
                            
                        }
                        .padding(.horizontal, 20)
                        
                        HStack {
                            Text("Комментарий")
                                .font(.system(size: 20))
                                .padding(.leading, 20)
                            Spacer()
                        }
                        .padding(.top, 10)
                        
                        TextField("Введи комментарий", text: $comments)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(5)
                            .padding(.horizontal, horizontalPadding)
                        
                        Spacer()
                        
                        NavigationLink(destination: MainScreenView()) {
                            Text("Готово")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .foregroundColor(.white)
                                .padding()
                                .padding(.horizontal, horizontalPadding)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .padding(.bottom, 30)
                        }
                        .padding()
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true)
        }
    }
    
}

struct NewEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(displayText: "")
    }
}
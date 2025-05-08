import SwiftUI

struct ErrorWrapper: Identifiable {
    var id = UUID()
    let message: String
}

struct HabbitHabbitsView: View {
    @StateObject var habbitHabbitsModel = HabbitHabbitsViewModel()
    @State private var currentWeekStart: Date = Date().startOfWeek()
    @State private var selectedDay: Date? = nil
    
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 52/255, green: 57/255, blue: 62/255),
                                    Color(red: 25/255, green: 26/255, blue: 27/255)],
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            .overlay {
                Image(.linesBG)
                    .resizable()
                    .ignoresSafeArea()
            }
            
            
            VStack(spacing: 20) {
                Text("Your Habits")
                    .PTBold(size: 25, color: Color(red: 255/255, green: 82/255, blue: 32/255))
                
                HStack(spacing: 15) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(1..<14, id: \.self) { offset in
                                let dayDate = Calendar.current.date(byAdding: .day, value: offset, to: currentWeekStart)!
                                let dayNumber = Calendar.current.component(.day, from: dayDate)
                                let dayLetter = dayDate.dayLetter()
                                
                                Button(action: {
                                    if selectedDay == dayDate {
                                        selectedDay = nil
                                    } else {
                                        selectedDay = dayDate
                                    }
                                }) {
                                    VStack(spacing: 4) {
                                        Text(dayLetter)
                                            .PT(size: 14, color: selectedDay == dayDate ? .white : Color(red: 97/255, green: 102/255, blue: 105/255))
                                        Text("\(dayNumber)")
                                            .PTBold(size: 16, color: selectedDay == dayDate ? .white : Color(red: 97/255, green: 102/255, blue: 105/255))
                                    }
                                    .frame(width: 60, height: 60)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(selectedDay == dayDate ? Color(red: 207/255, green: 97/255, blue: 48/255) : Color(red: 41/255, green: 43/255, blue: 46/255), lineWidth: 2)
                                    )
                                    .background(selectedDay == dayDate ? Color(red: 238/255, green: 81/255, blue: 37/255) : Color(red: 27/255, green: 30/255, blue: 32/255))
                                    .cornerRadius(30)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                VStack(spacing: 0) {
                    Rectangle()
                        .frame(height: 0.5)
                        .shadow(color: .black, radius: 5, y: 5)
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 15) {
                            Color(.clear)
                                .frame(height: 0)
                            
                            let calendar = Calendar.current
                            
                            let filteredTasks = habbitHabbitsModel.tasks
                                .filter { task in
                                    guard let start = ISO8601DateFormatter().date(from: task.dateStart),
                                          let finish = ISO8601DateFormatter().date(from: task.dateFinish) else {
                                        return false
                                    }
                                    guard let selected = selectedDay else { return true }
                                    
                                    let startDay = calendar.startOfDay(for: start)
                                    let finishDay = calendar.startOfDay(for: finish)
                                    let selectedDayStart = calendar.startOfDay(for: selected)
                                    
                                    return (selectedDayStart >= startDay && selectedDayStart <= finishDay)
                                }
                                .sorted { task1, task2 in
                                    guard let d1 = ISO8601DateFormatter().date(from: task1.dateStart),
                                          let d2 = ISO8601DateFormatter().date(from: task2.dateStart) else {
                                        return false
                                    }
                                    return d1 < d2
                                }
                            
                            ForEach(filteredTasks, id: \.id) { task in
                                Habbit(
                                    title: task.title,
                                    description: task.desc,
                                    daysPassed: habbitHabbitsModel.daysPassedSince(startDateString: task.dateStart),
                                    totalDays: habbitHabbitsModel.daysBetween(startDateString: task.dateStart, endDateString: task.dateFinish),
                                    isZeus: task.isZeus,
                                    image: task.image
                                )
                                .onTapGesture {
                                    print("dateStart:", task.dateStart)
                                    print("dateFinish:", task.dateFinish)
                                }
                            }
                            
                        }
                        
                        Color.clear
                            .frame(height: 60)
                    }
                }
            }
            
            if !UserDefaultsManager().isGuest() {
                Button(action: {
                    habbitHabbitsModel.isAdd = true
                }) {
                    Image(.addBtn)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                }
                .position(x: UIScreen.main.bounds.width / 1.12, y: UIScreen.main.bounds.height / 1.33)
            }
        }
        .fullScreenCover(isPresented: $habbitHabbitsModel.isAdd, content: {
            HabbitCreateHabbitView()
        })
        .onAppear {
            if !UserDefaultsManager().isGuest() {
                habbitHabbitsModel.fetchTasks()
            }
        }
        .alert(item: Binding(
            get: { habbitHabbitsModel.errorMessage.map { ErrorWrapper(message: $0) } },
            set: { _ in habbitHabbitsModel.errorMessage = nil }
        )) { errorWrapper in
            Alert(title: Text("Error"), message: Text(errorWrapper.message), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    HabbitHabbitsView()
}

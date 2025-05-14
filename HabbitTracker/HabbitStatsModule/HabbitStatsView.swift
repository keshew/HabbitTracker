import SwiftUI

struct HabbitStatsView: View {
    @StateObject var habbitStatsModel =  HabbitStatsViewModel()
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible())]
    
    private let dateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate]
        return formatter
    }()
    
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
                Text("Stats")
                    .PTBold(size: 25, color: Color(red: 255/255, green: 82/255, blue: 32/255))
                
                VStack(spacing: 0) {
                    Rectangle()
                        .frame(height: 0.5)
                        .shadow(color: .black, radius: 5, y: 5)
                    
                    ScrollView(showsIndicators: false) {
                        Color.clear
                            .frame(height: 10)
                        VStack(spacing: 15) {
                            LazyVGrid(columns: columns, spacing: 15) {
                                let today = Calendar.current.startOfDay(for: Date())

                                let sortedTasks = habbitStatsModel.tasks.sorted { task1, task2 in
                                    let t1Completed = task1.completedDates?.contains(where: { dateString in
                                        if let completedDate = ISO8601DateFormatter().date(from: dateString) {
                                            return Calendar.current.isDate(completedDate, inSameDayAs: today)
                                        }
                                        return false
                                    }) ?? false
                                    let t2Completed = task2.completedDates?.contains(where: { dateString in
                                        if let completedDate = ISO8601DateFormatter().date(from: dateString) {
                                            return Calendar.current.isDate(completedDate, inSameDayAs: today)
                                        }
                                        return false
                                    }) ?? false
                                    if t1Completed != t2Completed {
                                        return !t1Completed
                                    }
                                    let d1 = ISO8601DateFormatter().date(from: task1.dateStart) ?? Date.distantPast
                                    let d2 = ISO8601DateFormatter().date(from: task2.dateStart) ?? Date.distantPast
                                    return d1 < d2
                                }

                                ForEach(sortedTasks, id: \.id) { task in
                                    let isCompletedToday = task.completedDates?.contains(where: { dateString in
                                        if let completedDate = ISO8601DateFormatter().date(from: dateString) {
                                            return Calendar.current.isDate(completedDate, inSameDayAs: today)
                                        }
                                        return false
                                    }) ?? false

                                    Stats(
                                        title: task.title,
                                        daysPassed: habbitStatsModel.daysPassedSince(startDateString: task.dateStart),
                                        totalDays: habbitStatsModel.daysBetween(startDateString: task.dateStart, endDateString: task.dateFinish),
                                        isZeus: task.isZeus,
                                        image: task.secondImage
                                    )
                                    .opacity(isCompletedToday ? 0.4 : 1)
                                    .animation(.easeInOut, value: isCompletedToday)
                                    .onTapGesture {
                                        habbitStatsModel.taskModel = task
                                        habbitStatsModel.isDetail = true
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        Color.clear
                            .frame(height: 60)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $habbitStatsModel.isDetail) {
            HabbitDetailStatsView(task: habbitStatsModel.taskModel!)
        }
        
        .onAppear {
            if !UserDefaultsManager().isGuest() {
                habbitStatsModel.fetchTasks()
            }
        }
        .alert(item: Binding(
            get: { habbitStatsModel.errorMessage.map { ErrorWrapper(message: $0) } },
            set: { _ in habbitStatsModel.errorMessage = nil }
        )) { errorWrapper in
            Alert(title: Text("Error"), message: Text(errorWrapper.message), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    HabbitStatsView()
}





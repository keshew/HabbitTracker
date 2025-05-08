import SwiftUI

struct HabbitStatsView: View {
    @StateObject var habbitStatsModel =  HabbitStatsViewModel()
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible())]
 
    
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
                                ForEach(habbitStatsModel.tasks, id: \.id) { task in
                                    Stats(
                                        title: task.title,
                                        daysPassed: habbitStatsModel.daysPassedSince(startDateString: task.dateStart),
                                        totalDays: habbitStatsModel.daysBetween(startDateString: task.dateStart, endDateString: task.dateFinish),
                                        isZeus: task.isZeus,
                                        image: task.secondImage
                                    )
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


struct Stats: View {
    var title: String
    var daysPassed: Int
    var totalDays: Int
    var isZeus: Bool
    var image: String
    var body: some View {
        Rectangle()
            .fill(.white)
            .overlay {
                VStack {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                    
                    VStack(spacing: 5) {
                        Text(title)
                            .PTBold(size: 20, color: isZeus ? Color(red: 15/255, green: 66/255, blue: 124/255) :  Color(red: 87/255, green: 33/255, blue: 153/255))
                            .multilineTextAlignment(.center)
                        
                        Text("Days: \(daysPassed) / \(totalDays)")
                            .PT(size: 14, color: isZeus ? Color(red: 158/255, green: 180/255, blue: 203/255):  Color(red: 187/255, green: 166/255, blue: 214/255))
                    }
                }
            }
            .frame(width: 170, height: 230)
            .cornerRadius(20)
    }
}


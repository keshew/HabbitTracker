import SwiftUI

struct HabbitDetailStatsView: View {
    @StateObject var habbitDetailStatsModel =  HabbitDetailStatsViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var currentWeekStart: Date = Date().startOfWeek()
    @State private var selectedDay: Date? = nil
    var task: NetworkManager.Task
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
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(.backBtn)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    Text("Stats")
                        .PTBold(size: 25, color: Color(red: 255/255, green: 82/255, blue: 32/255))
                        .padding(.trailing, 70)
                    Spacer()
                }
                
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
                            Rectangle()
                                .fill(.white)
                                .overlay(content: {
                                    VStack {
                                        Image(task.secondImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 110, height: 110)
                                        
                                        VStack(spacing: 5) {
                                            Text(task.title)
                                                .PTBold(size: 20, color: task.isZeus ? Color(red: 15/255, green: 66/255, blue: 124/255) :  Color(red: 87/255, green: 33/255, blue: 153/255))
                                                .padding(.top)
                                            
                                            Text("Days: \(habbitDetailStatsModel.daysPassedSince(startDateString: task.dateStart)) / \(habbitDetailStatsModel.daysBetween(startDateString: task.dateStart, endDateString: task.dateFinish))")
                                                .PT(size: 16, color: task.isZeus ? Color(red: 158/255, green: 180/255, blue: 203/255):  Color(red: 187/255, green: 166/255, blue: 214/255))
                                        }
                                        
                                        Rectangle()
                                            .fill(Color(red: 195/255, green: 28/255, blue: 204/255))
                                            .frame(height: 0.5)
                                            .padding(.horizontal)
                                            .padding(.vertical, 5)
                                        
                                        Text("Latest Activity")
                                            .PTBold(size: 20, color: task.isZeus ? Color(red: 15/255, green: 66/255, blue: 124/255) :  Color(red: 87/255, green: 33/255, blue: 153/255))
                                        
                                        HStack(spacing: 20) {
                                            Button(action: {
                                                habbitDetailStatsModel.isDaily = true
                                                habbitDetailStatsModel.isWeekly = false
                                                habbitDetailStatsModel.isMountly = false
                                            }) {
                                                Text("Daily")
                                                    .PT(size: 18, color: habbitDetailStatsModel.isDaily ? .white : Color(red: 97/255, green: 102/255, blue: 105/255))
                                                    .padding(.horizontal, 20)
                                                    .padding(.vertical, 10)
                                                    .background(habbitDetailStatsModel.isDaily ? Color(red: 238/255, green: 81/255, blue: 37/255) : Color(red: 27/255, green: 30/255, blue: 32/255))
                                                    .cornerRadius(30)
                                                    .overlay(content: {
                                                        RoundedRectangle(cornerRadius: 30)
                                                            .stroke(habbitDetailStatsModel.isDaily ? Color(red: 207/255, green: 97/255, blue: 48/255) : Color(red: 41/255, green: 43/255, blue: 46/255), lineWidth: 2)
                                                    })
                                            }
                                            
                                            Button(action: {
                                                habbitDetailStatsModel.isDaily = false
                                                habbitDetailStatsModel.isWeekly = true
                                                habbitDetailStatsModel.isMountly = false
                                            }) {
                                                Text("Weekly")
                                                    .PT(size: 18, color: habbitDetailStatsModel.isWeekly ? .white : Color(red: 97/255, green: 102/255, blue: 105/255))
                                                    .padding(.horizontal, 20)
                                                    .padding(.vertical, 10)
                                                    .background(habbitDetailStatsModel.isWeekly ? Color(red: 238/255, green: 81/255, blue: 37/255) : Color(red: 27/255, green: 30/255, blue: 32/255))
                                                    .cornerRadius(30)
                                                    .overlay(content: {
                                                        RoundedRectangle(cornerRadius: 30)
                                                            .stroke(habbitDetailStatsModel.isWeekly ? Color(red: 207/255, green: 97/255, blue: 48/255) : Color(red: 41/255, green: 43/255, blue: 46/255), lineWidth: 2)
                                                    })
                                            }
                                            
                                            Button(action: {
                                                habbitDetailStatsModel.isDaily = false
                                                habbitDetailStatsModel.isWeekly = false
                                                habbitDetailStatsModel.isMountly = true
                                            }) {
                                                Text("Mountly")
                                                    .PT(size: 18, color: habbitDetailStatsModel.isMountly ? .white : Color(red: 97/255, green: 102/255, blue: 105/255))
                                                    .padding(.horizontal, 20)
                                                    .padding(.vertical, 10)
                                                    .background(habbitDetailStatsModel.isMountly ? Color(red: 238/255, green: 81/255, blue: 37/255) : Color(red: 27/255, green: 30/255, blue: 32/255))
                                                    .cornerRadius(30)
                                                    .overlay(content: {
                                                        RoundedRectangle(cornerRadius: 30)
                                                            .stroke(habbitDetailStatsModel.isMountly ? Color(red: 207/255, green: 97/255, blue: 48/255) : Color(red: 41/255, green: 43/255, blue: 46/255), lineWidth: 2)
                                                    })
                                            }
                                        }
                                        
                                        Spacer()
                                        
                                        let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
                                        let activityValues: [Double] = daysOfWeek.map { day in
                                            Double(task.activity[day] ?? "0") ?? 0
                                        }
                                        
                                        WeekBarChartView(values: activityValues, days: daysOfWeek, isZeus: task.isZeus)
                                        
                                        
                                        HStack {
                                            Text("Latest Activity")
                                                .PTBold(size: 20, color: task.isZeus ? Color(red: 15/255, green: 66/255, blue: 124/255) :  Color(red: 87/255, green: 33/255, blue: 153/255))
                                                .padding(.leading)
                                            
                                            Spacer()
                                        }
                                        
                                        Rectangle()
                                            .fill(task.isZeus ? LinearGradient(colors: [Color(red: 25/255, green: 103/255, blue: 202/255), Color(red: 73/255, green: 204/255, blue: 229/255)], startPoint: .leading, endPoint: .trailing) : LinearGradient(colors: [Color(red: 142/255, green: 73/255, blue: 228/255), Color(red: 199/255, green: 27/255, blue: 201/255)], startPoint: .leading, endPoint: .trailing))
                                            .overlay {
                                                HStack {
                                                    VStack(alignment: .leading) {
                                                        Text(task.desc)
                                                            .PTBold(size: 20)
                                                        
                                                        Text("About 3 minutes ago")
                                                            .PT(size: 16, color: task.isZeus ? Color(red: 158/255, green: 180/255, blue: 203/255):  Color(red: 187/255, green: 166/255, blue: 214/255))
                                                    }
                                                    .padding(.leading)
                                                    
                                                    Spacer()
                                                }
                                            }
                                            .frame(height: 80)
                                            .cornerRadius(20)
                                            .padding(.horizontal)
                                    }
                                    .padding(.vertical)
                                })
                                .frame(height: 610)
                                .cornerRadius(20)
                                .padding(.horizontal)
                                .padding(.top, 10)
                        }
                        
                        Color.clear
                            .frame(height: 40)
                    }
                }
            }
        }
    }
}

#Preview {
    HabbitDetailStatsView(task: NetworkManager.Task(id: "", title: "", desc: "", image: "", secondImage: "", dateStart: "", dateFinish: "", reminder: "", timer: "", repeatDays: [""], isZeus: false, activity: ["":""]))
}

import SwiftUI

struct WeekBarChartView: View {
    let values: [Double]
    let days: [String]
    var isZeus: Bool

    var body: some View {
        VStack {
            HStack(alignment: .bottom, spacing: 18) {
                ForEach(0..<values.count, id: \.self) { index in
                    VStack {
                        let height = min(values[index] * 10, 90)
                        Rectangle()
                            .fill(isZeus
                                  ? LinearGradient(colors: [Color(red: 25/255, green: 103/255, blue: 202/255), Color(red: 73/255, green: 204/255, blue: 229/255)], startPoint: .bottom, endPoint: .top)
                                  : LinearGradient(colors: [Color(red: 142/255, green: 73/255, blue: 228/255), Color(red: 199/255, green: 27/255, blue: 201/255)], startPoint: .bottom, endPoint: .top))
                            .frame(width: 30, height: height)
                            .cornerRadius(5)
                        Text(days[index])
                            .font(.caption)
                            .foregroundColor(isZeus ? Color(red: 158/255, green: 180/255, blue: 203/255) : Color(red: 187/255, green: 166/255, blue: 214/255))
                            .frame(height: 20)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
    }
}


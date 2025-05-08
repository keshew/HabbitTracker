import SwiftUI

struct HabbitCreateHabbitView: View {
    @StateObject var habbitCreateHabbitModel =  HabbitCreateHabbitViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedDays: Set<Int> = []
    let days = ["S", "M", "T", "W", "T", "F", "S"]
    
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
            
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack(spacing: 10) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(.backBtn)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                        }
                        .padding(.leading)
                        
                        Text("Settings")
                            .PTBold(size: 22, color: Color(red: 237/255, green: 82/255, blue: 39/255))
                        
                        Spacer()
                    }
                    
                    VStack(spacing: 10) {
                        VStack(spacing: 15) {
                            CustomTextFiled(text: $habbitCreateHabbitModel.name, placeholder: "Habit Name")
                            
                            CustomTextFiled(text: $habbitCreateHabbitModel.desc, placeholder: "Habit Description")
                        }
                        
                        HStack(spacing: 45) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Start")
                                    .PT(size: 20)
                                
                                DateTF2(date: $habbitCreateHabbitModel.dateFinish)
                            }
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Finish")
                                    .PT(size: 20)
                                
                                DateTF(date: $habbitCreateHabbitModel.dateStart, secondDate: $habbitCreateHabbitModel.dateFinish)
                            }
                        }
                        .padding(.top)
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Reminder")
                                    .PT(size: 20)
                                
                                HStack(spacing: 30) {
                                    Button(action: {
                                        habbitCreateHabbitModel.isDaily = true
                                        habbitCreateHabbitModel.isWeekly = false
                                        habbitCreateHabbitModel.isMountly = false
                                    }) {
                                        Text("Daily")
                                            .PT(size: 18, color: habbitCreateHabbitModel.isDaily ? .white : Color(red: 97/255, green: 102/255, blue: 105/255))
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 13)
                                            .background(habbitCreateHabbitModel.isDaily ? Color(red: 238/255, green: 81/255, blue: 37/255) : Color(red: 27/255, green: 30/255, blue: 32/255))
                                            .cornerRadius(30)
                                            .overlay(content: {
                                                RoundedRectangle(cornerRadius: 30)
                                                    .stroke(habbitCreateHabbitModel.isDaily ? Color(red: 207/255, green: 97/255, blue: 48/255) : Color(red: 41/255, green: 43/255, blue: 46/255), lineWidth: 2)
                                            })
                                    }
                                    
                                    Button(action: {
                                        habbitCreateHabbitModel.isDaily = false
                                        habbitCreateHabbitModel.isWeekly = true
                                        habbitCreateHabbitModel.isMountly = false
                                    }) {
                                        Text("Weekly")
                                            .PT(size: 18, color: habbitCreateHabbitModel.isWeekly ? .white : Color(red: 97/255, green: 102/255, blue: 105/255))
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 13)
                                            .background(habbitCreateHabbitModel.isWeekly ? Color(red: 238/255, green: 81/255, blue: 37/255) : Color(red: 27/255, green: 30/255, blue: 32/255))
                                            .cornerRadius(30)
                                            .overlay(content: {
                                                RoundedRectangle(cornerRadius: 30)
                                                    .stroke(habbitCreateHabbitModel.isWeekly ? Color(red: 207/255, green: 97/255, blue: 48/255) : Color(red: 41/255, green: 43/255, blue: 46/255), lineWidth: 2)
                                            })
                                    }
                                    
                                    Button(action: {
                                        habbitCreateHabbitModel.isDaily = false
                                        habbitCreateHabbitModel.isWeekly = false
                                        habbitCreateHabbitModel.isMountly = true
                                    }) {
                                        Text("Mountly")
                                            .PT(size: 18, color: habbitCreateHabbitModel.isMountly ? .white : Color(red: 97/255, green: 102/255, blue: 105/255))
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 13)
                                            .background(habbitCreateHabbitModel.isMountly ? Color(red: 238/255, green: 81/255, blue: 37/255) : Color(red: 27/255, green: 30/255, blue: 32/255))
                                            .cornerRadius(30)
                                            .overlay(content: {
                                                RoundedRectangle(cornerRadius: 30)
                                                    .stroke(habbitCreateHabbitModel.isMountly ? Color(red: 207/255, green: 97/255, blue: 48/255) : Color(red: 41/255, green: 43/255, blue: 46/255), lineWidth: 2)
                                            })
                                    }
                                }
                            }
                        }
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Repeat days")
                                    .PT(size: 20)
                                
                                HStack {
                                    HStack(spacing: 20) {
                                        ForEach(0..<days.count, id: \.self) { index in
                                            Button(action: {
                                                if selectedDays.contains(index) {
                                                    selectedDays.remove(index)
                                                } else {
                                                    selectedDays.insert(index)
                                                }
                                            }) {
                                                Text(days[index])
                                                    .PT(size: 14, color: selectedDays.contains(index) ? .white : Color(red: 97/255, green: 102/255, blue: 105/255))
                                                    .foregroundColor(selectedDays.contains(index) ? .white : Color(red: 97/255, green: 102/255, blue: 105/255))
                                                    .frame(width: 30, height: 30)
                                                    .background(selectedDays.contains(index) ? Color(red: 238/255, green: 81/255, blue: 37/255) : Color(red: 27/255, green: 30/255, blue: 32/255))
                                                    .cornerRadius(25)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 25)
                                                            .stroke(selectedDays.contains(index) ? Color(red: 207/255, green: 97/255, blue: 48/255) : Color(red: 41/255, green: 43/255, blue: 46/255), lineWidth: 2)
                                                    )
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Set reminder timer")
                                    .PT(size: 20)
                                
                                TimeTF(time: $habbitCreateHabbitModel.time, width: 330)
                            }
                        }
                        
                        HStack {
                            Button(action: {
                                habbitCreateHabbitModel.isZeus = true
                                habbitCreateHabbitModel.isMarco = false
                            }) {
                                Image(habbitCreateHabbitModel.isZeus ? .zeusPicked : .zeusUnp)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 170, height: 100)
                            }
                            
                            Button(action: {
                                habbitCreateHabbitModel.isMarco = true
                                habbitCreateHabbitModel.isZeus = false
                            }) {
                                Image(habbitCreateHabbitModel.isMarco ? .marcoPicked : .marcoUnp)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 170, height: 100)
                            }
                        }
                    }
                    
                    Button(action: {
                        habbitCreateHabbitModel.setTaskForUser(selectedDays: selectedDays)
                    }) {
                        Rectangle()
                            .fill(Color(red: 238/255, green: 81/255, blue: 37/255))
                            .overlay {
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color(red: 209/255, green: 97/255, blue: 49/255) ,lineWidth: 2)
                                    .overlay {
                                        HStack {
                                            Text("Next")
                                                .PTBold(size: 22)
                                            
                                            Image(.play)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 20, height: 20)
                                        }
                                    }
                            }
                            .frame(height: 60)
                            .cornerRadius(30)
                            .padding(.horizontal, 35)
                            .padding(.top, 25)
                    }
                }
            }
        }
        .alert(isPresented: $habbitCreateHabbitModel.showAlert) {
            Alert(title: Text("Info"), message: Text(habbitCreateHabbitModel.alertMessage), dismissButton: .default(Text("OK")))
        }
        .fullScreenCover(isPresented: $habbitCreateHabbitModel.isDissmss) {
            HabbitTabBarView()
        }
    }
}

#Preview {
    HabbitCreateHabbitView()
}


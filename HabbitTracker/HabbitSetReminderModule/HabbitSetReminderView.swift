import SwiftUI

struct HabbitSetReminderView: View {
    @StateObject var habbitSetReminderModel =  HabbitSetReminderViewModel()
    @Binding var isZeus: Bool
    @Binding var desc: String
    @Binding var title: String
    @Binding var image: String
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
                    Text("Set a reminder")
                        .PTBold(size: 22, color: Color(red: 237/255, green: 82/255, blue: 39/255))
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                    
                    Spacer(minLength: 50)
                    
                    if isZeus {
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 73/255, green: 204/255, blue: 229/225),
                                                          Color(red: 25/255, green: 103/255, blue: 202/225)], startPoint: .top, endPoint: .bottom))
                            .frame(height: 600)
                            .cornerRadius(40)
                            .overlay {
                                VStack {
                                    Image(.zeusHabbit)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 340, height: 340)
                                    
                                    VStack {
                                        Rectangle()
                                            .fill(.white)
                                            .frame(height: 380)
                                            .cornerRadius(40)
                                            .padding(.horizontal)
                                            .overlay {
                                                VStack {
                                                    HStack {
                                                        VStack(alignment: .leading, spacing: 10) {
                                                            Text("Start")
                                                                .PT(size: 20, color: Color(red: 15/255, green: 66/255, blue: 124/255))
                                                            
                                                            DateTF2(date: $habbitSetReminderModel.dateFinish)
                                                            
                                                        }
                                                        
                                                        VStack(alignment: .leading, spacing: 10) {
                                                            Text("Finish")
                                                                .PT(size: 20, color: Color(red: 15/255, green: 66/255, blue: 124/255))
                                                            
                                                            DateTF(date: $habbitSetReminderModel.dateStart, secondDate: $habbitSetReminderModel.dateFinish)
                                                        }
                                                    }
                                                    
                                                    HStack {
                                                        VStack(alignment: .leading, spacing: 10) {
                                                            Text("Reminder")
                                                                .PT(size: 20, color: Color(red: 15/255, green: 66/255, blue: 124/255))
                                                            
                                                            HStack {
                                                                Button(action: {
                                                                    habbitSetReminderModel.isDaily = true
                                                                    habbitSetReminderModel.isWeekly = false
                                                                    habbitSetReminderModel.isMountly = false
                                                                }) {
                                                                    Text("Daily")
                                                                        .PT(size: 18, color: habbitSetReminderModel.isDaily ? .white : Color(red: 97/255, green: 102/255, blue: 105/255))
                                                                        .padding(.horizontal, 20)
                                                                        .padding(.vertical, 13)
                                                                        .background(habbitSetReminderModel.isDaily ? Color(red: 238/255, green: 81/255, blue: 37/255) : Color(red: 27/255, green: 30/255, blue: 32/255))
                                                                        .cornerRadius(30)
                                                                        .overlay(content: {
                                                                            RoundedRectangle(cornerRadius: 30)
                                                                                .stroke(habbitSetReminderModel.isDaily ? Color(red: 207/255, green: 97/255, blue: 48/255) : Color(red: 41/255, green: 43/255, blue: 46/255), lineWidth: 2)
                                                                        })
                                                                }
                                                                
                                                                Button(action: {
                                                                    habbitSetReminderModel.isDaily = false
                                                                    habbitSetReminderModel.isWeekly = true
                                                                    habbitSetReminderModel.isMountly = false
                                                                }) {
                                                                    Text("Weekly")
                                                                        .PT(size: 18, color: habbitSetReminderModel.isWeekly ? .white : Color(red: 97/255, green: 102/255, blue: 105/255))
                                                                        .padding(.horizontal, 20)
                                                                        .padding(.vertical, 13)
                                                                        .background(habbitSetReminderModel.isWeekly ? Color(red: 238/255, green: 81/255, blue: 37/255) : Color(red: 27/255, green: 30/255, blue: 32/255))
                                                                        .cornerRadius(30)
                                                                        .overlay(content: {
                                                                            RoundedRectangle(cornerRadius: 30)
                                                                                .stroke(habbitSetReminderModel.isWeekly ? Color(red: 207/255, green: 97/255, blue: 48/255) : Color(red: 41/255, green: 43/255, blue: 46/255), lineWidth: 2)
                                                                        })
                                                                }
                                                                
                                                                Button(action: {
                                                                    habbitSetReminderModel.isDaily = false
                                                                    habbitSetReminderModel.isWeekly = false
                                                                    habbitSetReminderModel.isMountly = true
                                                                }) {
                                                                    Text("Mountly")
                                                                        .PT(size: 18, color: habbitSetReminderModel.isMountly ? .white : Color(red: 97/255, green: 102/255, blue: 105/255))
                                                                        .padding(.horizontal, 20)
                                                                        .padding(.vertical, 13)
                                                                        .background(habbitSetReminderModel.isMountly ? Color(red: 238/255, green: 81/255, blue: 37/255) : Color(red: 27/255, green: 30/255, blue: 32/255))
                                                                        .cornerRadius(30)
                                                                        .overlay(content: {
                                                                            RoundedRectangle(cornerRadius: 30)
                                                                                .stroke(habbitSetReminderModel.isMountly ? Color(red: 207/255, green: 97/255, blue: 48/255) : Color(red: 41/255, green: 43/255, blue: 46/255), lineWidth: 2)
                                                                        })
                                                                }
                                                            }
                                                        }
                                                    }
                                                    
                                                    HStack {
                                                        VStack(alignment: .leading, spacing: 10) {
                                                            Text("Repeat days")
                                                                .PT(size: 20, color: Color(red: 15/255, green: 66/255, blue: 124/255))
                                                            
                                                            HStack {
                                                                HStack(spacing: 13) {
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
                                                                .PT(size: 20, color: Color(red: 15/255, green: 66/255, blue: 124/255))
                                                            
                                                            TimeTF(time: $habbitSetReminderModel.time)
                                                        }
                                                    }
                                                }
                                            }
                                    }
                                    .offset(y: -80)
                                }
                                .offset(y: 0)
                            }
                            .padding(.horizontal)
                    } else {
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 142/255, green: 73/255, blue: 228/225),
                                                          Color(red: 199/255, green: 27/255, blue: 201/225)], startPoint: .top, endPoint: .bottom))
                            .frame(height: 600)
                            .cornerRadius(40)
                            .overlay {
                                VStack {
                                    Image(.marcoHabbit)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 340, height: 340)
                                    
                                    VStack {
                                        Rectangle()
                                            .fill(.white)
                                            .frame(height: 380)
                                            .cornerRadius(40)
                                            .padding(.horizontal)
                                            .overlay {
                                                VStack {
                                                    HStack {
                                                        VStack(alignment: .leading, spacing: 10) {
                                                            Text("Start")
                                                                .PT(size: 20, color: Color(red: 15/255, green: 66/255, blue: 124/255))
                                                            
                                                            DateTF2(date: $habbitSetReminderModel.dateFinish)
                                                            
                                                        }
                                                        
                                                        VStack(alignment: .leading, spacing: 10) {
                                                            Text("Finish")
                                                                .PT(size: 20, color: Color(red: 15/255, green: 66/255, blue: 124/255))
                                                            
                                                            DateTF(date: $habbitSetReminderModel.dateStart, secondDate: $habbitSetReminderModel.dateFinish)
                                                        }
                                                    }
                                                    
                                                    HStack {
                                                        VStack(alignment: .leading, spacing: 10) {
                                                            Text("Reminder")
                                                                .PT(size: 20, color: Color(red: 15/255, green: 66/255, blue: 124/255))
                                                            
                                                            HStack {
                                                                Button(action: {
                                                                    habbitSetReminderModel.isDaily = true
                                                                    habbitSetReminderModel.isWeekly = false
                                                                    habbitSetReminderModel.isMountly = false
                                                                }) {
                                                                    Text("Daily")
                                                                        .PT(size: 18, color: habbitSetReminderModel.isDaily ? .white : Color(red: 97/255, green: 102/255, blue: 105/255))
                                                                        .padding(.horizontal, 20)
                                                                        .padding(.vertical, 13)
                                                                        .background(habbitSetReminderModel.isDaily ? Color(red: 238/255, green: 81/255, blue: 37/255) : Color(red: 27/255, green: 30/255, blue: 32/255))
                                                                        .cornerRadius(30)
                                                                        .overlay(content: {
                                                                            RoundedRectangle(cornerRadius: 30)
                                                                                .stroke(habbitSetReminderModel.isDaily ? Color(red: 207/255, green: 97/255, blue: 48/255) : Color(red: 41/255, green: 43/255, blue: 46/255), lineWidth: 2)
                                                                        })
                                                                }
                                                                
                                                                Button(action: {
                                                                    habbitSetReminderModel.isDaily = false
                                                                    habbitSetReminderModel.isWeekly = true
                                                                    habbitSetReminderModel.isMountly = false
                                                                }) {
                                                                    Text("Weekly")
                                                                        .PT(size: 18, color: habbitSetReminderModel.isWeekly ? .white : Color(red: 97/255, green: 102/255, blue: 105/255))
                                                                        .padding(.horizontal, 20)
                                                                        .padding(.vertical, 13)
                                                                        .background(habbitSetReminderModel.isWeekly ? Color(red: 238/255, green: 81/255, blue: 37/255) : Color(red: 27/255, green: 30/255, blue: 32/255))
                                                                        .cornerRadius(30)
                                                                        .overlay(content: {
                                                                            RoundedRectangle(cornerRadius: 30)
                                                                                .stroke(habbitSetReminderModel.isWeekly ? Color(red: 207/255, green: 97/255, blue: 48/255) : Color(red: 41/255, green: 43/255, blue: 46/255), lineWidth: 2)
                                                                        })
                                                                }
                                                                
                                                                Button(action: {
                                                                    habbitSetReminderModel.isDaily = false
                                                                    habbitSetReminderModel.isWeekly = false
                                                                    habbitSetReminderModel.isMountly = true
                                                                }) {
                                                                    Text("Mountly")
                                                                        .PT(size: 18, color: habbitSetReminderModel.isMountly ? .white : Color(red: 97/255, green: 102/255, blue: 105/255))
                                                                        .padding(.horizontal, 20)
                                                                        .padding(.vertical, 13)
                                                                        .background(habbitSetReminderModel.isMountly ? Color(red: 238/255, green: 81/255, blue: 37/255) : Color(red: 27/255, green: 30/255, blue: 32/255))
                                                                        .cornerRadius(30)
                                                                        .overlay(content: {
                                                                            RoundedRectangle(cornerRadius: 30)
                                                                                .stroke(habbitSetReminderModel.isMountly ? Color(red: 207/255, green: 97/255, blue: 48/255) : Color(red: 41/255, green: 43/255, blue: 46/255), lineWidth: 2)
                                                                        })
                                                                }
                                                            }
                                                        }
                                                    }
                                                    
                                                    HStack {
                                                        VStack(alignment: .leading, spacing: 10) {
                                                            Text("Repeat days")
                                                                .PT(size: 20, color: Color(red: 15/255, green: 66/255, blue: 124/255))
                                                            
                                                            HStack {
                                                                HStack(spacing: 13) {
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
                                                                .PT(size: 20, color: Color(red: 15/255, green: 66/255, blue: 124/255))
                                                            
                                                            TimeTF(time: $habbitSetReminderModel.time)
                                                        }
                                                    }
                                                }
                                            }
                                    }
                                    .offset(y: -80)
                                }
                                .offset(y: 0)
                            }
                            .padding(.horizontal)
                    }
                    
                    Button(action: {
                        habbitSetReminderModel.setTaskForUser(name: title, desc: desc, image: image, isZeus: isZeus, selectedDays: selectedDays)
                    }) {
                        Rectangle()
                            .fill(Color(red: 238/255, green: 81/255, blue: 37/255))
                            .overlay {
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color(red: 209/255, green: 97/255, blue: 49/255) ,lineWidth: 2)
                                    .overlay {
                                        Text("Set")
                                            .PTBold(size: 22)
                                    }
                            }
                            .frame(height: 60)
                            .cornerRadius(30)
                            .padding(.horizontal, 30)
                            .padding(.top)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $habbitSetReminderModel.isTabbar) {
            HabbitTabBarView()
        }
        
        .alert(isPresented: $habbitSetReminderModel.showAlert) {
            Alert(title: Text("Info"), message: Text(habbitSetReminderModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    HabbitSetReminderView(isZeus: .constant(false), desc: .constant(""), title: .constant(""), image: .constant(""))
}

struct TimeTF: View {
    @Binding var time: Date
    var width: CGFloat = 290
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(time == Date(timeIntervalSince1970: 0) ? Color(red: 27/255, green: 30/255, blue: 32/255) : Color(red: 238/255, green: 81/255, blue: 37/255))
                    .frame(width: width, height: 52)
                    .cornerRadius(30)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(time == Date(timeIntervalSince1970: 0) ? Color(red: 41/255, green: 43/255, blue: 46/255) : Color(red: 207/255, green: 97/255, blue: 48/255), lineWidth: 2)
                    })
                HStack {
                    if time.timeIntervalSince1970 == 0 {
                        Text("Choose time")
                            .PT(size: 18, color: Color(red: 97/255, green: 102/255, blue: 105/255))
                    } else {
                        Text(time.formatted(date: .omitted, time: .shortened))
                            .PT(size: 18, color: .white)
                    }
                }
                .padding(.horizontal)
                
                DatePicker(
                    "Time",
                    selection: $time,
                    displayedComponents: [.hourAndMinute]
                )
                .datePickerStyle(.compact)
                .colorMultiply(.clear)
                .frame(width: width, height: 52)
                
            }
            .labelsHidden()
            .frame(width: width, height: 52)
        }
    }
}

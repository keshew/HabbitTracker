import SwiftUI

struct CustomTextFiled: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var placeholder: String
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                TextField("", text: $text, onEditingChanged: { isEditing in
                    if !isEditing {
                        isTextFocused = false
                    }
                })
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .padding(.horizontal, 16)
                .frame(height: 47)
                .font(.custom("FuturaPT-Medium", size: 18))
                .cornerRadius(9)
                .foregroundStyle(.white)
                .focused($isTextFocused)
                .padding(.horizontal, 15)
                
                Rectangle()
                    .fill(Color(red: 97/255, green: 102/255, blue: 105/255))
                    .frame(height: 0.5)
                    .cornerRadius(12)
                    .padding(.horizontal, 30)
            }
          
            
            if text.isEmpty && !isTextFocused {
                Text(placeholder)
                    .PT(size: 16, color: Color(red: 97/255, green: 102/255, blue: 105/255))
                    .frame(height: 47)
                    .onTapGesture {
                        isTextFocused = true
                    }
            }
        }
    }
}

struct CustomSecureFiled: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var placeholder: String
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                SecureField("", text: $text)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal, 16)
                    .frame(height: 47)
                    .font(.custom("FuturaPT-Medium", size: 18))
                    .cornerRadius(9)
                    .foregroundStyle(.white)
                    .focused($isTextFocused)
                    .padding(.horizontal, 15)
                
                Rectangle()
                    .fill(Color(red: 97/255, green: 102/255, blue: 105/255))
                    .frame(height: 0.5)
                    .cornerRadius(12)
                    .padding(.horizontal, 30)
            }
            
            if text.isEmpty && !isTextFocused {
                Text(placeholder)
                    .PT(size: 16, color: Color(red: 97/255, green: 102/255, blue: 105/255))
                    .frame(height: 47)
                    .onTapGesture {
                        isTextFocused = true
                    }
            }
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: TabType
    
    enum TabType: Int {
        case Habits
        case Stats
        case Profile
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .fill(Color(red: 238/255, green: 81/255, blue: 37/255))
                .frame(height: 100)
                .edgesIgnoringSafeArea(.bottom)
                .offset(y: 35)
            
            HStack(spacing: 0) {
                TabBarItem(imageName: "tab1", tab: .Habits, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab2", tab: .Stats, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab3", tab: .Profile, selectedTab: $selectedTab)
            }
            .padding(.top, 15)
            .frame(height: 60)
        }
    }
}

struct TabBarItem: View {
    let imageName: String
    let tab: CustomTabBar.TabType
    @Binding var selectedTab: CustomTabBar.TabType
    
    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack(spacing: 8) {
                Image(selectedTab == tab ? imageName + "Picked" : imageName)
                    .resizable()
                    .frame(width: 27, height: 24)
                    .opacity(selectedTab == tab ? 1 : 0.4)
                
                Text("\(tab)")
                    .PT(size: 12, color: selectedTab == tab ? .white : Color(red: 156/255, green: 47/255, blue: 18/255))
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct DateTF: View {
    @Binding var date: Date
    @Binding var secondDate: Date
    @State private var selectedDate: Date = Date()
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(date == Date(timeIntervalSince1970: 0) ? Color(red: 27/255, green: 30/255, blue: 32/255) : Color(red: 238/255, green: 81/255, blue: 37/255))
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(date == Date(timeIntervalSince1970: 0) ? Color(red: 41/255, green: 43/255, blue: 46/255) : Color(red: 207/255, green: 97/255, blue: 48/255), lineWidth: 2)
                    })
                    .frame(width: 145, height: 54)
                    .cornerRadius(30)
                
                HStack {
                    if date.timeIntervalSince1970 == 0 {
                        Text("Choose Date")
                            .PT(size: 18, color: Color(red: 97/255, green: 102/255, blue: 105/255))
                    } else {
                        Text(formattedDate(date: date))
                            .PT(size: 18, color: .white)
                    }
                }
                .padding(.horizontal)
                
                DatePicker(
                    "Date",
                    selection: $date,
                    in: secondDate...,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.compact)
                .colorMultiply(.clear)
                .frame(width: 145, height: 54)
                .onChange(of: date, perform: { newDate in
                    selectedDate = newDate
                })
               
            }
            .labelsHidden()
            .frame(width: 145, height: 54)
        }
        .disabled(secondDate == Date(timeIntervalSince1970: 0))
    }
    
    func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
}

struct DateTF2: View {
    @Binding var date: Date
    @State private var selectedDate: Date = Date()
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(date == Date(timeIntervalSince1970: 0) ? Color(red: 27/255, green: 30/255, blue: 32/255) : Color(red: 238/255, green: 81/255, blue: 37/255))
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(date == Date(timeIntervalSince1970: 0) ? Color(red: 41/255, green: 43/255, blue: 46/255) : Color(red: 207/255, green: 97/255, blue: 48/255), lineWidth: 2)
                    })
                    .frame(width: 145, height: 54)
                    .cornerRadius(30)
                
                HStack {
                    if date.timeIntervalSince1970 == 0 {
                        Text("Choose Date")
                            .PT(size: 18, color: Color(red: 97/255, green: 102/255, blue: 105/255))
                    } else {
                        Text(formattedDate(date: date))
                            .PT(size: 18, color: .white)
                    }
                }
                .padding(.horizontal)
                
                DatePicker(
                    "Date",
                    selection: $date,
                    in: Date()...,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.compact)
                .colorMultiply(.clear)
                .frame(width: 145, height: 54)
                .onChange(of: date, perform: { newDate in
                    selectedDate = newDate
                })
               
            }
            .labelsHidden()
            .frame(width: 145, height: 54)
        }
    }
    
    func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
}

extension Date {
    func startOfWeek() -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        return calendar.date(from: components) ?? self
    }
    
    func dayLetter() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "E"
        let dayName = formatter.string(from: self)
        return dayName
    }
}

struct Habbit: View {
    var title: String
    var description: String
    var daysPassed: Int
    var totalDays: Int
    var isZeus: Bool
    var image: String
    
    var body: some View {
        Rectangle()
            .fill(.white)
            .overlay {
                HStack(spacing: 15) {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                    
                    VStack(alignment: .leading) {
                        Text(title)
                            .PTBold(size: 20, color: isZeus ? Color(red: 15/255, green: 66/255, blue: 124/255) :  Color(red: 87/255, green: 33/255, blue: 153/255))
                        
                        Text(description)
                            .PT(size: 18, color: isZeus ? Color(red: 15/255, green: 66/255, blue: 124/255) : Color(red: 87/255, green: 33/255, blue: 153/255))
                            .lineLimit(1)
                        
                        Text("Days: \(daysPassed) / \(totalDays)")
                            .PT(size: 12, color: isZeus ? Color(red: 158/255, green: 180/255, blue: 203/255):  Color(red: 187/255, green: 166/255, blue: 214/255))
                    }
                    
                    Spacer()
                }
                .padding(.leading)
            }
            .frame(height: 90)
            .cornerRadius(20)
            .padding(.horizontal)
    }
}

struct FirstHabbit: View {
    var image: String
    var title: String
    var desc: String
    var body: some View {
        Rectangle()
            .fill(.white)
            .overlay {
                HStack(spacing: 15) {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                    
                    VStack(alignment: .leading) {
                        Text(title)
                            .PTBold(size: 20, color: Color(red: 15/255, green: 66/255, blue: 124/255))
                        
                        Text(desc)
                            .PT(size: 16, color: Color(red: 15/255, green: 66/255, blue: 124/255))
                    }
                    
                    Spacer()
                }
                .padding(.leading)
            }
            .frame(height: 90)
            .cornerRadius(20)
            .padding(.horizontal)
    }
}

struct Stats: View {
    var title: String
    var daysPassed: Int
    var totalDays: Int
    var isZeus: Bool
    var image: String

    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    var body: some View {
        Rectangle()
            .fill(.white)
            .overlay {
                VStack {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: screenWidth * 0.2985, height: screenHeight * 0.1372)
                    
                    VStack(spacing: 5) {
                        Text(title)
                            .PTBold(size: 20, color: isZeus ? Color(red: 15/255, green: 66/255, blue: 124/255) :  Color(red: 87/255, green: 33/255, blue: 153/255))
                            .multilineTextAlignment(.center)
                        
                        Text("Days: \(daysPassed) / \(totalDays)")
                            .PT(size: 14, color: isZeus ? Color(red: 158/255, green: 180/255, blue: 203/255):  Color(red: 187/255, green: 166/255, blue: 214/255))
                    }
                }
            }
            .frame(width: screenWidth * 0.4229, height: screenHeight * 0.2631)
            .cornerRadius(20)
    }
}


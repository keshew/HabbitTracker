import SwiftUI

struct HabbitRemindView: View {
    @StateObject var habbitRemindModel =  HabbitRemindViewModel()
    var isZeus: Bool
    @AppStorage("isTask") private var isTask = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8).ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    
                    Spacer(minLength: 250)
                    
                    if isZeus {
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 73/255, green: 204/255, blue: 229/225),
                                                          Color(red: 25/255, green: 103/255, blue: 202/225)], startPoint: .top, endPoint: .bottom))
                            .frame(height: 500)
                            .cornerRadius(40)
                            .overlay {
                                VStack {
                                    Image(.zeusReminder)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 380, height: 380)
                                    
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text("Zeusar")
                                                .PTBold(size: 27)
                                            
                                            Text("“Time to complete a habit, hero!”")
                                                .PT(size: 20)
                                        }
                                        .padding(.leading, 30)
                                        
                                        Spacer()
                                    }
                                    .padding(.top)
                                    
                                    VStack(spacing: 15) {
                                        Button(action: {
                                            isTask = false
                                        }) {
                                            Rectangle()
                                                .fill(Color(red: 238/255, green: 81/255, blue: 37/255))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 30)
                                                        .stroke(Color(red: 209/255, green: 97/255, blue: 49/255) ,lineWidth: 2)
                                                        .overlay {
                                                            Text("Done")
                                                                .PTBold(size: 22)
                                                        }
                                                }
                                                .frame(height: 60)
                                                .cornerRadius(30)
                                                .padding(.horizontal, 30)
                                        }
                                        
                                        
                                        Button(action: {
                                            isTask = false
                                        }) {
                                            Rectangle()
                                                .fill(Color(red: 27/255, green: 30/255, blue: 32/255))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 30)
                                                        .stroke(Color(red: 46/255, green: 52/255, blue: 55/255) ,lineWidth: 2)
                                                        .overlay {
                                                            Text("Later")
                                                                .PT(size: 22)
                                                        }
                                                }
                                                .frame(height: 60)
                                                .cornerRadius(30)
                                                .padding(.horizontal, 30)
                                                .shadow(color: .white.opacity(0.1), radius: 6, x: -6)
                                        }
                                    }
                                    .padding(.top)
                                }
                                .offset(y: -80)
                            }
                            .padding(.horizontal)
                    } else {
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 142/255, green: 73/255, blue: 228/225),
                                                          Color(red: 199/255, green: 27/255, blue: 201/225)], startPoint: .top, endPoint: .bottom))
                            .frame(height: 500)
                            .cornerRadius(40)
                            .overlay {
                                VStack {
                                    Image(.marcoReminder)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 380, height: 380)
                                    
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text("Marco")
                                                .PTBold(size: 27)
                                            
                                            Text("“Time to complete a habit, wildy!”")
                                                .PT(size: 20)
                                        }
                                        .padding(.leading, 30)
                                        
                                        Spacer()
                                    }
                                    .padding(.top)
                                    
                                    VStack(spacing: 15) {
                                        Button(action: {
                                            isTask = false
                                        }) {
                                            Rectangle()
                                                .fill(Color(red: 238/255, green: 81/255, blue: 37/255))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 30)
                                                        .stroke(Color(red: 209/255, green: 97/255, blue: 49/255) ,lineWidth: 2)
                                                        .overlay {
                                                            Text("Done")
                                                                .PTBold(size: 22)
                                                        }
                                                }
                                                .frame(height: 60)
                                                .cornerRadius(30)
                                                .padding(.horizontal, 30)
                                        }
                                        
                                        
                                        Button(action: {
                                            isTask = false
                                        }) {
                                            Rectangle()
                                                .fill(Color(red: 27/255, green: 30/255, blue: 32/255))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 30)
                                                        .stroke(Color(red: 46/255, green: 52/255, blue: 55/255) ,lineWidth: 2)
                                                        .overlay {
                                                            Text("Later")
                                                                .PT(size: 22)
                                                        }
                                                }
                                                .frame(height: 60)
                                                .cornerRadius(30)
                                                .padding(.horizontal, 30)
                                                .shadow(color: .white.opacity(0.1), radius: 6, x: -6)
                                        }
                                    }
                                    .padding(.top)
                                }
                                .offset(y: -80)
                            }
                            .padding(.horizontal)
                    }
                }
            }
        }
    }
}

#Preview {
    HabbitRemindView(isZeus: false)
}


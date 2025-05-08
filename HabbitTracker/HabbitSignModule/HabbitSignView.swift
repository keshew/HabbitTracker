import SwiftUI

struct HabbitSignView: View {
    @StateObject var habbitSignModel =  HabbitSignViewModel()
    
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
                            habbitSignModel.isLogin = true
                        }) {
                            Image(.backBtn)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                        }
                        .padding(.leading)
                        
                        Text("Hello!")
                            .PTBold(size: 22, color: Color(red: 237/255, green: 82/255, blue: 39/255))
                        
                        Spacer()
                    }
                    
                    Text("Create an account to get access to all\nfeatures and possibilites of Habit Tracker")
                        .PT(size: 20)
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                    
                    VStack(spacing: 25) {
                        CustomTextFiled(text: $habbitSignModel.name, placeholder: "Enter Name")
                        
                        CustomTextFiled(text: $habbitSignModel.email, placeholder: "Enter Email")
                        
                        CustomSecureFiled(text: $habbitSignModel.password, placeholder: "Enter Password")
                        
                        CustomSecureFiled(text: $habbitSignModel.confirmPassword, placeholder: "Confirm Password")
                    }
                    
                    Spacer(minLength: 30)
                    
                    VStack(spacing: 20) {
                        Button(action: {
                            habbitSignModel.register()
                        }) {
                            Rectangle()
                                .fill(Color(red: 238/255, green: 81/255, blue: 37/255))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color(red: 209/255, green: 97/255, blue: 49/255) ,lineWidth: 2)
                                        .overlay {
                                            Text("Register")
                                                .PTBold(size: 22)
                                        }
                                }
                                .frame(height: 60)
                                .cornerRadius(30)
                                .padding(.horizontal, 30)
                        }
                        
                        Button(action: {
                            habbitSignModel.isSkip = true
                            UserDefaultsManager().enterAsGuest()
                        }) {
                            Rectangle()
                                .fill(Color(red: 27/255, green: 30/255, blue: 32/255))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color(red: 46/255, green: 52/255, blue: 55/255) ,lineWidth: 2)
                                        .overlay {
                                            Text("Skip")
                                                .PT(size: 22)
                                        }
                                }
                                .frame(height: 60)
                                .cornerRadius(30)
                                .padding(.horizontal, 30)
                                .shadow(color: .white.opacity(0.1), radius: 6, x: -6)
                        }
                    }
                    
                    Spacer(minLength: 175)
                    
                    HStack {
                        Text("Do you have an account?")
                            .PT(size: 20, color: Color(red: 97/255, green: 102/255, blue: 105/255))
                        
                        Button(action: {
                            habbitSignModel.isLogin = true
                        }) {
                            Text("Log In")
                                .PT(size: 20, color: Color(red: 238/255, green: 81/255, blue: 37/255))
                        }
                    }
                }
            }
        }
        .alert(isPresented: $habbitSignModel.showAlert) {
                   Alert(title: Text("Error"), message: Text(habbitSignModel.alertMessage), dismissButton: .default(Text("OK")))
               }
        .fullScreenCover(isPresented: $habbitSignModel.isLogin) {
            HabbitLogInView()
        }
        .fullScreenCover(isPresented: $habbitSignModel.isSkip) {
            HabbitTabBarView()
        }
    }
}

#Preview {
    HabbitSignView()
}


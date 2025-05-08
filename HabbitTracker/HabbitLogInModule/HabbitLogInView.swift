import SwiftUI

struct HabbitLogInView: View {
    @StateObject var habbitLogInModel =  HabbitLogInViewModel()
    
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
                            habbitLogInModel.isSign = true
                        }) {
                            Image(.backBtn)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                        }
                        .padding(.leading)
                        
                        Text("Welcome Back")
                            .PTBold(size: 22, color: Color(red: 237/255, green: 82/255, blue: 39/255))
                        
                        Spacer()
                    }
                    
                    Text("Sign in to continue organizing your habits\nin easiest way")
                        .PT(size: 20)
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                    
                    VStack(spacing: 25) {
                        CustomTextFiled(text: $habbitLogInModel.email, placeholder: "Enter Email")
                        
                        CustomSecureFiled(text: $habbitLogInModel.password, placeholder: "Enter Password")
                    }
                    
                    Spacer(minLength: 30)
                    
                    VStack(spacing: 20) {
                        Button(action: {
                            habbitLogInModel.login()
                        }) {
                            Rectangle()
                                .fill(Color(red: 238/255, green: 81/255, blue: 37/255))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color(red: 209/255, green: 97/255, blue: 49/255) ,lineWidth: 2)
                                        .overlay {
                                            Text("Get Started")
                                                .PTBold(size: 22)
                                        }
                                }
                                .frame(height: 60)
                                .cornerRadius(30)
                                .padding(.horizontal, 30)
                        }
                        
                        Button(action: {
                            habbitLogInModel.isSkip = true
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
                    
                    Spacer(minLength: getSpacing(for: UIScreen.main.bounds.width))
                    
                    HStack {
                        Text("Don’t have an account?")
                            .PT(size: 20, color: Color(red: 97/255, green: 102/255, blue: 105/255))
                        
                        Button(action: {
                            habbitLogInModel.isSign = true
                        }) {
                            Text("Sign Up")
                                .PT(size: 20, color: Color(red: 238/255, green: 81/255, blue: 37/255))
                        }
                    }
                }
            }
        }
        .alert(isPresented: $habbitLogInModel.showAlert) {
                 Alert(title: Text("Error"), message: Text(habbitLogInModel.alertMessage), dismissButton: .default(Text("OK")))
             }
        .fullScreenCover(isPresented: $habbitLogInModel.isSkip) {
            HabbitTabBarView()
        }
        .fullScreenCover(isPresented: $habbitLogInModel.isSign) {
            HabbitSignView()
        }
        .fullScreenCover(isPresented: $habbitLogInModel.isSetFirstTask) {
            HabbitChooseView()
        }
    }
    
    func getSpacing(for width: CGFloat) -> CGFloat {
        if width > 850 {
            return 850
        } else if width > 650 {
            return 690
        } else if width < 380 {
            return 300
        } else if width > 430 {
            return 390
        } else {
            return 320
        }
    }
}

#Preview {
    HabbitLogInView()
}

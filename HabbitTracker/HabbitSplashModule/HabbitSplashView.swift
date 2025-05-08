import SwiftUI

struct HabbitSplashView: View {
    @StateObject var habbitSplashModel =  HabbitSplashViewModel()

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
                    Image(.splash)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 400)
                        .padding(.top, 30)
                    
                    Spacer(minLength: 160)
                    
                    VStack {
                        VStack(spacing: 20) {
                            Button(action: {
                                habbitSplashModel.isStarted = true
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
                                habbitSplashModel.isLogin = true
                            }) {
                                Rectangle()
                                    .fill(Color(red: 27/255, green: 30/255, blue: 32/255))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color(red: 46/255, green: 52/255, blue: 55/255) ,lineWidth: 2)
                                            .overlay {
                                                Text("Login")
                                                    .PT(size: 22)
                                            }
                                    }
                                    .frame(height: 60)
                                    .cornerRadius(30)
                                    .padding(.horizontal, 30)
                                    .shadow(color: .white.opacity(0.1), radius: 6, x: -6)
                            }
                        }
                        
                        Text("If u want to use all functionality of tracker.")
                            .PT(size: 18, color: Color(red: 97/255, green: 102/255, blue: 105/255))
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $habbitSplashModel.isLogin) {
            HabbitLogInView()
        }
        .fullScreenCover(isPresented: $habbitSplashModel.isStarted) {
            HabbitSignView()
        }
    }
}

#Preview {
    HabbitSplashView()
}


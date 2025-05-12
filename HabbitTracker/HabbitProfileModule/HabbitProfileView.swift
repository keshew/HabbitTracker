import SwiftUI

struct HabbitProfileView: View {
    @StateObject var habbitProfileModel =  HabbitProfileViewModel()
    @State var isAlert = false
    
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
                    HStack {
                        Text("Profile")
                            .PTBold(size: 22, color: Color(red: 237/255, green: 82/255, blue: 39/255))
                            .padding(.leading)
                        
                        Spacer()
                    }
                
                    HStack {
                        if !UserDefaultsManager().isGuest() {
                            VStack(alignment: .leading) {
                                Text(UserDefaultsManager().getUsername() ?? "")
                                    .PT(size: 20)
                                
                                Text(UserDefaultsManager().getEmail() ?? "" )
                                    .PT(size: 16, color: Color(red: 96/255, green: 99/255, blue: 102/255))
                            }
                            .padding(.leading)
                        } else {
                            VStack(alignment: .leading) {
                                Text("Guest")
                                    .PT(size: 20)
                            }
                            .padding(.leading)
                            .padding(.top)
                        }
                        
                        Spacer()
                        
                        if !UserDefaultsManager().isGuest() {
                            Button(action: {
                                habbitProfileModel.isEdit = true
                            }) {
                                Image(.edit)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 55, height: 55)
                                    .padding(.trailing)
                            }
                        }
                    }
                    
                    Rectangle()
                        .fill(.clear)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.white, lineWidth: 1)
                                .overlay {
                                    VStack(spacing: 25) {
                                        HStack {
                                            Text("Push Notifications")
                                                .PT(size: 16)
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                habbitProfileModel.isNotif.toggle()
                                            }) {
                                                Image(habbitProfileModel.isNotif ? .on : .off)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 25, height: 25)
                                            }
                                        }
                                        .padding(.horizontal, 30)
                                        
                                        HStack {
                                            Text("Email Notifications")
                                                .PT(size: 16)
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                habbitProfileModel.isEmail.toggle()
                                            }) {
                                                Image(habbitProfileModel.isEmail ? .on : .off)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 25, height: 25)
                                            }
                                        }
                                        .padding(.horizontal, 30)
                                    }
                                }
                        }
                        .frame(height: 120)
                        .cornerRadius(20)
                        .padding(.horizontal)
                        .padding(.top, 20)
                    
                    Spacer(minLength: getSpacing(for: UIScreen.main.bounds.width))
                    
                    if !UserDefaultsManager().isGuest() {
                        VStack(spacing: 20) {
                            Button(action: {
                                habbitProfileModel.isLogOut = true
                                UserDefaultsManager().saveLoginStatus(false)
                            }) {
                                Rectangle()
                                    .fill(Color(red: 27/255, green: 30/255, blue: 32/255))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color(red: 46/255, green: 52/255, blue: 55/255) ,lineWidth: 2)
                                            .overlay {
                                                Text("Log out")
                                                    .PT(size: 22)
                                            }
                                    }
                                    .frame(height: 60)
                                    .cornerRadius(30)
                                    .padding(.horizontal, 30)
                                    .shadow(color: .white.opacity(0.1), radius: 6, x: -6)
                            }
                            
                            Button(action: {
//                                habbitProfileModel.deleteAccount(email: UserDefaultsManager().getEmail()!, password: UserDefaultsManager().getPassword()!)
                                isAlert = true
                            }) {
                                Rectangle()
                                    .fill(Color(red: 238/255, green: 81/255, blue: 37/255))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color(red: 209/255, green: 97/255, blue: 49/255) ,lineWidth: 2)
                                            .overlay {
                                                Text("Delete account")
                                                    .PTBold(size: 22)
                                            }
                                    }
                                    .frame(height: 60)
                                    .cornerRadius(30)
                                    .padding(.horizontal, 30)
                            }
                        }
                    } else {
                        VStack(spacing: 20) {
                            Button(action: {
                                habbitProfileModel.isSign = true
                                UserDefaultsManager().quitQuest()
                            }) {
                                Rectangle()
                                    .fill(Color(red: 238/255, green: 81/255, blue: 37/255))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color(red: 209/255, green: 97/255, blue: 49/255) ,lineWidth: 2)
                                            .overlay {
                                                Text("Create Account")
                                                    .PTBold(size: 22)
                                            }
                                    }
                                    .frame(height: 60)
                                    .cornerRadius(30)
                                    .padding(.horizontal, 30)
                            }
                            
                            Button(action: {
                                habbitProfileModel.isLogin = true
                                UserDefaultsManager().quitQuest()
                            }) {
                                Rectangle()
                                    .fill(Color(red: 27/255, green: 30/255, blue: 32/255))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color(red: 46/255, green: 52/255, blue: 55/255) ,lineWidth: 2)
                                            .overlay {
                                                Text("Log In")
                                                    .PT(size: 22)
                                            }
                                    }
                                    .frame(height: 60)
                                    .cornerRadius(30)
                                    .padding(.horizontal, 30)
                                    .shadow(color: .white.opacity(0.1), radius: 6, x: -6)
                            }
                        }
                    }
                }
            }
        }
        
        .alert(isPresented: $isAlert) {
                  Alert(
                      title: Text("Confirming account deletion"),
                      message: Text("Are you sure you want to delete the account?"),
                      primaryButton: .destructive(Text("Delete")) {
                          habbitProfileModel.deleteAccount(email: UserDefaultsManager().getEmail()!, password: UserDefaultsManager().getPassword()!)
                      },
                      secondaryButton: .cancel(Text("Cancel"))
                  )
              }
        
//        .alert(isPresented: $habbitProfileModel.showError) {
//            Alert(
//                title: Text("Error"),
//                message: Text(habbitProfileModel.errorMessage),
//                dismissButton: .default(Text("OK"))
//            )
//        }
        .fullScreenCover(isPresented: $habbitProfileModel.isLogOut) {
            HabbitLogInView()
        }
        .fullScreenCover(isPresented: $habbitProfileModel.isEdit) {
            HabbitEditProfileView()
        }
        
        .fullScreenCover(isPresented: $habbitProfileModel.isSign) {
            HabbitSignView()
        }
        
        .fullScreenCover(isPresented: $habbitProfileModel.isLogin) {
            HabbitLogInView()
        }
    }
    func getSpacing(for width: CGFloat) -> CGFloat {
        if width > 850 {
            return 910
        } else if width > 650 {
            return 760
        } else if width < 380 {
            return 300
        } else if width > 430 {
            return 470
        } else {
            return 300
        }
    }
}

#Preview {
    HabbitProfileView()
}


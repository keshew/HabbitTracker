import SwiftUI

struct HabbitEditProfileView: View {
    @StateObject var habbitEditProfileModel =  HabbitEditProfileViewModel()
    @Environment(\.presentationMode) var presentationMode
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
                        
                        Text("Edit Profile")
                            .PTBold(size: 22, color: Color(red: 237/255, green: 82/255, blue: 39/255))
                        
                        Spacer()
                    }
                    
                    VStack(spacing: 25) {
                        CustomTextFiled(text: $habbitEditProfileModel.name, placeholder: "Enter Name")
                        
                        CustomTextFiled(text: $habbitEditProfileModel.email, placeholder: "Enter Email")
                    }
                    
                    Spacer(minLength: 510)
                    
                    VStack(spacing: 20) {
                        Button(action: {
                            habbitEditProfileModel.updateProfile(currentEmail: UserDefaultsManager().getEmail()!, password: UserDefaultsManager().getPassword()!)
                        }) {
                            Rectangle()
                                .fill(Color(red: 238/255, green: 81/255, blue: 37/255))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color(red: 209/255, green: 97/255, blue: 49/255) ,lineWidth: 2)
                                        .overlay {
                                            Text("Save")
                                                .PTBold(size: 22)
                                        }
                                }
                                .frame(height: 60)
                                .cornerRadius(30)
                                .padding(.horizontal, 30)
                        }
                    }
                }
            }
        }
        .alert(isPresented: Binding<Bool>(
                   get: { habbitEditProfileModel.errorMessage != nil || habbitEditProfileModel.isSuccess },
                   set: { _ in
                       if habbitEditProfileModel.isSuccess {
                           habbitEditProfileModel.isSuccess = false
                       }
                       if habbitEditProfileModel.errorMessage != nil {
                           habbitEditProfileModel.errorMessage = nil
                       }
                   }
               )) {
                   if habbitEditProfileModel.isSuccess {
                       return Alert(title: Text("Success"),
                                    message: Text("Profile updated successfully."),
                                    dismissButton: .default(Text("OK")))
                   } else {
                       return Alert(title: Text("Error"),
                                    message: Text(habbitEditProfileModel.errorMessage ?? "Unknown error"),
                                    dismissButton: .default(Text("OK")))
                   }
               }
           }
}

#Preview {
    HabbitEditProfileView()
}


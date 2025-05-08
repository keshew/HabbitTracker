import SwiftUI

struct HabbitChooseView: View {
    @StateObject var habbitChooseModel =  HabbitChooseViewModel()

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
                    Text("Choose a coach to guide you!")
                        .PTBold(size: 22, color: Color(red: 237/255, green: 82/255, blue: 39/255))
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                    
                    Spacer(minLength: 30)
                    
                    VStack(spacing: 30) {
                        Button(action: {
                            habbitChooseModel.isMarco = true
                        }) {
                            Image(.marco)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 280)
                                .padding(.horizontal)
                        }
                        
                        Button(action: {
                            habbitChooseModel.isZeus = true
                        }) {
                            Image(.zeus)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 280)
                                .padding(.horizontal)
                        }
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $habbitChooseModel.isZeus) {
            HabbitChooseHabbitView(isZeus: $habbitChooseModel.isZeus)
        }
        
        .fullScreenCover(isPresented: $habbitChooseModel.isMarco) {
            HabbitChooseHabbitView(isZeus: $habbitChooseModel.isZeus)
        }
    }
}

#Preview {
    HabbitChooseView()
}


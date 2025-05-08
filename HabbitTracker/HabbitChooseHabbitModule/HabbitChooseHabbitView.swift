import SwiftUI

struct HabbitChooseHabbitView: View {
    @StateObject var habbitChooseHabbitModel =  HabbitChooseHabbitViewModel()
    @Binding var isZeus: Bool
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
                    Text("Choose your first Habit!")
                        .PTBold(size: 22, color: Color(red: 237/255, green: 82/255, blue: 39/255))
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                    
                    Spacer(minLength: 50)
                    
                    if isZeus {
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 73/255, green: 204/255, blue: 229/225),
                                                          Color(red: 25/255, green: 103/255, blue: 202/225)], startPoint: .top, endPoint: .bottom))
                            .frame(height: 680)
                            .cornerRadius(40)
                            .overlay {
                                VStack {
                                    Image(.zeusHabbit)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 340, height: 340)
                                    
                                    VStack {
                                        ForEach(habbitChooseHabbitModel.contact.zeusHabbit.indices, id: \.self) { index in
                                            FirstHabbit(image: habbitChooseHabbitModel.contact.zeusHabbit[index].image,
                                                        title: habbitChooseHabbitModel.contact.zeusHabbit[index].title,
                                                        desc: habbitChooseHabbitModel.contact.zeusHabbit[index].desc)
                                            .onTapGesture {
                                                habbitChooseHabbitModel.isNext = true
                                                habbitChooseHabbitModel.tilte = habbitChooseHabbitModel.contact.marcoHabbit[index].title
                                                habbitChooseHabbitModel.desc = habbitChooseHabbitModel.contact.marcoHabbit[index].desc
                                                habbitChooseHabbitModel.image = habbitChooseHabbitModel.contact.marcoHabbit[index].image
                                            }
                                        }
                                    }
                                    .offset(y: -30)
                                }
                                .offset(y: -30)
                            }
                            .padding(.horizontal)
                    } else {
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 142/255, green: 73/255, blue: 228/225),
                                                          Color(red: 199/255, green: 27/255, blue: 201/225)], startPoint: .top, endPoint: .bottom))
                            .frame(height: 680)
                            .cornerRadius(40)
                            .overlay {
                                VStack {
                                    Image(.marcoHabbit)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 340, height: 340)
                                    
                                    VStack {
                                        ForEach(habbitChooseHabbitModel.contact.marcoHabbit.indices, id: \.self) { index in
                                            FirstHabbit(image: habbitChooseHabbitModel.contact.marcoHabbit[index].image,
                                                        title: habbitChooseHabbitModel.contact.marcoHabbit[index].title,
                                                        desc: habbitChooseHabbitModel.contact.marcoHabbit[index].desc)
                                            .onTapGesture {
                                                habbitChooseHabbitModel.isNext = true
                                                habbitChooseHabbitModel.tilte = habbitChooseHabbitModel.contact.marcoHabbit[index].title
                                                habbitChooseHabbitModel.desc = habbitChooseHabbitModel.contact.marcoHabbit[index].desc
                                                habbitChooseHabbitModel.image = habbitChooseHabbitModel.contact.marcoHabbit[index].image
                                            }
                                        }
                                    }
                                    .offset(y: -30)
                                }
                                .offset(y: -30)
                            }
                            .padding(.horizontal)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $habbitChooseHabbitModel.isNext) {
            HabbitSetReminderView(isZeus: $isZeus,
                                  desc: $habbitChooseHabbitModel.desc,
                                  title: $habbitChooseHabbitModel.tilte,
                                  image: $habbitChooseHabbitModel.image)
        }
    }
}

#Preview {
    HabbitChooseHabbitView(isZeus: .constant(false))
}



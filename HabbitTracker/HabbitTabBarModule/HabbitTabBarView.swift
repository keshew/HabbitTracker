import SwiftUI

struct HabbitTabBarView: View {
    @StateObject var habbitTabBarModel =  HabbitTabBarViewModel()
    @State private var selectedTab: CustomTabBar.TabType = .Habits
    @AppStorage("isTask") private var isTask = false
    @AppStorage("isZeus") private var isZeus = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                if selectedTab == .Habits {
                    HabbitHabbitsView()
                } else if selectedTab == .Stats {
                    HabbitStatsView()
                } else if selectedTab == .Profile {
                    HabbitProfileView()
                }
            }
            .frame(maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 0)
            }
            
            if isTask {
                HabbitRemindView(isZeus: isZeus)
                    .ignoresSafeArea()
                    .onDisappear {
                        isTask = false
                    }
            }
            
            CustomTabBar(selectedTab: $selectedTab)
                .offset(y: isTask ? 590 : 0)
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HabbitTabBarView()
}

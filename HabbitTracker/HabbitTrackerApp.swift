import SwiftUI

@main
struct HabbitTrackerApp: App {
    @StateObject var notificationManager = NotificationManager()
    var body: some Scene {
        WindowGroup {
            if UserDefaultsManager().checkLogin() {
                HabbitTabBarView()
            } else {
                HabbitSplashView()
                    .onAppear {
                        UserDefaultsManager().quitQuest()
                        notificationManager.requestPermission { granted in
                                             }
                    }
            }
        }
    }
}

import SwiftUI

class HabbitSplashViewModel: ObservableObject {
    let contact = HabbitSplashModel()
    @Published var isLogin = false
    @Published var isStarted = false
}

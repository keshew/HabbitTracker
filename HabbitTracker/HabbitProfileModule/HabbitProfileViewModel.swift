import SwiftUI

class HabbitProfileViewModel: ObservableObject {
    let contact = HabbitProfileModel()
    @Published var isLogOut = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Published var isEdit = false
    @Published var isSign = false
    @Published var isLogin = false
    @Published var isNotif: Bool {
        didSet {
            UserDefaults.standard.set(isNotif, forKey: "isNotif")
        }
    }
    
    @Published var isEmail: Bool {
        didSet {
            UserDefaults.standard.set(isEmail, forKey: "isEmail")
        }
    }
    
    init() {
        self.isNotif = UserDefaults.standard.bool(forKey: "isNotif")
        self.isEmail = UserDefaults.standard.bool(forKey: "isEmail")
    }
    
    func deleteAccount(email: String, password: String) {
            NetworkManager.shared.logOut(email: email, password: password) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(_):
                        self?.isLogOut = true
                        UserDefaultsManager().saveLoginStatus(false)
                        UserDefaultsManager().deletePhone()
                        UserDefaultsManager().deletePassword()
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                        self?.showError = true
                    }
                }
            }
        }
}

import SwiftUI

class HabbitLogInViewModel: ObservableObject {
    let contact = HabbitLogInModel()
    @Published var email = ""
    @Published var password = ""
    @Published var isSkip = false
    @Published var isSign = false
    @Published var isSetFirstTask = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    func login() {
         guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
             showError("Email field is required")
             return
         }
         guard !password.isEmpty else {
             showError("Password field is required")
             return
         }
         
         NetworkManager.shared.login(username: email, password: password) { [weak self] result in
             DispatchQueue.main.async {
                 switch result {
                 case .success(_):
                     NetworkManager.shared.hasUserTasks(email: UserDefaultsManager().getEmail() ?? "") { result in
                         switch result {
                         case .success(let hasNoTasks):
                             if hasNoTasks {
                                 DispatchQueue.main.async {
                                     self?.isSetFirstTask = true
                                 }
                             } else {
                                 DispatchQueue.main.async {
                                     self?.isSkip = true
                                 }
                             }
                         case .failure(let error):
                             print("Error:", error.localizedDescription)
                         }
                     }
                     
                     UserDefaultsManager().saveCurrentEmail(self!.email)
                     UserDefaultsManager().savePassword(self!.password)
                     UserDefaultsManager().saveLoginStatus(true)
                 case .failure(_):
                     self?.showError("Something went wrong")
                 }
             }
         }
     }
    
    private func showError(_ message: String) {
          alertMessage = message
          showAlert = true
      }
}

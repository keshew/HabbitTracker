import SwiftUI

class HabbitSignViewModel: ObservableObject {
    let contact = HabbitSignModel()
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var isSkip = false
    @Published var isLogin = false
    
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    
    func register() {
           guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
               showError("Name field is required")
               return
           }
           guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
               showError("Email field is required")
               return
           }
           guard !password.isEmpty else {
               showError("Password field is required")
               return
           }
           guard !confirmPassword.isEmpty else {
               showError("Confirm Password field is required")
               return
           }
           
           guard password == confirmPassword else {
               showError("Passwords do not match")
               return
           }
           
        NetworkManager.shared.register(username: name, email: email, password: password) { [weak self] result in
                 DispatchQueue.main.async {
                     switch result {
                     case .success(_):
                         self?.isLogin = true
                     case .failure(_):
                         self?.showError("Something went wromg")
                     }
                 }
             }
         }
       
       private func showError(_ message: String) {
           alertMessage = message
           showAlert = true
       }
}

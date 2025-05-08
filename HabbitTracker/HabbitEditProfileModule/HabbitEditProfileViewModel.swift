import SwiftUI

class HabbitEditProfileViewModel: ObservableObject {
    let contact = HabbitEditProfileModel()
    @Published var name = ""
    @Published var email = ""
    @Published var errorMessage: String? = nil
    @Published var isSuccess: Bool = false
    
    func updateProfile(currentEmail: String, password: String) {
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Name cannot be empty"
            isSuccess = false
            return
        }
        
        guard !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Email cannot be empty"
            isSuccess = false
            return
        }
        
        NetworkManager.shared.editUserProfile(currentEmail: currentEmail, password: password, newName: name, newEmail: email) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if let success = response.success {
                        self?.isSuccess = true
                        UserDefaultsManager().saveUsername(self!.name)
                        UserDefaultsManager().saveCurrentEmail(self!.email)
                    } else if let error = response.error {
                        self?.errorMessage = error
                        self?.isSuccess = false
                    } else {
                        self?.errorMessage = "Unknown error"
                        self?.isSuccess = false
                    }
                case .failure(let error):
                    self?.errorMessage = "Something went wrong"
                    self?.isSuccess = false
                }
            }
        }
    }


}

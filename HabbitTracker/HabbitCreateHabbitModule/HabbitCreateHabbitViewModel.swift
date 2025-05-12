import SwiftUI

class HabbitCreateHabbitViewModel: ObservableObject {
    let contact = HabbitCreateHabbitModel()
    @Published var dateStart = Date(timeIntervalSince1970: 0)
    @Published var dateFinish = Date(timeIntervalSince1970: 0)
    @Published var time = Date(timeIntervalSince1970: 0)
    @Published var isDaily = true
    @Published var isWeekly = false
    @Published var isMountly = false
    @Published var name = ""
    @Published var desc = ""
    @Published var isMarco = false
    @Published var isZeus = true
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var isDissmss = false
    
    var email: String {
        UserDefaultsManager().getEmail() ?? "123"
    }
    
    let weekDays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    func firstImage() -> String {
        var arrayImage = [""]
        if isZeus {
            arrayImage = ["habbitZeus1", "habbitZeus2", "habbitZeus3", "habbitZeus4"]
        } else {
            arrayImage = ["habbitMarco1", "habbitMarco2", "habbitMarco3", "habbitMarco4"]
        }
        return arrayImage.randomElement() ?? ""
    }
    
    func secondImage() -> String {
        var arrayImage = [""]
        if isZeus {
            arrayImage = ["statsZeus1", "statsZeus2", "statsZeus3"]
        } else {
            arrayImage = ["statsMarco1", "statsMarco2", "statsMarco3"]
        }
        return arrayImage.randomElement() ?? ""
    }
    
    func setTaskForUser(selectedDays: Set<Int>) {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            showError("Habit name is required")
            return
        }
        guard !desc.trimmingCharacters(in: .whitespaces).isEmpty else {
            showError("Habit description is required")
            return
        }
        
        guard dateFinish != Date(timeIntervalSince1970: 0) else {
            showError("Start date is required")
            return
        }
        
        guard dateStart != Date(timeIntervalSince1970: 0) else {
            showError("Finish date is required")
            return
        }
        
        guard time != Date(timeIntervalSince1970: 0) else {
            showError("Time is required")
            return
        }
        
        
        let repeatDays: [String]
        if isDaily {
            repeatDays = weekDays
        } else if isWeekly {
            repeatDays = selectedDays.sorted().map { weekDays[$0] }
        } else if isMountly {
            repeatDays = []
        } else {
            repeatDays = []
        }
        
        
        guard !selectedDays.isEmpty else {
            showError("Repeat days is required")
            return
        }
        
        let activity: [String: String] = ["":""]
        
        let formatter = ISO8601DateFormatter()
        let dateStartStr = formatter.string(from: dateFinish)
        let dateFinishStr = formatter.string(from: dateStart)
        let timerStr = formatter.string(from: time)
        
        
        let task = NetworkManager.Task(
            id: nil,
            title: name,
            desc: desc,
            image: firstImage(),
            secondImage: secondImage(),
            dateStart: dateStartStr,
            dateFinish: dateFinishStr,
            reminder: "",
            timer: timerStr,
            repeatDays: repeatDays,
            isZeus: isZeus,
            activity: activity,
            completedDates: []
        )
        
        NotificationManager.shared.scheduleNotification(task: task)
        NetworkManager.shared.setTaskForUser(email: email, task: task) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.isDissmss = true
                case .failure(let error):
                    self?.showError(error.localizedDescription)
                }
            }
        }
    }
    
    private func showError(_ message: String) {
        alertMessage = message
        showAlert = true
    }
}

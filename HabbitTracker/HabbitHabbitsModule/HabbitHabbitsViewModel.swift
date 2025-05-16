import SwiftUI

class HabbitHabbitsViewModel: ObservableObject {
    let contact = HabbitHabbitsModel()
    @Published var tasks: [NetworkManager.Task] = []
    @Published var errorMessage: String? = nil
    @Published var isAdd = false
    @Published var isSign = false
    
    var userEmail: String {
        UserDefaultsManager().getEmail() ?? ""
    }
    
    func fetchTasks() {
        NetworkManager.shared.getTaskForUser(email: userEmail) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let tasks):
                    self?.tasks = tasks
                    self?.errorMessage = nil
                case .failure(_):
//                    self?.errorMessage = error.localizedDescription
                    self?.tasks = []
                }
            }
        }
    }
   
    func daysPassedSince(startDateString: String) -> Int {
        let formatter = ISO8601DateFormatter()
        guard let startDate = formatter.date(from: startDateString) else { return 0 }
        let now = Date()
        
        let calendar = Calendar.current
        let startDay = calendar.startOfDay(for: startDate)
        let today = calendar.startOfDay(for: now)
        
        if today < startDay {
            return 0
        }
        
        let diff = calendar.dateComponents([.day], from: startDay, to: today).day ?? 0
        
        return diff + 1
    }


    func daysBetween(startDateString: String, endDateString: String) -> Int {
        let formatter = ISO8601DateFormatter()
        guard let startDate = formatter.date(from: startDateString),
              let endDate = formatter.date(from: endDateString) else { return 0 }
        
        let startDay = Calendar.current.startOfDay(for: startDate)
        let endDay = Calendar.current.startOfDay(for: endDate)
        
        if endDay < startDay {
            return 0
        }
        
        let diff = Calendar.current.dateComponents([.day], from: startDay, to: endDay).day ?? 0
        return diff + 1
    }
}

extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}

extension HabbitHabbitsViewModel {
    func toggleCompletion(for task: NetworkManager.Task, on date: Date) {
        guard let taskId = task.id else { return }
        let formatter = ISO8601DateFormatter()
        let dateString = formatter.string(from: date.startOfDay)
        
        NetworkManager.shared.toggleTaskCompleteForDay(email: userEmail, taskId: taskId, date: dateString) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    guard let self = self else { return }
                    if let index = self.tasks.firstIndex(where: { $0.id == taskId }) {
                        var updatedTask = self.tasks[index]
                        var completedDates = updatedTask.completedDates ?? []
                        
                        if completedDates.contains(dateString) {
                            completedDates.removeAll(where: { $0 == dateString })
                        } else {
                            completedDates.append(dateString)
                        }
                        
                        updatedTask.completedDates = completedDates
                        self.tasks[index] = updatedTask
                    }
                case .failure(let error):
                    self?.errorMessage = "Failed to update completion: \(error.localizedDescription)"
                }
            }
        }
    }
}

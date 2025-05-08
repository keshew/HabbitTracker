import SwiftUI

class HabbitStatsViewModel: ObservableObject {
    let contact = HabbitStatsModel()
    @Published var errorMessage: String? = nil
    @Published var isAdd = false
    @Published var tasks: [NetworkManager.Task] = []
    @Published var taskModel: NetworkManager.Task? = nil
    @Published var isDetail = false
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
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.tasks = []
                }
            }
        }
    }
    
    func daysPassedSince(startDateString: String) -> Int {
        let formatter = ISO8601DateFormatter()
        guard let startDate = formatter.date(from: startDateString) else { return 0 }
        let now = Date()
        let startDay = Calendar.current.startOfDay(for: startDate)
        let today = Calendar.current.startOfDay(for: now)
        
        if today < startDay {
            return 0
        }
        
        let diff = Calendar.current.dateComponents([.day], from: startDay, to: today).day ?? 0
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

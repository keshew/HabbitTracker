import SwiftUI

class HabbitDetailStatsViewModel: ObservableObject {
    let contact = HabbitDetailStatsModel()
    @Published var isDaily = true
    @Published var isWeekly = false
    @Published var isMountly = false
    
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

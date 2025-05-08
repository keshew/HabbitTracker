import UserNotifications
import SwiftUI

class NotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationManager()
    @AppStorage("isTask") private var isTask = false
    @AppStorage("isZeus") private var isZeus = false
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    func requestPermission(completion: @escaping (Bool) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { success, error in
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
    
    func scheduleNotification(task: NetworkManager.Task) {
        let content = UNMutableNotificationContent()
        content.title = task.title
        content.body = task.desc
        content.sound = .default

        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]

        guard let date = isoFormatter.date(from: task.dateStart) else {
            print("Ошибка: не удалось распарсить дату из dateStart: \(task.dateStart)")
            return
        }

        guard let timeDate = isoFormatter.date(from: task.timer) else {
            print("Ошибка: не удалось распарсить время из timer: \(task.timer)")
            return
        }

        let calendar = Calendar.current

        var dateComponents = calendar.dateComponents([.year, .month, .day], from: date)

        let timeComponents = calendar.dateComponents([.hour, .minute], from: timeDate)


        dateComponents.hour = timeComponents.hour
        dateComponents.minute = timeComponents.minute

        guard let triggerDate = calendar.date(from: dateComponents) else {
            print("Ошибка: не удалось создать дату для уведомления")
            return
        }
        
        if triggerDate <= Date() {
            print("Дата уведомления уже прошла")
            return
        }

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let identifier = task.id ?? UUID().uuidString
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
            } else {
                print("Уведомление запланировано для задачи \(task.title) на \(triggerDate)")
            }
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        isTask = true
        completionHandler()
    }
    
    func cancelAllNotifications() {
         UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
     }
}

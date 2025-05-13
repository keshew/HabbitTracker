import Foundation

struct HasTasksResponse: Decodable {
      let hasNoTasks: Bool
      let error: String?
  }

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    private let baseURL = URL(string: "https://goalmaster.online/app.php")!

    enum NetworkError: Error {
        case invalidURL
        case invalidResponse
        case serverError(String)
        case decodingError
    }

    private func sendRequest<T: Decodable>(with body: [String: Any], completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode,
                  let data = data else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                if let serverError = try? JSONDecoder().decode(ServerErrorResponse.self, from: data) {
                    completion(.failure(NetworkError.serverError(serverError.error)))
                } else {
                    completion(.failure(NetworkError.decodingError))
                }
            }
        }.resume()
    }

    struct ServerErrorResponse: Decodable {
        let error: String
    }

    struct SuccessResponse: Decodable {
        let success: String?
        let error: String?
    }

    struct Task: Codable {
        let id: String?
        let title: String
        let desc: String
        let image: String
        let secondImage: String
        let dateStart: String
        let dateFinish: String
        let reminder: String
        let timer: String
        let repeatDays: [String]
        let isZeus: Bool
        let activity: [String: String]
        var completedDates: [String]?
    }

    struct TaskResponse: Decodable {
        let success: String?
        let error: String?
        let task: Task?
    }

    typealias TasksArray = [Task]

    func toggleTaskCompleteForDay(email: String, taskId: String, date: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let body: [String: Any] = [
            "method": "toggleTaskCompleteForDay",
            "email": email,
            "taskId": taskId,
            "date": date
        ]
        sendRequest(with: body) { (result: Result<SuccessResponse, Error>) in
            switch result {
            case .success(let response):
                if let error = response.error {
                    completion(.failure(NetworkError.serverError(error)))
                } else if let _ = response.success {
                    completion(.success(true))
                } else {
                    completion(.failure(NetworkError.invalidResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    
    func register(username: String, email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let body: [String: Any] = [
            "method": "register",
            "username": username,
            "email": email,
            "pass": password
        ]

        sendRequest(with: body) { (result: Result<SuccessResponse, Error>) in
            switch result {
            case .success(let response):
                if let success = response.success {
                    completion(.success(success))
                } else if let error = response.error {
                    completion(.failure(NetworkError.serverError(error)))
                } else {
                    completion(.failure(NetworkError.invalidResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func login(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let body: [String: Any] = [
            "method": "login",
            "email": username,
            "pass": password
        ]

        sendRequest(with: body) { (result: Result<SuccessResponse, Error>) in
            switch result {
            case .success(let response):
                if let success = response.success {
                    completion(.success(success))
                } else if let error = response.error {
                    completion(.failure(NetworkError.serverError(error)))
                } else {
                    completion(.failure(NetworkError.invalidResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func setTaskForUser(email: String, task: Task, completion: @escaping (Result<Task, Error>) -> Void) {
        let taskDict: [String: Any] = [
            "title": task.title,
            "desc": task.desc,
            "image": task.image,
            "secondImage": task.secondImage,
            "dateStart": task.dateStart,
            "dateFinish": task.dateFinish,
            "reminder": task.reminder,
            "timer": task.timer,
            "repeatDays": task.repeatDays,
            "isZeus": task.isZeus,
            "activity": task.activity
        ]

        let body: [String: Any] = [
            "method": "setTaskForUser",
            "email": email,
            "task": taskDict
        ]

        sendRequest(with: body) { (result: Result<TaskResponse, Error>) in
            switch result {
            case .success(let response):
                if let task = response.task {
                    completion(.success(task))
                } else if let error = response.error {
                    completion(.failure(NetworkError.serverError(error)))
                } else {
                    completion(.failure(NetworkError.invalidResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func hasUserTasks(email: String, completion: @escaping (Result<Bool, Error>) -> Void) {
         let body: [String: Any] = [
             "method": "hasUserTasks",
             "email": email
         ]

         sendRequest(with: body) { (result: Result<HasTasksResponse, Error>) in
             switch result {
             case .success(let response):
                 if let error = response.error {
                     completion(.failure(NetworkError.serverError(error)))
                 } else {
                     completion(.success(response.hasNoTasks))
                 }
             case .failure(let error):
                 completion(.failure(error))
             }
         }
     }
    
    func getTaskForUser(email: String, completion: @escaping (Result<TasksArray, Error>) -> Void) {
        let body: [String: Any] = [
            "method": "getTaskForUser",
            "email": email
        ]
        sendRequest(with: body, completion: completion)
    }

    func editTaskForUser(email: String, taskUpdates: [String: Any], completion: @escaping (Result<String, Error>) -> Void) {
        let body: [String: Any] = [
            "method": "editTaskForUser",
            "email": email,
            "task": taskUpdates
        ]

        sendRequest(with: body) { (result: Result<SuccessResponse, Error>) in
            switch result {
            case .success(let response):
                if let success = response.success {
                    completion(.success(success))
                } else if let error = response.error {
                    completion(.failure(NetworkError.serverError(error)))
                } else {
                    completion(.failure(NetworkError.invalidResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func deleteTaskForUser(email: String, taskId: String, completion: @escaping (Result<String, Error>) -> Void) {
        let body: [String: Any] = [
            "method": "deleteTaskForUser",
            "email": email,
            "taskId": taskId
        ]

        sendRequest(with: body) { (result: Result<SuccessResponse, Error>) in
            switch result {
            case .success(let response):
                if let success = response.success {
                    completion(.success(success))
                } else if let error = response.error {
                    completion(.failure(NetworkError.serverError(error)))
                } else {
                    completion(.failure(NetworkError.invalidResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func logOut(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let body: [String: Any] = [
            "method": "logOut",
            "email": email,
            "pass": password
        ]

        sendRequest(with: body) { (result: Result<SuccessResponse, Error>) in
            switch result {
            case .success(let response):
                if let success = response.success {
                    completion(.success(success))
                } else if let error = response.error {
                    completion(.failure(NetworkError.serverError(error)))
                } else {
                    completion(.failure(NetworkError.invalidResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func editUserProfile(currentEmail: String, password: String, newName: String, newEmail: String, completion: @escaping (Result<SuccessResponse, Error>) -> Void) {
        let body: [String: Any] = [
            "method": "editUserProfile",
            "currentEmail": currentEmail,
            "password": password,
            "newName": newName,
            "newEmail": newEmail
        ]

        sendRequest(with: body) { (result: Result<SuccessResponse, Error>) in
            switch result {
            case .success(let response):
                if let _ = response.success {
                    completion(.success(response))
                } else if let error = response.error {
                    completion(.failure(NetworkError.serverError(error)))
                } else {
                    completion(.failure(NetworkError.invalidResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

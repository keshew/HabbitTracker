import SwiftUI

class HabbitChooseHabbitViewModel: ObservableObject {
    let contact = HabbitChooseHabbitModel()
    @Published var isNext = false
    @Published var tilte = ""
    @Published var desc = ""
    @Published var image = ""
}

import SwiftUI

class HabbitChooseViewModel: ObservableObject {
    let contact = HabbitChooseModel()
    @Published var isZeus = false
    @Published var isMarco = false
}

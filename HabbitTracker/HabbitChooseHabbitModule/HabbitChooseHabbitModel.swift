import SwiftUI

struct HabbitModel {
    var title: String
    var desc: String
    var image: String
}

struct HabbitChooseHabbitModel {
    let zeusHabbit = [HabbitModel(title: "Hydration", desc: "Drink a glass of water after waking up", image: "habbitZeus1"),
                      HabbitModel(title: "Reading", desc: "5 pages per day", image: "habbitZeus2"),
                      HabbitModel(title: "Meditation", desc: "2 minutes of breathing exercises", image: "habbitZeus3"),
                      HabbitModel(title: "Digital Detox", desc: "No phone for first 30 minutes after waking", image: "habbitZeus4")]
    
    let marcoHabbit = [HabbitModel(title: "Learning Something New", desc: "1 foreign language word", image: "habbitMarco1"),
                      HabbitModel(title: "Journaling", desc: "1 sentence about your day", image: "habbitMarco2"),
                      HabbitModel(title: "Creativity", desc: "30 minutes of drawing/writing", image: "habbitMarco3"),
                      HabbitModel(title: "Social Connection", desc: "30-minute call without multitasking", image: "habbitMarco4")]
}



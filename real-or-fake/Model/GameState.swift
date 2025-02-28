import SwiftUI

class GameState: ObservableObject {
    @Published var score: Int = 0
    @Published var streak: Int = 0
    private var elo: Int = 1000

    private let basePoints = 100
    private let streakMultiplier = 0.2
    private let eloK = 32

    func processGuess(isCorrect: Bool, cardDifficulty: Double = 0.5) {
        if isCorrect {
            streak += 1
            let streakBonus = Double(basePoints) * (Double(streak - 1) * streakMultiplier)
            score += basePoints + Int(streakBonus)
            
            let expectedScore = 1.0 / (1.0 + pow(10, (Double(cardDifficulty * 2000) - Double(elo)) / 400.0))
            elo += Int(Double(eloK) * (1.0 - expectedScore))
        } else {
            streak = 0
            
            let expectedScore = 1.0 / (1.0 + pow(10, (Double(cardDifficulty * 2000) - Double(elo)) / 400.0))
            elo -= Int(Double(eloK) * expectedScore)
        }
    }
    
    func saveState() {
        // TODO: Implement persistence
        UserDefaults.standard.set(score, forKey: "userScore")
        UserDefaults.standard.set(elo, forKey: "userElo")
    }

    func loadState() {
        score = UserDefaults.standard.integer(forKey: "userScore")
        elo = UserDefaults.standard.integer(forKey: "userElo")
    }
}

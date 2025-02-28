//
//  ContentView.swift
//  real-or-fake
//
//  Created by Justin Cheah Yun Fei on 1/3/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var gameState = GameState()
    // TODO: replace with images from db in the future
    @State private var cards = [
        Card(id: UUID(), isReal: false),
        Card(id: UUID(), isReal: true),
        Card(id: UUID(), isReal: false),
        Card(id: UUID(), isReal: true)
    ]

    @State private var backgroundColor: Color = .white
    @State private var showFeedback: Bool = false
    @State private var correctGuess: Bool? = nil

    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.1), value: backgroundColor)

            VStack {
                HStack {
                    Text("Score: \(gameState.score)")
                        .font(.title2)
                        .bold()
                        .padding()
                    Spacer()
                    if gameState.streak > 1 {
                        Text("Streak: \(gameState.streak)")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.orange)
                            .padding()
                    }
                }

                HStack {
                    DirectionLabel(text: "Fake", alignment: .leading)
                    Spacer()
                    DirectionLabel(text: "Real", alignment: .trailing)
                }

                ZStack {
                    ForEach(cards) { card in
                        CardView(
                            card: card,
                            onRemove: { removedCard, userGuessedReal in
                                checkAnswer(removedCard, userGuessedReal)
                            }
                        )
                    }
                }
            }
        }
    }

    private func checkAnswer(_ card: Card, _ userGuessedReal: Bool) {
        let isCorrect = card.isReal == userGuessedReal
        correctGuess = isCorrect
        backgroundColor = isCorrect ? Color.green : Color.red
        
        gameState.processGuess(isCorrect: isCorrect)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            backgroundColor = .white
            correctGuess = nil
            withAnimation {
                cards.removeAll { $0.id == card.id }
            }
        }
    }
}

struct DirectionLabel: View {
    let text: String
    let alignment: HorizontalAlignment
    
    var body: some View {
        Text(alignment == .leading ? "← \(text)" : "\(text) →")
            .font(.title)
            .bold()
            .foregroundColor(.gray)
            .opacity(0.4)
            .padding(alignment == .leading ? .leading : .trailing, 20)
    }
}

#Preview {
    ContentView()
}

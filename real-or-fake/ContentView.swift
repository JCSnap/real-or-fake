//
//  ContentView.swift
//  real-or-fake
//
//  Created by Justin Cheah Yun Fei on 1/3/25.
//

import SwiftUI

struct ContentView: View {
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
                    Text("← Fake")
                        .font(.title)
                        .bold()
                        .foregroundColor(.gray)
                        .opacity(0.4)
                        .padding(.leading, 20)
                    Spacer()
                    Text("Real →")
                        .font(.title)
                        .bold()
                        .foregroundColor(.gray)
                        .opacity(0.4)
                        .padding(.trailing, 20)
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

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            backgroundColor = .white
            correctGuess = nil
            withAnimation {
                cards.removeAll { $0.id == card.id }
            }
        }
    }
}

#Preview {
    ContentView()
}

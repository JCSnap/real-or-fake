//
//  CardView.swift
//  real-or-fake
//
//  Created by Justin Cheah Yun Fei on 1/3/25.
//

import SwiftUI

struct CardView: View {
    let card: Card
    var onRemove: (Card, Bool) -> Void

    @State private var offset: CGSize = .zero
    @State private var rotation: Double = 0

    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.white)
            .frame(width: 300, height: 400)
            .shadow(radius: 5)
            .overlay(
                Text("Swipe to Guess")
                    .foregroundColor(.gray)
                    .bold()
            )
            .offset(x: offset.width, y: offset.height)
            .rotationEffect(.degrees(rotation))
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                        rotation = Double(offset.width / 20)
                    }
                    .onEnded { _ in
                        let swipeThreshold: CGFloat = 150
                        if abs(offset.width) > swipeThreshold {
                            let userGuessedReal = offset.width > 0
                            withAnimation(.easeInOut(duration: 0.8)) {
                                offset.width = offset.width > 0 ? 700 : -700
                                rotation = offset.width > 0 ? 20 : -20
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                onRemove(card, userGuessedReal)
                            }
                        } else {
                            withAnimation(.spring()) {
                                offset = .zero
                                rotation = 0
                            }
                        }
                    }
            )
    }
}

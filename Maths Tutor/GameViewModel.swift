//
//  GameViewModel.swift
//  Maths Tutor
//
//  Created by Theo Ntogiakos on 20/11/2023.
//

import SwiftUI

class GameViewModel: ObservableObject {
    @Published var firstNumber = Int.random(in: 1...10)
    @Published var secondNumber = Int.random(in: 1...10)
    @Published var firstNumberEmojis = ""
    @Published var secondNumberEmojis = ""
    @Published var result = false
    @Published var feedback = Feedback.correct
    
    private var audioPlayer = AudioPlayer()
    private var audioClip: String { result ? "correct" : "wrong" }
    
    let emojis = ["🍕", "🍎", "🍏", "🐵", "👽", "🧠", "🧜🏽‍♀️", "🧙🏿‍♂️", "🥷", "🐶", "🐹", "🐣", "🦄", "🐝", "🦉", "🦋", "🦖", "🐙", "🦞", "🐟", "🦔", "🐲", "🌻", "🌍", "🌈", "🍔", "🌮", "🍦", "🍩", "🍪"]
    
    init() {
        setEmojis()
    }
    
    func setEmojis() {
        let emoji1 = emojis.randomElement()!
        var emoji2 = emojis.randomElement()!
        
        while emoji1 == emoji2 {
            emoji2 = emojis.randomElement()!
        }
        
        firstNumberEmojis = String(repeating: emoji1, count: firstNumber)
        secondNumberEmojis = String(repeating: emoji2, count: secondNumber)
    }
    
    func checkAnswer(_ answer: String) {
        let answerValue = Int(answer)!
        
        result = (firstNumber + secondNumber) == answerValue
        feedback = result ? .correct : .wrong

        audioPlayer.play(clip: audioClip)
    }
    
    func getNewNumbers() {
        firstNumber = Int.random(in: 1...10)
        secondNumber = Int.random(in: 1...10)
        setEmojis()
    }
}

enum Feedback {
    case correct
    case wrong
    
    var message: String {
        switch self {
        case .correct:
            return "Correctamundo!"
        case .wrong:
            return "Sorry! Try again!"
        }
    }
}

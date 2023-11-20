//
//  ContentView.swift
//  Maths Tutor
//
//  Created by Theo Ntogiakos on 20/11/2023.
//

import SwiftUI

struct MainGameView: View {
    @StateObject var viewModel = GameViewModel()
    @State private var answer = ""
    @State private var hideFeedback = true
    @State private var showNext = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack {
            VStack {
                Text(viewModel.firstNumberEmojis)
                    .font(.system(size: 80))
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                Text("+")
                Text(viewModel.secondNumberEmojis)
                    .font(.system(size: 80))
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            HStack {
                Text("\(viewModel.firstNumber) + \(viewModel.secondNumber) =")
                TextField("", text: $answer)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray, lineWidth: 2)
                            .background(showNext ? .gray : .clear)
                    }
                    .frame(width: 60)
                    .keyboardType(.numberPad)
                    .focused($isFocused)
                    .disabled(showNext)
                    .onChange(of: answer) {
                        guard Int(answer) != nil else {
                            answer = ""
                            return
                        }
                    }
            }
            Button(showNext ? "Next" : "Answer") {
                if showNext {
                    viewModel.getNewNumbers()
                    showNext = false
                    hideFeedback = true
                    isFocused = true
                } else {
                    viewModel.checkAnswer(answer)
                    showNext = viewModel.result
                    answer = ""
                    hideFeedback = false
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(showNext ? .teal : .green)
            .disabled(answer.isEmpty && !showNext)
            
            Text(hideFeedback ? " " : viewModel.feedback.message)
                .foregroundStyle(viewModel.result ? .green : .red)
                .minimumScaleFactor(0.5)
        }
        .font(.largeTitle)
        .multilineTextAlignment(.center)
        .padding()
    }
}

#Preview {
    MainGameView()
}

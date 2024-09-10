//
//  ContentView.swift
//  GuessAI
//
//  Created by DarkAssassin23 on 9/4/24.
//

import SwiftUI

private let TOP: Double = 100.0

struct ContentView: View {
    private let ai = AI()
    @State private var guessing: Bool = false
    @State private var correctAlert: Bool = false
    @State private var invalidRange: Bool = false
    @State private var liarAlert: Bool = false
    @State private var prev: Int = 0
    @State private var guess: Int = 0
    @State private var topRange: Double = TOP * 0.5
    @State private var bottomRange: Double = 0.0

    var body: some View {
        VStack {
            Spacer()
            Text("Number Guessing AI")
                .font(.largeTitle)
            Spacer()
            if !guessing {
                Text("Guess Range")
                HStack {
                    Text("Lower bound:")
                        .font(.headline)
                        .padding()
                    Text("0")
                    Slider(
                        value: $bottomRange,
                        in: 0...TOP,
                        step: (TOP / 20)
                    )
                    Text("\(Int(TOP))")
                }.padding()
                HStack {
                    Text("Upper bound:")
                        .font(.headline)
                        .padding()
                    Text("0")
                    Slider(
                        value: $topRange,
                        in: 0...TOP,
                        step: (TOP / 20)
                    )
                    Text("\(Int(TOP))")
                }.padding()
                Text("\(Int(bottomRange)) - \(Int(topRange))")
                    .foregroundColor(
                        (Int(bottomRange) <= Int(topRange)) ? .blue : .red
                    )
                    .padding()
                Spacer()
                Button(
                    "Start",
                    action: {
                        if bottomRange > topRange {
                            invalidRange = true
                            return
                        }
                        guessing = true
                        ai.initialize(Int(bottomRange), Int(topRange) + 1)
                        guess = ai.makeGuess(prevRes: .GUESS_RESULT_NA)
                    }
                )
                .padding()
                .foregroundColor(.white)
                .background(guessing ? Color.gray : Color.blue)
                .clipShape(Capsule())
                .alert(isPresented: $invalidRange) {
                    Alert(
                        title: Text("Invalid Range"),
                        dismissButton: .default(Text("Ok"))
                    )
                }
            } else {
                Text("AI's Guess: \(guess)")
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                HStack {
                    Button(
                        "Too Low",
                        action: {
                            liar(.GUESS_RESULT_LOW)
                        }
                    )
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(Capsule())
                    .alert(isPresented: $liarAlert) {
                        Alert(
                            title: Text("Liar! 🤬"),
                            dismissButton: .cancel(
                                Text("Ok"),
                                action: {
                                    guessing = false
                                }
                            )
                        )
                    }
                    Spacer()
                    Button(
                        "Correct",
                        action: {
                            correctAlert = true
                        }
                    )
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(Capsule())
                    .alert(isPresented: $correctAlert) {
                        Alert(
                            title: Text("Knew it 😝"),
                            dismissButton: .cancel(
                                Text("Ok"),
                                action: {
                                    guessing = false
                                }
                            )
                        )
                    }
                    Spacer()
                    Button(
                        "Too High",
                        action: {
                            liar(.GUESS_RESULT_HIGH)
                        }
                    )
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(Capsule())
                    .alert(isPresented: $liarAlert) {
                        Alert(
                            title: Text("Liar! 🤬"),
                            dismissButton: .cancel(
                                Text("Ok"),
                                action: {
                                    guessing = false
                                }
                            )
                        )
                    }
                }
                .padding()
                Button(
                    "Quit",
                    action: {
                        guessing = false
                    }
                )
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .clipShape(Capsule())
                Spacer()
            }
        }
    }

    /// Make a guess and check if the User is a liar
    /// - Parameter res: If guess was too high or too low
    private func liar(_ res: GuessResult) {
        prev = guess
        guess = ai.makeGuess(prevRes: res)
        liarAlert = prev == guess
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

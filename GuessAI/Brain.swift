//
//  Brain.swift
//  Guesser
//
//  Created by DarkAssassin23 on 9/4/24.
//

import Foundation

enum GuessResult {
    case GUESS_RESULT_HIGH
    case GUESS_RESULT_LOW
    case GUESS_RESULT_NA
}

/// Class to handle making guesses by using binary search
class AI {
    private var lower: Int = 0
    private var upper: Int = Int.max
    private var guess: Int = Int.min

    /// Initialize the AI for a new guess
    /// - Parameters:
    ///   - lower: The initial lower bound
    ///   - upper: The initial upper bound
    public func initialize(_ lower: Int, _ upper: Int) {
        self.lower = lower
        self.upper = upper
        self.guess = Int.min
    }

    /// Given a lower and upper bound make a guess at what the number is
    ///
    /// > Note: If the range is invalid (e.g. lower > upper) Int.min will be returned
    /// - Parameter prevRes: The result of the AI's previous guess
    /// - Returns: The AI's new guess
    public func makeGuess(prevRes: GuessResult) -> Int {
        switch prevRes {
        case .GUESS_RESULT_HIGH:
            upper = guess
            break
        case .GUESS_RESULT_LOW:
            lower = guess
            break
        default:
            break
        }
        // Find the mid point
        guess = lower + ((upper - lower) / 2)
        return guess
    }
}

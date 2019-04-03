//
//  PigGame.swift
//  Shmuel_Jacobs_Lab05
//
//  Created by Shmuel Jacobs on 3/30/19.
//  Copyright © 2019 Shmuel Jacobs. All rights reserved.
//

import Foundation

// By default, games have two players
private let NUMPLAYERS = 2;

class PigGame {
    
    private var scores: [Int];
    private var currentTurn: Int;
    private var currentTurnScore: Int;
    private var numPlayers: Int;
    
    init(numPlayers: Int) {
        self.numPlayers = numPlayers;
        // Create array to store scores
        scores = [];
        // Set all scores to 0
        for _ in 0...numPlayers {
            scores.append(0);
        }
        // Set current turn to Player 0
        currentTurn = 0;
        currentTurnScore = 0;
    }
    
    convenience init() {
        self.init(numPlayers: NUMPLAYERS);
    }
    
    private func rollDie() -> Int {
        return Int(arc4random_uniform(6)) + 1;
    }
    
    /**
     Generate die roll. Add to current score if not 1, else set current turn score to 0.
     */
    func rollAndUpdateScore() -> Int {
        let roll = rollDie();
        if roll == 1 {
            currentTurnScore = 0;
        } else {
            currentTurnScore += roll;
        }
        return roll;
    }
    
    var getCurrentTurn: Int {
        return currentTurn;
    }
    
    var getCurrentTurnScore: Int {
        return currentTurnScore;
    }
    
    func endTurn() -> Int{
        scores[currentTurn] += currentTurnScore;
        let endingScore = scores[currentTurn];
        print("Player \(currentTurn) ends turn with \(currentTurnScore) points for \(scores[currentTurn]).");
        currentTurnScore = 0;
        currentTurn = (currentTurn + 1) % numPlayers;
        return endingScore;
    }
}

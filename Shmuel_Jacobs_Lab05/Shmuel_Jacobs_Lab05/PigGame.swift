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
    private var numPlayers: Int;
    private let rand = arc4random();
    
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
    }
    
    convenience init() {
        self.init(numPlayers: NUMPLAYERS);
    }
    
    func rollDie() -> Int {
        return Int(arc4random_uniform(6)) + 1;
    }
    
    func getCurrentTurn() -> Int {
        return currentTurn;
    }
    
    func endTurn(score: Int) {
        scores[currentTurn] += score;
        print("Player \(currentTurn) ends turn with \(score) points for \(scores[currentTurn]).");
        currentTurn = currentTurn + 1 % numPlayers;
    }
}

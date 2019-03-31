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
    
    init(numPlayers: Int) {
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
    
    
}

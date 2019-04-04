//
//  PigGame.swift
//  Shmuel_Jacobs_Lab05
//
//  Created by Shmuel Jacobs on 3/30/19.
//  Copyright © 2019 Shmuel Jacobs. All rights reserved.
//
/**
 - author: Shmuel Jacobs
 - TUID: 915046889
 - class: Intro to iOS
 - assignment: Lab 5
 - purpose: Hands on experience utilizing XCode as a development environment; using Interface Builder; declaring and wiring up IBOutlets; declaring and wiring up IBActions; using various iOS widgets - UILabel, UIButton, UIImageView, UIProgressView; testing applications in the iPhone Simulator
 */

import Foundation

// By default, games have two players
private let NUMPLAYERS = 2;

class PigGame {
    
    // Array holds scores indexed by player ID
    private var scores: [Int];
    // ID of current player
    private var currentTurn: Int;
    // sum of points rolled during current turn
    private var currentTurnScore: Int;
    // number of players in current game
    private var numPlayers: Int;
    // play until someone scores this many points
    let WINNINGSCORE = 100; // TODO: set to 100
    // Which player goes first
    var startingPlayer: Int;
    
    /**
     Create new game object with this many players. Reset all fields for new game.
     
     - Parameter numPlayers: Number of players playing current game
     */
    init(numPlayers: Int) {
        self.numPlayers = numPlayers;
        // Create array to store scores
        scores = [];
        // Set all scores to 0
        for _ in 0...numPlayers {
            scores.append(0);
        }
        currentTurnScore = 0;
        startingPlayer = 0;
        currentTurn = startingPlayer;
    }
    
    convenience init() {
        self.init(numPlayers: NUMPLAYERS);
    }
    
    /**
     Get new random roll of six-sided die.
     - Returns: Int in range [1,6]
     */
    private func rollDie() -> Int {
        return Int(arc4random_uniform(6)) + 1;
    }
    
    /**
     Generate die roll. Add to current score if not 1, else set current turn score to 0.
     - Returns: Int in range [1,6]
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
    
    /**
     Game logic for ending current turn. Saves points, resets current turn to 0 points, changes current player
     - Returns: Player total score after end of turn.
     */
    func endTurn() -> Int{
        scores[currentTurn] += currentTurnScore;
        let endingScore = scores[currentTurn];
        print("Player \(currentTurn) ends turn with \(currentTurnScore) points for \(scores[currentTurn]).");
        currentTurnScore = 0;
        currentTurn = (currentTurn + 1) % numPlayers;
        return endingScore;
    }
    
//    func getWinner() -> Int? {
//        for player in 0...(scores.count - 1) {
//            if scores[player] + currentTurnScore >= WINNINGSCORE{
//                return player;
//            }
//        }
//        return nil;
//    }

    /**
     Check if someone just won the game.
     */
    func justWon() -> Bool {
        return currentTurnScore + scores[currentTurn] >= WINNINGSCORE;
    }
    
    /**
     Reset all game state information for new game.
     */
    func reset() {
        for i in 0...numPlayers {
            scores[i] = 0;
        }
        currentTurnScore = 0;
        // Change who goes first
        startingPlayer = (startingPlayer+1) % numPlayers;
        currentTurn = startingPlayer;
    }
}

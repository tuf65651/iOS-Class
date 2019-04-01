//
//  ViewController.swift
//  Shmuel_Jacobs_Lab05
//
//  Created by Shmuel Jacobs on 3/28/19.
//  Copyright © 2019 Shmuel Jacobs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let game = PigGame();
    var currentRoll = 0;
    var gameIsLive = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        rollButton.isEnabled = false;
        holdButton.isEnabled = false;
        dieLabel.isHidden = true;
        playerPromptLabel.isHidden = true;
    }
    
    
    @IBAction func startTurn(_ sender: Any) {
        
        nextButton.setTitle("Tap to continue", for: .normal);
        nextButton.isEnabled = false;
        rollButton.isEnabled = true;
        holdButton.isEnabled = false;
        
        playerPromptLabel.isHidden = false;
        playerPromptLabel.text = "Player \(game.getCurrentTurn + 1)'s turn - tap Roll to begin.";
        
        dieLabel.isHidden = true;
    }
    
    @IBAction func roll(_ sender: Any) {
        // TODO: generate random value and change dieLabel
        currentRoll = game.rollAndUpdateScore();
        dieLabel.isHidden = false;
        dieLabel.text = String(currentRoll);
        holdButton.isEnabled = true;
        
        print("Just rolled \(currentRoll)");
        
        if currentRoll == 1 { // Bust - end turn with no points gained
            rollButton.isEnabled = false;
            holdButton.isEnabled = false;
            
            print("Ending turn of player \(game.getCurrentTurn)")
            if game.getCurrentTurn == 0 {
                playerPromptLabel.text = "Lose turn! It's now player 2's turn"
            } else {
                playerPromptLabel.text = "Lose turn! It's now player 1's turn"
            }
            
            game.endTurn();
            
            // Allow next player to start turn
            nextButton.isEnabled = true;
        }
        
        playerPromptLabel.text = "Turn total \(game.getCurrentTurnScore)";
    }

    @IBAction func hold(_ sender: Any) {
        
        if game.getCurrentTurn == 0 {
            playerPromptLabel.text = "\(game.getCurrentTurnScore) points scored! It's now player 2's turn";
            player1Score.text = String(game.endTurn());
        } else {
            playerPromptLabel.text = "\(game.getCurrentTurnScore) points scored! It's now player 1's turn";
            player2Score.text = String(game.endTurn());
        }
        
        // Allow next player to start turn
        nextButton.isEnabled = true;
    }
    
//    func runPlayerTurn() {
//        
//        var turnScore = 0;
//        while currentRoll != 1 {
//            
//            turnScore += currentRoll;
//            dieLabel.text = String("\(currentRoll)");
//            
//            if askContinue() {
//                currentRoll = game.rollDie();
//                continue;
//            } else {
//                game.endTurn(score: turnScore);
//                return;
//            }
//        }
//        print("Player \(game.getCurrentTurn()) busts");
//        game.endTurn(score: 0);
//    }
//
//    func askContinue() -> Bool {
//        rollButton.isEnabled = true;
//        holdButton.isEnabled = true;
//
//        return false;
//    }
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var holdButton: UIButton!
    @IBOutlet weak var rollButton: UIButton!
    @IBOutlet weak var playerPromptLabel: UILabel!
    @IBOutlet weak var dieLabel: UILabel!
    @IBOutlet weak var player1Score: UILabel!
    @IBOutlet weak var player2Score: UILabel!
    @IBOutlet weak var player1Progress: UIProgressView!
    @IBOutlet weak var player2Progress: UIProgressView!
}

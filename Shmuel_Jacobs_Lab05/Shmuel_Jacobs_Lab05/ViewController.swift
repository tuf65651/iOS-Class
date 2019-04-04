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
    
    let rollButtonColor = UIColor(red: 137/255, green: 197/255, blue: 141/255, alpha: 1);
    let holdButtonColor = UIColor(red: 185/255, green: 103/255, blue: 97/255, alpha: 1);
    let disabledButtonColor = UIColor.lightGray;
    let nextColor = UIColor.blue;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        rollButton.isEnabled = false;
        rollButton.setTitleColor(rollButtonColor, for: .normal);
        holdButton.isEnabled = false;
        holdButton.setTitleColor(holdButtonColor, for: .normal);
        
        dieLabel.isHidden = true;
        playerPromptLabel.isHidden = true;
        
        
        newGameButton.isEnabled = true;
        newGameButton.isHidden = false;
        
        nextButton.isEnabled = false;
        nextButton.isHidden = true;
        nextButton.setTitleColor(nextColor, for: .normal);
        
        holdButton.setTitleColor(disabledButtonColor, for: .disabled);
        rollButton.setTitleColor(disabledButtonColor, for: .disabled);
        nextButton.setTitleColor(disabledButtonColor, for: .disabled);
    }
    
    @IBAction func newGame(_ sender: Any) {
        
        player1Progress.progress = 0;
        player2Progress.progress = 0;
        newGameButton.isHidden = true;
        nextButton.isHidden = false;
        nextButton.isEnabled = true;
        
        game.reset();
        
        startTurn(nil);
    }
    
    @IBAction func startTurn(_ sender: Any) {
        
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
        } // Player did not just score points
        
        // Note: Game will know if current player just won. If current player just changed then score didn't
        
        // Check if game over
        if game.justWon() {
            playerPromptLabel.text = "Congratulations Player \(game.getCurrentTurn + 1)! Good game."
            cleanupGame();
        } else {
            playerPromptLabel.text = "Turn total \(game.getCurrentTurnScore)";
        }
    }

    @IBAction func hold(_ sender: Any) {
        
        holdButton.isEnabled = false;
        rollButton.isEnabled = false;
        
        if game.getCurrentTurn == 0 {
            player1Progress.progress += Float(game.getCurrentTurnScore / game.WINNINGSCORE);
            playerPromptLabel.text = "\(game.getCurrentTurnScore) points scored! It's now player 2's turn";
            player1Score.text = String(game.endTurn());
        } else {
            player2Progress.progress += Float(game.getCurrentTurnScore / game.WINNINGSCORE);
            playerPromptLabel.text = "\(game.getCurrentTurnScore) points scored! It's now player 1's turn";
            player2Score.text = String(game.endTurn());
        }
        
        // Allow next player to start turn
        nextButton.isEnabled = true;
    }
    
    func cleanupGame() {
        rollButton.isEnabled = false;
        holdButton.isEnabled = false;
        nextButton.isHidden = true;
        newGameButton.isHidden = false;
        newGameButton.isEnabled = true;
        
        //playerPromptLabel.text = "Tap to play again."
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
    
    @IBOutlet weak var newGameButton: UIButton!
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


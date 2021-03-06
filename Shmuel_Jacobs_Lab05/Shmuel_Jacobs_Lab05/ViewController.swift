//
//  ViewController.swift
//  Shmuel_Jacobs_Lab05
//
//  Created by Shmuel Jacobs on 3/28/19.
//  Copyright © 2019 Shmuel Jacobs. All rights reserved.
//
/**
 - author: Shmuel Jacobs
 - TUID: 915046889
 - class: Intro to iOS
 - assignment: Lab 5
 - purpose: Hands on experience utilizing XCode as a development environment; using Interface Builder; declaring and wiring up IBOutlets; declaring and wiring up IBActions; using various iOS widgets - UILabel, UIButton, UIImageView, UIProgressView; testing applications in the iPhone Simulator
 */

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
        
        // Don't allow gameplay before beginning game
        rollButton.isEnabled = false;
        rollButton.setTitleColor(rollButtonColor, for: .normal);
        holdButton.isEnabled = false;
        holdButton.setTitleColor(holdButtonColor, for: .normal);
        dieLabel.isHidden = true;
        playerPromptLabel.isHidden = true;
        
        // Allow user to begin game
        newGameButton.isEnabled = true;
        newGameButton.isHidden = false;
        nextButton.isEnabled = false;
        nextButton.isHidden = true;
        nextButton.setTitleColor(nextColor, for: .normal);
        
        // Grey out disabled buttons
        holdButton.setTitleColor(disabledButtonColor, for: .disabled);
        rollButton.setTitleColor(disabledButtonColor, for: .disabled);
        nextButton.setTitleColor(disabledButtonColor, for: .disabled);
    }
    
    @IBAction func newGame(_ sender: Any) {
        
        // Set view to indicate no score yet
        player1Progress.setProgress(0, animated: true)
        player2Progress.setProgress(0, animated: true)
        // Game in progress, so don't show newGame button
        newGameButton.isHidden = true;
        // show next button
        nextButton.isHidden = false;
        nextButton.isEnabled = true;
        
        game.reset();
        
        // Easiest to duplicate code from newTurn
        nextButton.isEnabled = false;
        rollButton.isEnabled = true;
        holdButton.isEnabled = false;
        playerPromptLabel.isHidden = false;
        playerPromptLabel.text = "Player \(game.getCurrentTurn + 1)'s turn - tap Roll to begin.";
        dieLabel.isHidden = true;
    }
    
    @IBAction func newTurn(_ sender: Any) {
        
        // Allow player to start rolling
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
        // display roll value
        dieLabel.isHidden = false;
        dieLabel.text = String(currentRoll);
        holdButton.isEnabled = true;
        
        print("Just rolled \(currentRoll)");
        
        // 
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
        let justScored = game.getCurrentTurnScore;
        let endingScore = game.endTurn();
        
        if game.getCurrentTurn == 0 {
            player1Progress.setProgress( Float(endingScore) / Float(game.WINNINGSCORE), animated: true );
            playerPromptLabel.text = "\(justScored) points scored! It's now player 2's turn";
            player1Score.text = String(endingScore);
        } else {
            player2Progress.setProgress( Float(endingScore) / Float(game.WINNINGSCORE), animated: true);
            playerPromptLabel.text = "\(justScored) points scored! It's now player 1's turn";
            player2Score.text = String(endingScore);
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
        
        game.reset();
        
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


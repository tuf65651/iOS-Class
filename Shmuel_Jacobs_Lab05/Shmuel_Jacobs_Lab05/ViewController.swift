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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        rollButton.isEnabled = false;
        holdButton.isEnabled = false;
    }
    
    @IBAction func startGame(_ sender: Any) {
        newGameButton.setTitle("Tap to continue", for: .normal);
        newGameButton.isEnabled = false;
        
        playerPromptLabel.isHidden = false;
        playerPromptLabel.text = "Player 1's turn - tap Roll to begin.";
        
        dieLabel.isHidden = true;
    }
    
    @IBAction func roll(_ sender: Any) {
        // TODO: generate random value and change dieLabel
        currentRoll = game.rollDie();
    }

    @IBAction func hold(_ sender: Any) {
        
    }
    
    func runPlayerTurn() {
        
        var turnScore = 0;
        while currentRoll != 1 {
            
            turnScore += currentRoll;
            dieLabel.text = String("\(currentRoll)");
            
            if askContinue() {
                currentRoll = game.rollDie();
                continue;
            } else {
                game.endTurn(score: turnScore);
                return;
            }
        }
        print("Player \(game.getCurrentTurn()) busts");
        game.endTurn(score: 0);
    }
    
    func askContinue() -> Bool {
        rollButton.isEnabled = true;
        holdButton.isEnabled = true;
        
        return false;
    }
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var holdButton: UIButton!
    @IBOutlet weak var rollButton: UIButton!
    @IBOutlet weak var playerPromptLabel: UILabel!
    @IBOutlet weak var dieLabel: UILabel!
    @IBOutlet weak var player1Score: UILabel!
    @IBOutlet weak var player2Score: UILabel!
    @IBOutlet weak var player1Progress: UIProgressView!
    @IBOutlet weak var player2Progress: UIProgressView!
}


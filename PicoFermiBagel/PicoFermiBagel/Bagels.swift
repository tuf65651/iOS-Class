//
//  Bagels.swift
//  PicoFermiBagel
//
//  Created by Shmuel Jacobs on 2/14/19.
//  Copyright © 2019 Icebreaker Industries. All rights reserved.
//

import Foundation

class Bagels {
    var secretNumber:String;
    var stillPlaying:Bool;
    var currentGuess:String;
    
    init(){
        stillPlaying = true;
        secretNumber = "";
        currentGuess = "";
    }
    
    // Return secret number as three digit string
    func generateSecretNumber() {
        //TODO: logic for return secret number
        secretNumber = "500";
    }
    
    // Check if arguent matches secret number
    func isGuessCorrect(guess:String) -> Bool {
        return guess == secretNumber;
    }
    
    // Prompt user to enter guess
    func acceptGuess() {
        print("Type in a three digit number, if you've got the nerve.");
        if let tryInput:String = readLine() {
            currentGuess = tryInput;
        }
        else {currentGuess = ""};
        // Invalid input will be ignored if too short else truncated to first three chars and used.
    }
    
    // Print 'Begels' if no matching digits, else print 'Fermi' for each digit in correct place, 'Pico' for wrong place
    func buildHint(guess: String) -> String {
        
        var hint = "";
        var secretDigits:Array<Character> = Array(secretNumber);
        var leftToMatch:Array<Character> = Array(guess);
        
        // Loop searching for exact matches
        for i in 0...2 {
            
            if leftToMatch[i] == secretDigits[i] {
                // Write placeholder to avoid double matching
                leftToMatch[i] = "\r";
//
                hint = "Fermi " + hint;
            } // Search all exact matches before Out of Place matches to avoid guess:011 secret:991 returning Pico
        }
        // Loop searching for Out of Place Match
        for i in 0...2 {
            if leftToMatch.contains(secretDigits[i]){
                // find out of place match
//                print("Found out of place match");
                leftToMatch[leftToMatch.index(of: secretDigits[i])!] = "\r";
                hint.append("Pico ");
            }
        } // endfor -- counted all matches
//        }
        return String("guess - \(currentGuess), \(hint.isEmpty ? "Bagels" : hint)");
    }
    
    func printHint(guess: String){
        print(buildHint(guess: guess));
    }
    
    public func playGame() {
        generateSecretNumber();
        
        print("I have a number in mind. Do you have a guess?\n");
        
        repeat {
            acceptGuess();
            if isGuessCorrect(guess: currentGuess){
                stillPlaying = false;
            } else {
                printHint(guess: currentGuess);
            }
        } while (stillPlaying)
        print("guess - \(currentGuess), Winner!");
    }
}

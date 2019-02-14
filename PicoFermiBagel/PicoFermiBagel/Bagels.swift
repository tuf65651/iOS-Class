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
    }
    
    // Print 'Begels' if no matching digits, else print 'Fermi' for each digit in correct place, 'Pico' for wrong place
    func buildHint() -> String {
//        var exact = 0;
//        var inexact = 0;
        var hint = "";
        var secretDigits:Array<Character> = Array(secretNumber);
        var leftToMatch:Array<Character> = Array(currentGuess);
        print("sd \(secretDigits.count) ltm \(leftToMatch.count)")
//        if leftToMatch.count > 0 {
        for i in 0...2 {
            print(i)
//                let digit:Character = leftToMatch.remove(at: 0);
            //print("digit is \(digit)")
            // find exact match
            if leftToMatch[i] == secretDigits[i] {
                leftToMatch[i] = "\r";
                print("Found exact match");
                hint = "Fermi " + hint;
            } else if leftToMatch.contains(secretDigits[i]){
                // find out of place match
                print("Found out of place match");
                leftToMatch[leftToMatch.index(of: secretDigits[i])!] = "\r";
                hint.append("Pico ");
            }
        } // endfor -- counted matches
//        }
        return String("guess - \(currentGuess) \(hint.isEmpty ? "Bagels" : hint)");
    }
    
    func printHint() {
        print(buildHint());
    }
    
    public func playGame() {
        generateSecretNumber();
        
        print("I have a number in mind. Do you have a guess?\n");
        
        repeat {
            acceptGuess();
            if isGuessCorrect(guess: currentGuess){
                stillPlaying = true;
            } else {
                printHint()
            }
        } while (stillPlaying)
        
        print("Thanks for playing")
    }
}

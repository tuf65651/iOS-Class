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
        // generate number in [100, 999]
//        let generated: UInt32 = arc4random_uniform(900) + 100;
//        secretNumber = String(generated);
        secretNumber = "171";
    }
    
    // Check if arguent matches secret number
    private func isGuessCorrect(guess:String) -> Bool {
        return guess == secretNumber;
    }
    
    // Prompt user to enter guess
    private func acceptGuess() {
        print("Type in a three digit number, if you've got the nerve.");

        var validInput:Bool = false;
        repeat {
            if let tryInput = readLine(){
                if (tryInput.count != 3){
                    print("Enter three digits");
                }
                else {
                    validInput = true;
                    currentGuess = tryInput;
                }
            } // readline didn't send anything back
            else {
                print("Type your guess and then return");
            }
        } while !validInput
        // Invalid input will be ignored if too short else truncated to first three chars and used.
    }
    
    // Print 'Bagels' if no matching digits, else print 'Fermi' for each digit in correct place, 'Pico' for wrong place
    private func buildHint(guess: String) -> String {
        
        var hint = "";
        var secretDigits:Array<Character> = Array(secretNumber);
        var leftToMatch:Array<Character> = Array(guess);
        
        // Loop searching for exact matches
        for i in 0...2 {
            
            if leftToMatch[i] == secretDigits[i] {
                // Write placeholders to avoid double matching
                leftToMatch[i] = "\r";
                secretDigits[i] = "\t"
//
                hint = "Fermi " + hint;
            } // Search all exact matches before Out of Place matches to avoid guess:011 secret:991 returning Pico
        }
        // Loop searching for Out of Place Match
        for i in 0...2 {
            if secretDigits.contains(leftToMatch[i]){ // find out of place match
                leftToMatch[leftToMatch.index(of: secretDigits[i])!] = "\r";
                hint.append("Pico ");
            }
        } // endfor -- counted all matches
//        }
        return String("guess - \(currentGuess), \(hint.isEmpty ? "Bagels" : hint)");
    }
    
    private func printHint(guess: String){
        print(buildHint(guess: guess));
    }
    
    public func playGame() {
        generateSecretNumber();
        
        print("I have a number in mind. Do you have a guess?\n");
        
        repeat {
            acceptGuess();
            
            // Allow early quit
            if (Set(["Q", "QUIT"]).contains(currentGuess.uppercased())){
                print("Goodbye");
                exit(0);
            }
            
            // Did user guess the number?
            if isGuessCorrect(guess: currentGuess){
                stillPlaying = false;
            } else {
                printHint(guess: currentGuess);
            }
        } while (stillPlaying)
        print("guess - \(currentGuess), Winner!");
    }
}

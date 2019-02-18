//
//  main.swift
//  PicoFermiBagel
//
//  Created by Shmuel Jacobs on 2/14/19.
//  Copyright © 2019 Icebreaker Industries. All rights reserved.
//

import Foundation

let continueResponses: Set = ["Y", "YES"];

func askContinue() -> Bool {
    print("Play again? (y, yes)");
    let userResponse:String? = readLine();
    if let realResponse = userResponse?.uppercased() {
        return (continueResponses.contains(realResponse));
    } else {
        return askContinue();
    }
}

func main() {
    var running = true;
    var game: Bagels;
    repeat {
        game = Bagels();
        game.playGame();
        running = askContinue();
    } while running
    
    print("Thanks for playing");
}

main();

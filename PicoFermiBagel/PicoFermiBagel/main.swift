//
//  main.swift
//  PicoFermiBagel
//
//  Created by Shmuel Jacobs on 2/14/19.
//  Copyright © 2019 Icebreaker Industries. All rights reserved.
//

import Foundation

let game = Bagels();
var running = true;
repeat {
    game.playGame();
    running = askContinue();
} while running

let continueResponses: Set = ['Y', 'YES'];

func askContinue() -> Bool {
    print("Play again? (y, yes)");
    let userResponse:String? = readLine();
    if let realResponse = userResponse!.uppercased() {
        return (realResponse in continuResponses);
    } else {
        return askContinue();
    }
}

//
//  main.swift
//  Lab03
//
//  Created by Shmuel Jacobs on 3/10/19.
//  Copyright © 2019 Shmuel Jacobs. All rights reserved.
//

import Foundation

class TempleBookstore {
    
    enum inputCodes {
        case INVALID, ADD, SELL, TITLES, INFO, INCOME, QUIT;
    }
    
    private var store:Bookstore;
    private var running:Bool;
    private var latestInput:String?;
    
    init() {
        running = true;
        store = Bookstore();
    }
    
    func prompt() {
        let menuOptions = """
1) Add a book to the stock
2) Sell a book in stock
3) List the titles of all the books in stock (in the Bookstore object)
4) List all the information about the books in stock (in the Bookstore object)
5) Print out the gross income of the bookstore
6) Quit
""";
    }
    
    func handleAddInteraction() {
        let titlePrompt = "Input title of book on single line...";
        let pricePrompt = "Input price of book as number of cents (ommiting all non-numeric characters..)";
        let numPagesPrompt = "Input number of pages in book (ommiting all non-numeric characters..)";
        let quantPrompt = "Input quantity added (ommiting all non-numeric characters..";
        
        // Get title of book
        print(titlePrompt);
        getInput();
        while(!latestInput) {
            print(titlePrompt);
            getInput();
        }
        let addTitle = latestInput;
        
        // Get quantity add
        print(quantPrompt);
        getInput();
        while(! Int(latestInput )) {
            print(quantPrompt);
            getInput();
        }
        let addQuant = latestInput;
        
        // Check for price and length info
        if !store.inStock(title: <#T##String#>, quantity: 0) {
            
            // Get price info
            print(pricePrompt);
            getInput();
            while(! Double(latestInput) / 100 ){
                print(pricePrompt);
                getInput();
            }
            let addPrice:Double = Double( latestInput ) / 100;
            
            // Get paage count
            print(numPagesPrompt);
            getInput();
            while(! Int(latestInput) ){
                print(numPagesPrompt);
                getInput();
            }
            let addPages:Int = latestInput;
            
            store.
        }
    }
    
    func getInput()->inputCodes {
        let userResponse:String? = readLine();
        if let realResponse = userResponse?.uppercased() {
            latestInput = realResponse;
        } else {
            realResponse = nil;
        }
    }
}

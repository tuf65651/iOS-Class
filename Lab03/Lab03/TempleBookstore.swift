//
//  main.swift
//  Lab03
//
//  Created by Shmuel Jacobs on 3/10/19.
//  Copyright © 2019 Shmuel Jacobs. All rights reserved.
//

import Foundation

class TempleBookstore {
    
    enum inputCodes:Character {
        case ADD = "1";
        case SELL = "2";
        case TITLES = "3";
        case INFO = "4";
        case INCOME = "5";
        case QUIT = "6";
    }
    
    private var store:Bookstore;
    private var running:Bool;
    private var latestInput:String?;
    
    let header = """
[][][][][][][][][][][][][][][][][][][][][][][][][][][]
[][]
[][]
[][]         Welcome to Temple Bookstore!         [][]
[][]                                              [][]
[][][][][][][][][][][][][][][][][][][][][][][][][][][]
""";
    
    init() {
        running = true;
        store = Bookstore()!;
    }
    
    let menuOptions = """
=====================================================
What would you like to do today?
1) Add a book to the stock
2) Sell a book in stock
3) List the titles of all the books in stock (in the Bookstore object)
4) List all the information about the books in stock (in the Bookstore object)
5) Print out the gross income of the bookstore
6) Quit
""";
    let goodbye = "We hope to see you again!";
    
    // Provide text interface for adding books to inventory.
    // Call all Book and Bookstore logic necessary.
    func handleAddInteraction() {
        let titlePrompt = "Input title of book on single line...";
        let pricePrompt = "Input price of book as number of cents (ommiting all non-numeric characters..)";
        let numPagesPrompt = "Input number of pages in book (ommiting all non-numeric characters..)";
        let quantPrompt = "Input quantity added (ommiting all non-numeric characters..)";
        
        // Get title of book
        print(titlePrompt);
        getInput();
        while(latestInput == nil) {
            print(titlePrompt);
            getInput();
        }
        let addTitle = latestInput!;
        
        // Get quantity add
        print(quantPrompt);
        getInput();
        while( (latestInput == nil) || (Int(latestInput!) == nil) ) {
            print(quantPrompt);
            getInput();
        }
        let addQuant = Int(latestInput!)!;
        
        // Check for price and length info
        if !store.inStock(title: addTitle, quantity: 0) {
            
            // Get price info
            print(pricePrompt);
            getInput();
            while(latestInput == nil || Int(latestInput!) == nil ){
                print(pricePrompt);
                getInput();
            }
            let addPrice:Double = Double( Int(latestInput!)! ) / 100;
            
            // Get page count
            print(numPagesPrompt);
            getInput();
            while( latestInput == nil ){
                print(numPagesPrompt);
                getInput();
            }
            let addPages:Int = Int(latestInput!)!;
            
            let newBook = Book(theTitle: addTitle, pages: addPages, cost: addPrice, num: 0);
            store.addNewBook(book: newBook!);
        }
        
        store.addBookQuantity(title: addTitle, quantity: addQuant);
    }
    
    // Provide text interface for purchase.
    // Call all Book and Bookstore logic necessary.
    func handleSellInteraction() {
        let titlePrompt = "Input title of book on single line...";
        
        // Get title of book
        print(titlePrompt);
        getInput();
        while(latestInput == nil) {
            print(titlePrompt);
            getInput();
        }
        let sellTitle = latestInput!;
        
        if !store.inStock(title: sellTitle, quantity: 0) {
            print("That title is unknown. Please check for mistakes and missplelling.");
            return;
        }
        
        // Get quantity purchased
        let quantPrompt = "Input quantity purchased (ommiting all non-numeric characters..)";
        print(quantPrompt);
        getInput();
        while(latestInput==nil || Int(latestInput!)==nil ){
            print(quantPrompt);
            getInput();
        }
        let sellQuantity:Int = Int(latestInput!)!;
        
        if store.sellBook(title: sellTitle, quantity: sellQuantity){
            print("Transaction complete - \(sellQuantity) copies of \(sellTitle) purchased");
        } else {
            print("Transaction failed");
        }
    }
    
    // Wrapper function for listing all titles available.
    func handleTitlesInquiry() {
        store.listTitles();
    }
    
    // Wrapper function for printing al available information from bookstore
    func handleListingInquiry() {
        store.listBooks();
    }
    
    // Wrapper function for getting income collected by bookstore.
    func showIncome() {
        print(store.getIncome());
    }
    
    // Main function of each main loop iteration. Get user selection and invoke function corresponding to user selection.
    func handleMainMenuResponse() {
        
        let menuReminder = "Select a valid menu option -- just type a number from 1 to 6, inclusive...";
        // force valid selection from menu
        getInput();
        while latestInput == nil || inputCodes(rawValue: latestInput![latestInput!.startIndex]) == nil {
            print(menuReminder);
            getInput();
        }
        let menuOption: inputCodes = inputCodes(rawValue: latestInput![latestInput!.startIndex])!;
        
        // invoke correct handler function
        switch (menuOption){
        case inputCodes.ADD:
            handleAddInteraction();
        case inputCodes.SELL:
            handleSellInteraction();
        case inputCodes.TITLES:
            handleTitlesInquiry();
        case inputCodes.INFO:
            handleListingInquiry();
        case inputCodes.INCOME:
            showIncome();
        case inputCodes.QUIT:
            running = false;
        default: // If default is reached, something is terribly wrong
            print(menuReminder);
        }
    }
    
    // Read last line from standard input. If valid, store in latestInput, else mark latestInput invalid.
    func getInput() {
        let userResponse:String? = readLine();
        if let realResponse = userResponse?.uppercased() {
            latestInput = realResponse;
        } else {
            latestInput = nil; // Invalidate persistent input storage, for future logic.
        }
    }
    
    func main() {
        
        print(header);
        // main loop
        while running {
            print(menuOptions);
            handleMainMenuResponse();
        }
        print(goodbye);
    }
}



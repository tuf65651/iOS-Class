//
//  Bookstore.swift
//  Lab03
//  Intro to iOS Development
//
//  Created by Shmuel Jacobs on 3/10/19.
//  Copyright © 2019 Shmuel Jacobs. All rights reserved.
//

import Foundation

class Bookstore {
    
    private var books = [Book]();
    private var totalbooks:Int;
    private var gross:Double;
    private let MAXNUMOFBOOKS = 1000;
    
    // a non-failable initializer that creates a new, empty Bookstore object.
    public init() {
        books = [];
        totalbooks = 0;
        gross = 0;
    }
    
    public func addNewBook(book:Book) {
        books.append(book);
    }
    
    // Adds quantity number of books to the book already in stock in the Bookstore object with
    // the title title. If the book is not in the Bookstore object, nothing is done.
    public func addBookQuantity(title:String, quantity:Int) {
        
        for i in 0..<books.count {
            if books[i].getTitle() == title {
                books[i].addQuantity(amount: quantity);
                totalbooks += quantity;
                break;
            }
        }
    }
    
    // Returns true if quantity or more copies of a book with the title are contained in the Bookstore object.
    public func inStock(title:String, quantity:Int)->Bool {
        let knownBookFound:Book? = books.first(where: {$0.getTitle() == title})
        if let bookFound = knownBookFound {
            if bookFound.getQuantity() >= quantity{
                return true;
            } else {
                //TODO: major refactor needed, then move response to outer class
                print("only \(bookFound.getQuantity()) copies available");
            }
        }
        return false;
    }
    
    // Executes selling quantity number of books from the Bookstore object with the title to the
    // buyer. (Note: there is no I/O done in this method, the Bookstore object is changed to reflect
    // the sale. The method returns true if the sale was executed successfully, false otherwise.
    public func sellBook(title:String, quantity:Int)->Bool {
        if !inStock(title: title, quantity: quantity) {
            return false;
        }
        // Find correct entry and update inventory
        for i in 0..<books.count {
            if books[i].getTitle() == title {
                // Brilliant architecture -- every function loops over whole list -- why not use dictionary keyed to title?
                addBookQuantity(title:title, quantity: -1 * quantity);
                gross += (books[i].getPrice() * Double(quantity));
                return true;
            }
        }
        // Code below should be unreachable
        print("Threre's been a terrible mistake");
        return false;
    }
    
    // Lists all of the titles of the books in the Bookstore object.
    public func listTitles() {
        for b in books {
            print("\(b.getTitle())\n");
        }
    }
    
    // Lists all of the information about the books in the Bookstore object.
    public func listBooks() {
        print("\(totalbooks) in stock.\nItems:");
        for b in books {
            print("\(b.toString())");
        }
    }
    
    // Returns the total gross income of the Bookstore object.
    public func getIncome()->Double {
        return gross;
    }
}

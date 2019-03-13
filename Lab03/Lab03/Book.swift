//
//  Book.swift
//  Lab03
//  Intro to iOS Development
//
//  Created by Shmuel Jacobs on 3/10/19.
//  Copyright © 2019 Shmuel Jacobs. All rights reserved.
//

import Foundation

class Book {
    
    private var title: String;
    private var numOfPages: Int;
    private var price: Double;
    private var quantity: Int;
    
    // a failable Initializer: Takes in the title of the book, the number of pages in the book, the cost of the book
    // and the number of copies (quantity) of books and initializes each of the appropriate propertiesin
    //the object.
    public init?(theTitle: String, pages: Int, cost: Double, num: Int) {
        if theTitle.isEmpty {
            
            return nil;
            
        } else {
            self.title = theTitle;
            self.numOfPages = pages;
            self.price = cost;
            self.quantity = num
        }
    }
    
    // Returns the title of the Book object the method is called on.
    public func getTitle() -> String {
        return title;
    }
    
    // Returns the price of the Book object the method is called on.
    public func getPrice() -> Double {
        return price;
    }
    
    // Returns the quantity of the Book object the method is called on.
    public func getQuantity() -> Int {
        return quantity;
    }
    
    // Returns all the information about a Book object as a String. (Add spaces or tabs to make it readable!)
    public func toString() -> String {
        return String( "Book Title: \(getTitle()), Book Price: \(getPrice()), Quantity: \(getQuantity())" );
    }
    
    // Decrements the number of copies, by the given amount, for the Book object the method is called on.
    public func subtractQuantity(amount: Int) {
        quantity = quantity - amount;
    }
    
    //Increments the number of copies, with the given amount, for the Book object the method is called on.
    public func addQuantity(amount: Int) {
    quantity = quantity + amount;
    }
    
}

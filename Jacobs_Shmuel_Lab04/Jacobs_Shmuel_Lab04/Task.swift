//
//  Task.swift
//  Jacobs_Shmuel_Lab04
//
//  Created by Shmuel Jacobs on 3/21/19.
//  Copyright © 2019 Shmuel Jacobs. All rights reserved.
//

import Foundation

class Task {
    
    public enum Priority {
        case low
        case medium
        case high
    }
    
    public var text: NSString?
    public var dueDate: NSDate?
    public var priority: Priority
    public var completed: Bool
    
    public convenience init() {
        self.init();
    }
    
    public init(text: String?, dueDate: Date?, priority: Priority = .medium, completed: Bool = false) {
        if let inputText:String = text {
            self.text = inputText as NSString;
        } else {
            self.text = nil;
        }
        if let inputDate: Date = dueDate {
            self.dueDate = inputDate as NSDate;
        } else {
            self.dueDate = nil;
        }
        self.priority = priority
        self.completed = completed;
    }
    
}

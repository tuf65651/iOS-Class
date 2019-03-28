//
//  Task.swift
//  Jacobs_Shmuel_Lab04
//
//  Created by Shmuel Jacobs on 3/21/19.
//  Copyright © 2019 Shmuel Jacobs. All rights reserved.
//
/**
 - author: Shmuel Jacobs
 - TUID: 915046889
 - class: Intro to iOS
 - assignment: Lab 4
 - purpose: Hands on experience utilizing XCode as a development environment, compiling Swift source code, foundation framework classes, writing custom Swift classes, declaring properties.
 */

import Foundation

public enum Priority {
    case low
    case medium
    case high
}

class Task: Equatable {
    
    // Tasks are considered equal only if ALL properties match
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.completed == rhs.completed && lhs.dueDate == rhs.dueDate && lhs.priority == rhs.priority && lhs.text == rhs.text;
    }
    
    public var text: NSString?
    public var dueDate: NSDate?
    public var priority: Priority
    public var completed: Bool
    
    public init() {
        text = nil;
        dueDate = nil;
        self.priority = .medium;
        self.completed = false;
    }
    
    public init(text: String, dueDate:Date, priority: Priority, completed: Bool) {
        self.text = text as NSString;
        self.dueDate = dueDate as NSDate;
        self.priority = priority
        self.completed = completed;
    }
    
    public convenience init(text: String, dueDate: NSDate) {
        //        let priority = Priority.medium;
//        let completed = false;
        self.init(text: text, dueDate: dueDate as Date, priority: Priority.medium, completed: false);
    }
    
//    Removed from requirements
//    public convenience init(text: String?, dueDate:Date?, priority: Priority = .medium, completed: Bool = false) {
//
//    }
    
    /**
     Check if task was due yesterday or earlier.
     - Note: will not detect task due earlier today is past due
     - Returns: true if task due yesterday or earlier, else false
     */
    public func pastDue() -> Bool {
        
        if let dueDate = dueDate {
            
            let today = NSDate();
            let compToday = Calendar.current.compare(dueDate as Date, to: today as Date, toGranularity: .day);
            
            return compToday == .orderedAscending;
//            var todayComponents = NSDateComponents();
            
//            // Set both times to mindnight to compare dates but not times
//            dueDateComponents.hour = 0;
//            dueDateComponents.minute = 0;
//            dueDateComponents.second = 0;
//
//            todayComponents.
        }
        // no dueDate
        return false;
    }
    
}

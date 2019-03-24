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

class Task: Equatable {
    
    // Tasks are considered equal only if ALL properties match
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.completed == rhs.completed && lhs.dueDate == rhs.dueDate && lhs.priority == rhs.priority && lhs.text == rhs.text;
    }
    
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
    
    public init(text: String, dueDate:Date, priority: Priority = .medium, completed: Bool = false) {
        if let inputText:String = text {
            self.text = inputText as NSString;
        } else {
            self.text = nil;
        }
        if let inputDate: NSDate = dueDate {
            self.dueDate = inputDate;
        } else {
            self.dueDate = nil;
        }
        self.priority = priority
        self.completed = completed;
    }
    
    public convenience init(text: String?, dueDate:Date?, priority: Priority = .medium, completed: Bool = false) {
        //TODO:
    }
    
    public func pastDue() -> Bool {
        
        if var dueDateComponents = NSDateComponents( dueDate ){
            
            let today = NSDate;
            let compToday = Calendar.compare(dueDate, today, toGranularity: .day);
            
            return compToday == .orderedDescending;
//            var todayComponents = NSDateComponents();
            
//            // Set both times to mindnight to compare dates but not times
//            dueDateComponents.hour = 0;
//            dueDateComponents.minute = 0;
//            dueDateComponents.second = 0;
//
//            todayComponents.
        }
    }
    
}

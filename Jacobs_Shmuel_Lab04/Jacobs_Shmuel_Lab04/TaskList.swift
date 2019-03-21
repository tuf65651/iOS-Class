//
//  TaskList.swift
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

class TaskList {
    
    //TODO: make read-only
    private var count: Int;
    private var taskList: [Task]
    
    public init() {
        count = 0;
        taskList = [];
    }
    
    public func completeTasks() -> [Task] {
        return taskList.filter({$0.completed});
    }
    
    public func incompleteTasks() -> [Task] {
        return taskList.filter({!$0.completed});
    }
    
    public func allTasks() -> [Task] {
        return taskList;
    }
    
    public func pastDueTasks() -> [Task] {
        let todayDate = NSDate();
        
        func dueDatePast(task: Task) -> Bool {
            if let dd: Date = task.dueDate as Date {
                return todayDate.timeIntervalSince( dd ) > 0;
            } else {
                return false;
            }
        }
        
        return taskList.filter( dueDatePast );
    }
    
    public func tasksBetween(startDate: Date, endDate: Date) -> [Task] {
        return [];
    }
    
    public func add(task: Task) -> Bool {
        return false;
    }
    
    public func removeAllTasks() {
        
    }
    
    public func remove(task: Task) -> Bool {
        return false;
    }
    
    public func removeCompletedTasks() {
        
    }
}

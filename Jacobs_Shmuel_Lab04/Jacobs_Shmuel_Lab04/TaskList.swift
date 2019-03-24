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
            if let dd: NSDate = task.dueDate {
                return todayDate.timeIntervalSince( dd as Date ) > 0;
            } else {
                return false;
            }
        }
        
        return taskList.filter( dueDatePast );
    }
    
    public func tasksBetween(startDate: NSDate, endDate: NSDate) -> [Task] {
        
        func dueBetweenDates(task: Task, start: NSDate, end: NSDate) -> Bool {
            if let dd: NSDate = task.dueDate {
                if start.timeIntervalSince(dd as Date) > 0 || end.timeIntervalSince(dd as Date) < 0 {
                    return false;
                } else {
                    return true;
                }
            }
            return false;
        }
        
        return taskList.filter( {dueBetweenDates(task: $0, start: startDate, end: endDate)} );
    }
    
    public func add(task: Task) -> Bool {
        return false;
    }
    
    public func removeAllTasks() {
        taskList.removeAll();
    }
    
    public func remove(task: Task) -> Bool {
        if taskList.contains(task) {
            taskList.remove(at: taskList.index(of: task)!);
            return true;
        }
        return false;
    }
    
    public func removeCompletedTasks() {
        taskList = taskList.filter({ !$0.completed });
    }
}

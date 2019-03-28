//
//  main.swift
//  Jacobs_Shmuel_Lab04
//
//  Created by Shmuel Jacobs on 3/20/19.
//  Copyright © 2019 Shmuel Jacobs. All rights reserved.
//
/**
 - author: Shmuel Jacobs
 - TUID: 915046889
 - class: Intro to iOS
 - assignment: Lab 4
 - purpose: Unit tests for Lab4
 */
import Foundation

func unitTests() {
    
    initTests();
    //taskCountReadOnly();
    addRemoveTasksTests();
    tasksListingsTests();
    pastDueTasksTests();
    taskBetweenTests();
    tasksByPriorityTests();
    removeCompletedTests();
}

func initTests() {
    print("Testing Task initializers\n");
    print("Try blank init");
    let blankInit = Task();
    print("Blank init succeeded");
    if let blankText = blankInit.text {
        print("PROBLEM - Initialized with text: \(blankText)");
    } else {
        print("Initialized without text");
    }
    if let blankDueDate = blankInit.dueDate {
        print("PROBLEM - Initialized with dueDate: \(blankDueDate.description)")
    } else {
        print("Initialized without dueDate");
    }
    if blankInit.priority != .medium {
        print("PROBLEM - Initialized with priority \(blankInit.priority)");
    }
    if blankInit.completed {
        print("PROBLEM - Initialized with completed status \(blankInit.completed)");
    }
    // Done testing this initializer
    print();
    
    print("Try init with text and dueDate")
    let textInit = "Born with text";
    let todayDate = NSDate();
    let convenientInit: Task = Task(text: textInit, dueDate: todayDate);
    print("Initialized task with convenience init. Task Description...");
    print("text: \(convenientInit.text)");
    print("dueDate: \(convenientInit.dueDate)");
    print("priotity: \(convenientInit.priority)");
    print("completed: \(convenientInit.completed)");
    
    print("Finished testing initializers\n");
}

//Compiler errors on this function verify
//func taskCountReadOnly() {
//    print("Checking that Tasklist.count is read only\n")
//    let tl = TaskList();
//    if tl.count = 2 {
//        print("PROBLEM - tasklist allows setting count property");
//    } else {
//        print("Tasklist prevents setting count property");
//    }
//    print("Finished checking count accessibility. count = \(tl.count)")
//}

func addRemoveTasksTests() {
    print("Checking that tasks are added and removed correctly")
    let tl = TaskList();
    let t1 = Task();
    let t2 = Task();
    let today = NSDate();
    var neverAdded: Task = Task(text: "This task is never in the list", dueDate: today);
    if !tl.add(task: t1) {
        print("PROBLEM - Failed to add task")
    } else if tl.count != 1 {
        print("PROBLEM - count = \(tl.count)")
    }
    if tl.add(task: t2) {
        print("PROBLEM - allows adding duplicated task")
    }
    if tl.count > 1 {
        print("PROBLEM - increased count on failed add");
    }
    
    if tl.remove(task: neverAdded) {
        print("PROBLEM - got task that wasn't in list");
    }
    if !tl.remove(task: t1) {
        print("PROBLEM - can't get task from list")
    }
    if tl.remove(task: t1) {
        print("PROBLEM - got same task twice in a row\n")
    }
    
    tl.removeAllTasks();
    if tl.count != 0 {
        print("PROBLEM - count doesn't reset when list empties");
    }
    for t in [t1, t2, neverAdded ] {
        if tl.remove(task: t) {
            print("PROBLEM - found task \(t) in list");
        }
    }
    
    print("Finished checking add and remove functionality")
}

func tasksListingsTests() {
    print("Checking listing by completion status")
    let tl = TaskList();
    let t1 = Task();
    t1.completed = true;
    t1.text = "This task is complete";
    
    let t2 = Task();
    t2.completed = true;
    t2.text = "This task is also complete";
    
    let t3 = Task();
    t3.text = "This task is incomplete";
    
    let t4 = Task();
    t4.text = "This task is also incomplete";
    
    let completedTasks = tl.completeTasks();
    let incompleteTasks = tl.incompleteTasks();
    
    if incompleteTasks.contains(t1) {
        print("PROBLEM - t1 in incomplete tasks");
    }
    if incompleteTasks.contains(t2) {
        print("PROBLEM - t2 in incomplete tasks");
    }
    if completedTasks.contains(t3){
        print("PROBLEM - t3 in completed tasks");
    }
    if completedTasks.contains(t4){
        print("PROBLEM - t4 in completed tasks");
    }
    print("Finished check complete and incomplete tasks\n");
    
}

func pastDueTasksTests() {
    print("Checking filter for tasks past due");
    
    var todayCal = Calendar.current;
    
//    var adjustment = DateComponent();
//    adjustment.year = 0;
//    adjustment.month = 0;
//    adjustment.day = 0;
    
    let yesterdayDate = todayCal.date(byAdding: .day, value: -1, to: Date() );
    let tomorrowDate = todayCal.date(byAdding: .day, value: 1, to: Date() );
    let todayDate = todayCal.date(byAdding: .day, value: 0, to: Date() );
    
    let dueYesterday = Task(text: "Task due yesterday", dueDate: yesterdayDate as! NSDate);
    let dueToday = Task(text: "Task due today", dueDate: todayDate as! NSDate);
    let dueTomorrow = Task(text: "Task due tomorrow", dueDate: tomorrowDate as! NSDate);
    
    let tl = TaskList();
    for i in [dueToday, dueTomorrow, dueYesterday] {
        tl.add(task: i);
    }
    let pastDueTasks: [Task] = tl.pastDueTasks();
    
    if pastDueTasks.contains(dueTomorrow) {
        print("PROBLEM - tomorrow's task shows past due")
    }
    if pastDueTasks.contains(dueToday) {
        print("PROBLEM - today's task shows past due");
    }
    if !pastDueTasks.contains(dueYesterday) {
        print("PROBLEM - yesterday's task doesn't show past due");
    }
    
    print("Finished checking filter for tasks past due");
}

func taskBetweenTests() {
    print("Checking search for due within target range");
    let todayCal = Calendar.current;
    let weekAgoDate = todayCal.date(byAdding: .day, value: -7, to: Date() );
    let tomorrowDate = todayCal.date(byAdding: .day, value: 1, to: Date() );
    let todayDate = todayCal.date(byAdding: .day, value: 0, to: Date() );
    let weekFromNowDate = todayCal.date(byAdding: .day, value: 7, to: Date() );
    
    let dueWeekAgo = Task(text: "Task due week ago", dueDate: weekAgoDate as! NSDate);
    let dueToday = Task(text: "Task due today", dueDate: todayDate as! NSDate);
    let dueTomorrow = Task(text: "Task due tomorrow", dueDate: tomorrowDate as! NSDate);
    let dueWeekFromNow = Task(text: "Task due week from now", dueDate: weekFromNowDate as! NSDate);
    
    let tl = TaskList();
    for i in [dueToday, dueTomorrow, dueWeekAgo, dueWeekFromNow] {
        tl.add(task: i);
    }
    
    let startDate: Date = todayCal.date(byAdding: .day, value: -2, to: Date() )!;
    let endDate: Date = todayCal.date(byAdding: .day, value: 2, to: Date() )!;
    let targetDateTasks = tl.tasksBetween(startDate: startDate, endDate: endDate);
    
    if targetDateTasks.contains(dueWeekAgo) {
        print("PROBLEM - including tasks before target range");
    }
    if !targetDateTasks.contains(dueToday) || !targetDateTasks.contains(dueTomorrow){
        print("PROBLEM - excluded tasks within target range");
    }
    if targetDateTasks.contains(dueWeekFromNow) {
        print("PROBLEM - included tasks after target range");
    }
    
    print("Finished checking search for due within target range");
}

func tasksByPriorityTests() {
    print("Checking list tasks by prioriy");
    let today = Date();
    let t1 = Task(text: "This task is low priority", dueDate: today, priority: Priority.low, completed: false);
    let t2 = Task(text: "This task is medium priority", dueDate: today, priority: Priority.medium, completed: false);
    let t3 = Task(text: "This task is high priority", dueDate: today, priority: Priority.high, completed: false);
    let t4 = Task(text: "This task is also medium priority", dueDate: today, priority: Priority.medium, completed: false);
    let tl = TaskList();
    for t in [t1,t2,t3,t4] {
        tl.add(task: t);
    }
    let medTasks = tl.tasks(with: Priority.medium);
    if medTasks.contains(t1) || medTasks.contains(t3) {
        print("PROBLEM - unexpected tasks in medium priority task list");
    }
    if !medTasks.contains(t2) || !medTasks.contains(t4) {
        print("PROBLEM - missing tasks in medium priority task list");
    }
    print("Finished checking filter tasks by priority\n");
}

func removeCompletedTests() {
    print("Checking remove completed tasks");
    let today = Date();
    let t1 = Task(text: "This task is low priority", dueDate: today, priority: Priority.low, completed: false);
    let t2 = Task(text: "This task is medium priority", dueDate: today, priority: Priority.medium, completed: false);
    
    let tl = TaskList();
    for t in [t1,t2] {
        tl.add(task: t);
    }
    t1.completed = true;
    tl.removeCompletedTasks();
    if tl.remove(task: t1) {
        print("PROBLEM - found completed task after removal of completed tasks");
    }
    if !tl.remove(task: t2) {
        print("PROBLEM - removed incomplete task")
    }
    print("Finished checking removal of completed tasks\n");
}

unitTests();

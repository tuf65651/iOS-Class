//
//  LocalCalendarService.swift
//  Synk
//
//  Created by Shmuel Jacobs on 5/5/19.
//  Copyright © 2019 Shmuel Jacobs. All rights reserved.
//

import Foundation
import EventKit

class LocalCalendarService {
    
    let secondsInWeek = 60*60*24*7 as Double;
    var today: NSDate;
    var weekFromNowDate: NSDate;
    let eventStore: EKEventStore;
    let localCalendars: [EKCalendar];
    let formatter = DateFormatter();
    
    init() {
        eventStore = EKEventStore();
        localCalendars = eventStore.calendars(for: .event);
        today = NSDate();
        weekFromNowDate = NSDate(timeIntervalSinceNow: secondsInWeek);
        
        NSLog("Initializing Calendar for events from \(today.description) to \(weekFromNowDate.description)");
    }
    
    func loadEvents() -> [EKEvent] {
        let rawToday = today as Date;
        let rawWeekFromNowDate = weekFromNowDate as Date;
        
        let eventsPredicate = eventStore.predicateForEvents(withStart: rawToday, end: rawWeekFromNowDate, calendars: localCalendars);
        
        NSLog("Trying to find events matching \(eventsPredicate.description)")
        
        return eventStore.events(matching: eventsPredicate);
    }
    
    func loadEvents(start: Date, stop: Date) -> [EKEvent] {
        
        let eventsPredicate = eventStore.predicateForEvents(withStart: start, end: stop, calendars: localCalendars);
        
        NSLog("Trying to find events matching \(eventsPredicate.description)")
        
        return eventStore.events(matching: eventsPredicate);
    }
}

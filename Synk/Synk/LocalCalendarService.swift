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
    
    let secondsInWeek = 60*60*7 as Double;
    var today: NSDate;
    var weekFromNowDate: NSDate;
    let eventStore: EKEventStore;
    let localCalendar: EKCalendar;
    let formatter = DateFormatter();
    
    init() {
        eventStore = EKEventStore();
        localCalendar = EKCalendar(for: .event, eventStore: eventStore);
        today = NSDate.init();
        weekFromNowDate = NSDate(timeIntervalSinceNow: secondsInWeek);
        
        NSLog("Initializing Calendar for events from \(today.description) to \(weekFromNowDate.description)");
    }
    
    func loadEvents() -> [EKEvent] {
        let eventsPredicate = eventStore.predicateForEvents(withStart: today as Date, end: weekFromNowDate as Date, calendars: [localCalendar]);
        
        return eventStore.events(matching: eventsPredicate);
    }
}

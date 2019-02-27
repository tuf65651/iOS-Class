//: Playground - noun: a place where people can play

import Foundation

let startTime: NSDate = NSDate();

let calendar = NSCalendar.current;

var newYearsDayComponents = DateComponents();
newYearsDayComponents.year = 2015;
newYearsDayComponents.month = 1;
newYearsDayComponents.day = 1;
let newYearsDay = calendar.date(from: newYearsDayComponents)!

var valentinesDayComponents = DateComponents();
valentinesDayComponents.year = 2015;
valentinesDayComponents.month = 2;
valentinesDayComponents.day = 14;
valentinesDayComponents.hour = 9;
let valentinesDay = calendar.date(from: valentinesDayComponents)!

let diffVD2NYD = valentinesDay.timeIntervalSince(newYearsDay);

let diffDays = Int(diffVD2NYD/86400);
let diffHours = Int((diffVD2NYD.truncatingRemainder(dividingBy: 86400) / (3600) ))

let diffVD2NYDAsString: String = String(format: "%02d:%02d", diffDays, diffHours);

let fiveAfterTenComponents: DateComponents = DateComponents(year: 2019, month: 2, day: 27, hour: 10, minute: 5, second: 5, nanosecond:0);
let fiveAfterTenStamp = calendar.date(from: fiveAfterTenComponents);
let elapsedTime = -1 * (fiveAfterTenStamp?.timeIntervalSinceNow)!;
let elapsedHours = Int(((elapsedTime.truncatingRemainder(dividingBy: 86400)) / (3600) ) );
let elapsedMinutes = Int((elapsedTime.truncatingRemainder(dividingBy: (86400 * 24) ) ) / 60 );
let elapsedSeconds = Int(( elapsedTime.truncatingRemainder(dividingBy: 86400 * 24 * 60)) / 3600 );

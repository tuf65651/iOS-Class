//
//  Stopwatch.swift
//  Stopwatch
//
//  Created by Shmuel Jacobs on 2/21/19.
//  Copyright © 2019 Icebreaker Industries. All rights reserved.
//

import Foundation

class Stopwatch {
    
    private var startTime: NSDate?
    
    var elapsedTime: TimeInterval {
        if let startTime = self.startTime {
            return -1 * startTime.timeIntervalSinceNow;
        } else {
            return 0;
        }
    }
    
    var elapsedTimeAsString: String {
        let timeFormat = "%02d:%02d";
        return String(format: timeFormat, elapsedTime/60, elapsedTime.truncatingRemainder(dividingBy: 60))
    }
    
    func start() {
        startTime = NSDate();
    }
    
    func stop() {
        startTime = nil;
    }
    
    
}

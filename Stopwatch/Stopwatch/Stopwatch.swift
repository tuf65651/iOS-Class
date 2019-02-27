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
        let timeFormat = "%02d:%02d.%01d";
        
        let elapsedTime = -1 * startTime!.timeIntervalSinceNow;
        //let elapsedHours = Int( elapsedTime.truncatingRemainder(dividingBy: 86400) / 60);
        let elapsedMinutes = Int( elapsedTime.truncatingRemainder(dividingBy: 3600) / 60);
        let elapsedSeconds = Int( elapsedTime.truncatingRemainder(dividingBy: 60));
        let elapsedFractionalSeconds: Double = elapsedTime - Double(Int(elapsedTime));
        //TODO: find smoother floor division
        let elapsedDeciSeconds: Double = elapsedFractionalSeconds;// - elapsedTime.truncatingRemainder(dividingBy: 0.01);
        
        return String(format: timeFormat, elapsedMinutes, elapsedSeconds, elapsedDeciSeconds);
    }
    
    var isRunning: Bool {
        if let _ = startTime {
            return true;
        }
        return false;
    }
    
    func start() {
        startTime = NSDate();
    }
    
    func stop() {
        startTime = nil;
    }
    
    
}

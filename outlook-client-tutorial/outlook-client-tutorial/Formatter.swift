//
//  Formatter.swift
//  outlook-client-tutorial
//
//  Created by Shmuel Jacobs on 4/29/19.
//  Copyright © 2019 IcebreakerIndustries. All rights reserved.
//

import SwiftyJSON

class Formatter {
    class func dateToString(date: JSON) -> String {
        // turn JSON input (assumed really just single datetime object) to single string
        /*************VALIDATION*******************/
        let graphDateString = date.stringValue;
        if (graphDateString.isEmpty) {
            return "";
        }
        
        // DateFormatter Object
        let toDateFormatter = DateFormatter();
        // Set desired format
        toDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ";
        
        let dateObj = toDateFormatter.date(from: graphDateString);
        if (dateObj == nil) {
            return "";
        }
        /*************VALIDATION COMPLETE***********/
        
        // Generate Readable string using valid date
        let toStringFormatter = DateFormatter();
        toStringFormatter.dateStyle = DateFormatter.Style.medium;
        toStringFormatter.timeStyle = DateFormatter.Style.short;
        toStringFormatter.timeZone = TimeZone.current;
        
        return toStringFormatter.string(from: dateObj!);
    }
}

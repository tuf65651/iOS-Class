//
//  TempConverter.swift
//  TempConverterApp
//
//  Created by Shmuel Jacobs on 3/14/19.
//  Copyright © 2019 Icebreaker Industries. All rights reserved.
//

import Foundation

class TempConverter {
    
    /// Type casting for strings ```"F"``` and ```"C"```
    enum TempUnit:String {
        case Far = "F", Cel = "C";
    }
    
    static var startingUnits: TempUnit = .Far;
    
    //private var temp: Int = 0;
    
    /**
     Converts temperature from units input to other standard temperature scale.
     
     - Parameter temp: temperature measurement, in degrees
     - Parameter unit: units used in temp parameter, defaults to Farenheit
     
     - Returns: temperatrue as number of degrees in scale not input
 
    */
    static func convert(temp: Int) -> Int? {
        
        if tempBelowAbsoluteZero(temp: temp, unit: startingUnits){
            return nil;
        }
        if (startingUnits == TempUnit.Far) {
            // convert Farenheit to Celsius
            return 5 * (temp - 32)/9;
        } else {
            // convert Celsius to Farenheit
            return (9 * temp)/5 + 32;
        }
    }
    
    static func toggleUnits() {
        if startingUnits == .Cel {
            startingUnits = .Far;
        } else {
            startingUnits = .Cel;
        }
    }
    
    static func getUnitString() -> String {
        if startingUnits == .Cel {
            return "°C";
        } else {
            return "°F"
        }
    }
    
    static func getToggleString(fromUnit: TempUnit) -> String {
        if fromUnit == .Cel {
            return "°F";
        } else {
            return "°C";
        }
    }
    
    static func getToggleString( ) -> String {
        return getToggleString(fromUnit: startingUnits);
    }
    
    static func tempBelowAbsoluteZero(temp: Int, unit:TempUnit) -> Bool {
        return (temp < -454 && unit == TempUnit.Far ) || (temp < -270 && unit == TempUnit.Cel );
    }
}

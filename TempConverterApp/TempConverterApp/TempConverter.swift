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
    
    //private var temp: Int = 0;
    
    /**
     Converts temperature from units input to other standard temperature scale.
     
     - Parameter temp: temperature measurement, in degrees
     - Parameter unit: units used in temp parameter, defaults to Farenheit
     
     - Returns: temperatrue as number of degrees in scale not input
 
    */
    static func convert(temp: Int, unit: TempUnit = TempUnit.Cel) -> Int? {
        
        if tempBelowAbsoluteZero(temp: temp, unit: unit){
            return nil;
        }
        if (unit == TempUnit.Far) {
            // convert Farenheit to Celsius
            return 5 * (temp - 32)/9;
        } else {
            // convert Celsius to Farenheit
            return (9 * temp)/5 + 32;
        }
    }
    
    static func tempBelowAbsoluteZero(temp: Int, unit:TempUnit) -> Bool {
        return (temp < -454 && unit == TempUnit.Far ) || (temp < -270 && unit == TempUnit.Cel );
    }
}

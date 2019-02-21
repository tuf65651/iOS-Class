//: Playground - noun: a place where people can play

class TempConverter {
    private var temp: Int;
    
    init(temp: Int) {
        self.temp = temp;
    }
    
    static func convert(temp: Int, unit: String = "F") -> Int {
        
        if tempBelowAbsoluteZero(temp: temp, unit: unit){
            return -1000;
        }
        if (unit == "F") {
            return 5 * (temp - 32)/9;
        } else {
            return (9 * temp)/5 + 32;
        }
    }
    
    static func tempBelowAbsoluteZero(temp: Int, unit: String) -> Bool {
        return (temp < -454 && unit == "F") || (temp < -270 && unit == "C");
    }
}

let t = TempConverter(temp: 10);

print(TempConverter.convert(temp: 50));
print(TempConverter.convert(temp: 10, unit: "C"))
print(TempConverter.convert(temp: -460, unit: "F"))

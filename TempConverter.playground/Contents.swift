//: Playground - noun: a place where people can play

class TempConverter {
    private var temp: Int;
    
    init(temp: Int) {
        self.temp = temp;
    }
    
    func convert(unit: String) -> Int {
        if unit == "F" {
            return 5 * (self.temp - 32)/9;
        } else {
            return (9 * self.temp)/5 + 32;
        }
    }
}

let t = TempConverter(temp: 10);

print(t.convert(unit: "F"));

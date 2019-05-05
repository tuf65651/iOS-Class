import Foundation

let dateFormatter = DateFormatter();
let calendar = NSCalendar.current;
let dateComponents = DateComponents();
let date = calendar.date(from: dateComponents)
date?.description
print("Code does run...");

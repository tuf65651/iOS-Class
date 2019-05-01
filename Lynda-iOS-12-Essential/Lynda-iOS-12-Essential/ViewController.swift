//
//  ViewController.swift
//  Lynda-iOS-12-Essential
//
//  Created by Shmuel Jacobs on 4/30/19.
//  Copyright © 2019 Shmuel Jacobs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let data: [[String]] = [
        ["Item 1", "Item 2", "Item 3", "Item 4"],
        ["Item A", "Item B", "Item C"]
    ];
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return data.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data[component].count;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[component][row]
    }

}


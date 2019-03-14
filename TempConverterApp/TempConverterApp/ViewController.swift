//
//  ViewController.swift
//  TempConverterApp
//
//  Created by Shmuel Jacobs on 3/14/19.
//  Copyright © 2019 Icebreaker Industries. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func convertButtonTapped(sender: UIButton) {
        if let inputTemp: String = textInput.text {
            let convertedText = TempConverter.convert(temp: Int(inputTemp)!, unit: TempConverter.TempUnit.Far);
            
        }
    }
    
    @IBOutlet weak var textInput: UITextField!
    
}


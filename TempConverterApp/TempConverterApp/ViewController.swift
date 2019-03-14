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
        var inputTemp: String = textInput.text!;
        var outputTemp: String;
        
        if inputTemp == "" {
            inputTemp = "-500";
        }
        
        outputTemp = "N/A";
        
        // Check for valid input
        if let degreesInput: Int = Int( inputTemp ) {
            if let outputdegrees:Int = TempConverter.convert(temp: degreesInput) {
                outputTemp = String( "\(outputdegrees)" );
            }
        }
        
        displayTemp.text = outputTemp;
    }
    
    @IBAction func switchChanged() {
        TempConverter.toggleUnits();
        updateLabels();
    }
    
    @IBOutlet weak var displayTemp: UILabel!
    @IBOutlet weak var displayUnit: UILabel!
    @IBOutlet weak var inputUnit: UILabel!
    
    @IBOutlet weak var textInput: UITextField!
    
    @IBAction func updateLabels() {
        
        displayUnit.text = TempConverter.getToggleString();
        inputUnit.text = TempConverter.getUnitString();
        
    }
    
}


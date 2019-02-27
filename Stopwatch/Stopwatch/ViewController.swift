//
//  ViewController.swift
//  Stopwatch
//
//  Created by Shmuel Jacobs on 2/21/19.
//  Copyright © 2019 Icebreaker Industries. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let stopwatch = Stopwatch();
    
    @IBOutlet weak var elapsedTimeLabel: UILabel!;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startButtonTapped(sender: UIButton){
        // start clock
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateElapsedTimeLabel), userInfo:nil, repeats: true)
        stopwatch.start();
    }
    
    @IBAction func stopButtonTapped(sender: UIButton){
        // stop clock
        stopwatch.stop();
    }
    
    @objc func updateElapsedTimeLabel(timer: Timer) {
        if stopwatch.isRunning {
            elapsedTimeLabel.text = stopwatch.elapsedTimeAsString
        } else {
            timer.invalidate();
        }
    }

}


//
//  FetchTableViewController.swift
//  Synk
//
//  Created by Shmuel Jacobs on 5/1/19.
//  Copyright © 2019 Shmuel Jacobs. All rights reserved.
//  NOTE: Do not handle no-login case. Program should crash if no login, since it shouldn't be allowed at this point.

import UIKit

class EventConflictViewController: UIViewController {
    
    let service = OutlookService.shared(); // Note: crash if singleton doesn't already have token
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchEvents();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchEvents() {
        service.getUserEmail(callback: {
            email in
            if let unwrappedEmail = email {
                NSLog("Hello \(unwrappedEmail)");
                
                self.service.getEvents(callback: {
                    retrievedMessages in
                    for message in retrievedMessages!["value"].arrayValue { // crash if no JSON response
                        NSLog(message["subject"].stringValue);
                        NSLog(message["start"].stringValue);
                    }
                })
            }
        })
    }
    
}

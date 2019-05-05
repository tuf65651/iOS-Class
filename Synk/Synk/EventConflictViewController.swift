//
//  FetchTableViewController.swift
//  Synk
//
//  Created by Shmuel Jacobs on 5/1/19.
//  Copyright © 2019 Shmuel Jacobs. All rights reserved.
//  NOTE: Do not handle no-login case. Program should crash if no login, since it shouldn't be allowed at this point.
//  Thanks to andrewcbancroft for EventKit Tutorial

import UIKit
import UserNotifications
import EventKit

class EventConflictViewController: UIViewController {
    
    let outlookService = OutlookService.shared(); // Note: crash if singleton doesn't already have token
    let localCalendarService = LocalCalendarService();
    let localCalendar = EKEventStore();
    var localEventQueue: [EKEvent] = [];
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var allGoodLabel: UILabel!
    @IBOutlet weak var remoteEventView: UIView!
    @IBOutlet weak var localEventView: UIView!
    
    @IBOutlet weak var localEventSubjectLabel: UILabel!
    @IBOutlet weak var localEventStartLabel: UILabel!
    @IBOutlet weak var localEventEndLabel: UILabel!
    @IBOutlet weak var remoteEventSubjectLabel: UILabel!
    @IBOutlet weak var remoteEventStartLabel: UILabel!
    @IBOutlet weak var remoteEventEndLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        errorLabel.isHidden = true;
        allGoodLabel.isHidden = true;
        localEventView.isHidden = true;
        remoteEventView.isHidden = true;
        
//        let eventsList = lcs.loadEvents();
//        for event in eventsList {
//            NSLog("Got another event");
//            NSLog(event.description);
//        }
        
        loadEvents();
        showNextLocalEvent();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkLocalCalendarPermission();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchEvents() {
        outlookService.getUserEmail(callback: {
            email in
            if let unwrappedEmail = email {
                NSLog("Hello \(unwrappedEmail)");
                
                self.outlookService.getEvents(callback: {
                    retrievedMessages in
                    for message in retrievedMessages!["value"].arrayValue { // crash if no JSON response
                        NSLog(message["subject"].stringValue);
                        NSLog(message["start"].stringValue);
                    }
                })
            }
        })
    }
    
    func checkLocalCalendarPermission() {
        let permission = EKEventStore.authorizationStatus(for: EKEntityType.event);
        
        switch(permission) {
        case EKAuthorizationStatus.notDetermined:
            requestAccessToCalendar()
        case EKAuthorizationStatus.authorized:
            loadEvents();
        case EKAuthorizationStatus.restricted, .denied:
            showErrorLabel(); // FIXME
        }
    }
    
    func requestAccessToCalendar() {
        localCalendar.requestAccess(to: .event, completion: {
            (accessGranted: Bool, error: Error?) in
            if accessGranted {
                self.loadEvents();
            }
            if let unwrappedError = error {
                self.showErrorLabel(); // FIXME
            }
        })
    }
    
    // FIXME
    func loadEvents() {
        localEventQueue = LocalCalendarService.loadEvents(localCalendarService)();
        NSLog(self.localEventQueue.description);
    }
    
    func showErrorLabel() {
        
    }
    
    @IBAction func showNextLocalEvent() {
//        let nextLocalEvent: EKEvent? = localEventQueue.first;
//        if nextLocalEvent == nil {
        if let nextLocalEvent = localEventQueue.first {
            localEventQueue.removeFirst();
            
            localEventSubjectLabel.isHidden = false;
            localEventStartLabel.isHidden = false;
            localEventEndLabel.isHidden = false;
            localEventView.isHidden = false;
            
            localEventSubjectLabel.text = nextLocalEvent.title;
            localEventStartLabel.text = nextLocalEvent.startDate.description;
            localEventEndLabel.text = nextLocalEvent.endDate.description;
            
        } else {
            
            localEventSubjectLabel.text = "All done!";
            localEventStartLabel.isHidden = true;
            localEventEndLabel.isHidden = true;
        }
    }
}

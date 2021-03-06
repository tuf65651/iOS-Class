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
import SwiftyJSON

struct Event {
    let subject: String;
    let start: String;
    let end: String;
    let isAllDay: Bool;
    let location: String;
    let body: String;
}

class EventConflictViewController: UIViewController {
    
    let outlookService = OutlookService.shared(); // Note: crash if singleton doesn't already have token
    let localCalendarService = LocalCalendarService();
    let localCalendar = EKEventStore();
    var localEventQueue: [EKEvent] = [];
    var outlookEventQueue: [Event] = [];
    var currentRemoteEvent: Event;
    var currentLocalEvent: EKEvent;
    
    @IBOutlet weak var errorLabel: UILabel!
//    @IBOutlet weak var allGoodLabel: UILabel!
    @IBOutlet weak var remoteEventView: UIView!
    @IBOutlet weak var localEventView: UIView!
    @IBOutlet weak var keepConflictButton: UIButton!
    
    @IBOutlet weak var localEventSubjectLabel: UILabel!
    @IBOutlet weak var localEventStartLabel: UILabel!
    @IBOutlet weak var localEventEndLabel: UILabel!
    @IBOutlet weak var remoteEventSubjectLabel: UILabel!
    @IBOutlet weak var remoteEventStartLabel: UILabel!
    @IBOutlet weak var remoteEventEndLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        checkLocalCalendarPermission();
        loadRemoteEvents();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        errorLabel.isHidden = true;
        // allGoodLabel.isHidden = true;
        localEventView.isHidden = true;
        remoteEventView.isHidden = true;
        keepConflictButton.isHidden = true;
        
        showNextRetrievedEvent();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkLocalCalendarPermission() {
        let permission = EKEventStore.authorizationStatus(for: EKEntityType.event);
        
        switch(permission) {
        case EKAuthorizationStatus.notDetermined:
            requestAccessToCalendar()
        case EKAuthorizationStatus.authorized:
            NSLog("Got permission to read calendar")
//            loadEvents();
        case EKAuthorizationStatus.restricted, .denied:
            showErrorLabel(); // FIXME
        }
    }
    
    func requestAccessToCalendar() {
        localCalendar.requestAccess(to: .event, completion: {
            (accessGranted: Bool, error: Error?) in
            if accessGranted {
                self.loadRemoteEvents();
            }
            if let unwrappedError = error {
                self.showErrorLabel(); // FIXME
            }
        })
    }
    
    // FIXME
    func loadRemoteEvents() {
        
        outlookService.getUserEmail(callback: {
            email in
            if let unwrappedEmail = email {
                NSLog("Hello \(unwrappedEmail)");
                
                self.outlookService.getEvents() {
                    events in
                    if let unwrappedEvents = events {
                        let eventJSON = unwrappedEvents["value"].arrayValue;
                        
                        for event in eventJSON {
                            var eventStruct = Event(
                                subject: event["subject"].stringValue,
                                start: event["start"]["dateTime"].stringValue,
                                end: event["end"]["dateTime"].stringValue,
                                isAllDay: event["isAllDay"].boolValue,
                                location: event["location"].stringValue,
                                body: event["bodyPreview"].stringValue
                            );
                            self.outlookEventQueue.append(eventStruct);
                            NSLog(eventStruct.subject);
                            NSLog("\(self.outlookEventQueue.count) events now in Outlook event queue.");
                        }
                    }
                }
            }
        })
    }
    
    func getConflictingLocalEvents(event: Event) -> [EKEvent] {
        let startDS = String(event.start.prefix(19));
        let stopDS = String(event.end.prefix(19));
        NSLog("Trying to get a date for \(startDS) and \(stopDS)")
        let start = Formatter.stringToDate(date: startDS);
        let stop = Formatter.stringToDate(date: stopDS);
        return localCalendarService.loadEvents(start: start, stop: stop);
    }
    
    func showErrorLabel() {
        
    }
    
    func showNextLocalEvent() {
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
            
            keepConflictButton.isEnabled = true;
            keepConflictButton.isHidden = false;
            
            currentLocalEvent = nextLocalEvent;
            
        } else {
            
//            localEventSubjectLabel.text = "All done!";
            localEventView.isHidden = true;
            localEventStartLabel.isHidden = true;
            localEventEndLabel.isHidden = true;
            
            keepConflictButton.isEnabled = false;
            keepConflictButton.isHidden = true;
        }
    }
    
    func showNextRetrievedEvent() {
        if let nextOutlookEvent = self.outlookEventQueue.first {
            outlookEventQueue.removeFirst();
            
            remoteEventSubjectLabel.text = nextOutlookEvent.subject;
            remoteEventStartLabel.text = nextOutlookEvent.start;
            remoteEventEndLabel.text = nextOutlookEvent.end;
            
            remoteEventSubjectLabel.isHidden = false;
            remoteEventStartLabel.isHidden = false;
            remoteEventEndLabel.isHidden = false;
            remoteEventView.isHidden = false;
            
            localEventQueue = getConflictingLocalEvents(event: nextOutlookEvent);
            
            showNextLocalEvent();
            
            currentRemoteEvent = nextOutlookEvent;
            
        } else {
            
            remoteEventView.isHidden = false;
            remoteEventSubjectLabel.text = "No merge in progress.";
            remoteEventStartLabel.isHidden = true;
            remoteEventEndLabel.isHidden = true;
            
            localEventView.isHidden = true;
        }
        
        NSLog("remoteEventStartLabel.isHidden: \(remoteEventStartLabel.isHidden)")
    }
    
    @IBAction func remoteEventWasTapped() {
        var addEKEvent = EKEvent(eventStore: localCalendar);
        addEKEvent.title = currentRemoteEvent.subject;
        addEKEvent.notes = currentRemoteEvent.body;
        addEKEvent.startDate = Formatter.stringToDate(date: currentRemoteEvent.start);
        addEKEvent.endDate = Formatter.stringToDate(date: currentRemoteEvent.end);
        addEKEvent.isAllDay = currentRemoteEvent.isAllDay;
        addEKEvent.location = currentRemoteEvent.location;
        
        do {
            try localCalendar.save(addEKEvent, span: .thisEvent, commit: true);
            remoteEventSubjectLabel.text = "Event Saved";
        } catch {
            remoteEventSubjectLabel.text = "Couldn't save";
        }
        remoteEventStartLabel.isHidden = true;
        remoteEventEndLabel.isHidden = true;
        do {
            try localCalendar.remove(currentLocalEvent, span: .thisEvent);
        } catch {
            remoteEventSubjectLabel.text = "Couldn't remove conflicting";
        }
        
        showNextRetrievedEvent();
    }
    
    @IBAction func localEventWasTapped() {
        
        
    }
    
    @IBAction func keepConflictWasTapped() {
        
    }
}

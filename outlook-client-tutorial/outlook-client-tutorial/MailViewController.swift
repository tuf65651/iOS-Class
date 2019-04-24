//
//  FirstViewController.swift
//  outlook-client-tutorial
//
//  Created by Shmuel Jacobs on 4/17/19.
//  Copyright © 2019 IcebreakerIndustries. All rights reserved.
//

import UIKit

class MailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setLogInState(loggedIn: service.isLoggedIn);
        if (service.isLoggedIn) {
            loadUserData();
        }
    }
    
    let service = OutlookService.shared();
    
    func setLogInState(loggedIn: Bool) {
        if (loggedIn) {
            logInButton.setTitle("Log Out", for: .normal);
        } else {
            logInButton.setTitle("Log In", for: .normal)
        }
    }

    @IBOutlet var logInButton: UIButton!
    
    @IBAction func logInButtonTapped(sender: AnyObject) {
        if (service.isLoggedIn) {
            // Logout
            service.logout()
            setLogInState(loggedIn: false)
        } else {
            // Login
            service.login(from: self) {
                error in
                if let unwrappedError = error {
                    NSLog("Error logging in: \(unwrappedError)")
                } else {
                    NSLog("Successfully logged in.")
                    self.setLogInState(loggedIn: true)
                    self.loadUserData()
                }
            }
        }
    }
    
    
    func loadUserData() {
        service.getUserEmail() {
            email in
            if let unwrappedEmail = email {
                NSLog("Hello \(unwrappedEmail)");
                
                self.service.getInboxMessages() {
                    messages in
                    if let unwrappedMessages = messages {
                        for (message) in unwrappedMessages["value"].arrayValue {
                            NSLog(message["subject"].stringValue);
                        }
                    }
                }
            }
        }
    }
}


//
//  LoginViewController.swift
//  Synk
//
//  Created by Shmuel Jacobs on 5/1/19.
//  Copyright © 2019 Shmuel Jacobs. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var loginStateLabel: UILabel!
    
    // Outlook client object makes API calls and stores service state information
    let service = OutlookService.shared();
    
    @IBAction func loginButtonTapped() {
        if service.isLoggedIn {
            service.logout();
            displayAccountSelection();
        } else {
            service.login(from: self) { (error) in
                if let unwrappedError = error {
                    NSLog("Can't sign in: \(unwrappedError)");
                } else {
                    self.displayAccountSelection();
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        UIElementDetails();
        
        displayAccountSelection();
    }
    
    func UIElementDetails() {
        
    }
    
    func displayAccountSelection() {
        // Check for signed in user
        if !(service.isLoggedIn) {
            loginStateLabel.text = "Hit the Log In button to start";
            loginButton.setTitle("Log In", for: .normal);
            continueButton.isHidden = true;
            continueButton.isEnabled = false;
        } else {
            loginStateLabel.text = "Hit the Log Out button to switch users";
            loginButton.setTitle("Log Out", for: .normal);
            continueButton.isHidden = false;
            continueButton.isEnabled = true;
            service.getUserEmail() { email in
                if let unwrappedEmail = email {
                    self.continueButton.setTitle(String("Continue as \(unwrappedEmail)"), for: .normal);
                }
            }
        }
    }
    
    
}

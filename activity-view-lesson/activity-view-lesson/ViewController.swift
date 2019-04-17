//
//  ViewController.swift
//  activity-view-lesson
//
//  Created by Shmuel Jacobs on 4/17/19.
//  Copyright © 2019 IcebreakerIndustries. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        let shareText = "Share by my app";
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil);
        activityViewController.excludedActivityTypes = [.openInIBooks];
        self.present(activityViewController, animated: true, completion: nil);
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}


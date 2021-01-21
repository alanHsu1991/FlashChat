//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Alan Hsu on 2021/1/13.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!   // CLTypingLabel is the class from the Pod
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)    // Always a good practice when we override something
        navigationController?.isNavigationBarHidden = true
    }    // Navigation bar will be hidden when the view loads up
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)    // It gives the chance for the parent to run its own code first
        navigationController?.isNavigationBarHidden = false
    }    // Navigation bar will appear when the next screen loads up
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = K.appName
        
//        titleLabel.text = ""
//        var charIndex = 0    // Custom delay timer to make every letter run simultaneously
//        let titleText = "⚡️FlashChat"
//        for letter in titleText {    // For loop
////            print("-")
////            print(0.1 * Double(charIndex))
////            print(letter)
//            Timer.scheduledTimer(withTimeInterval: 0.1 * Double(charIndex), repeats: false) { (timer) in
//                self.titleLabel.text?.append(letter)    // Prints every letter in the titleText
//            }
//            charIndex += 1    // Add 1 everytime the timer runs
//
//            // Without the charIndex, the letter is going to be run at the same time interval, because we created a timer for each letter with the same interval. With the charIndex we can separate the run time of each letter.
//
//        }
       
    }
    

}

//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Alan Hsu on 2021/1/13.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            // "if let" unwrappes the optional string into a string
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                // This is provided from the Firebase docs under Authenticatoin -> Password Authentication
                
                if let e = error {
                    print(e.localizedDescription)
                    // Print the description (error) that is localized to the user's language on their phone.
                } else {
                    // Navigate to the ChatViewController
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
        }
    }
}

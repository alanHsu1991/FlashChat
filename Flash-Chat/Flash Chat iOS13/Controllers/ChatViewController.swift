//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Alan Hsu on 2021/1/13.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = [
//        Message(sender: "1@2.com", body: "Hey!"),
//        Message(sender: "a@b.com", body: "Hello!"),
//        Message(sender: "1@2.com", body: "What's Up?")
//        Don't need these anymore as it acts as dummy messages before we can retrieve live messages.
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        title = K.appName    // The text on the top center of the ChatViewController
        navigationItem.hidesBackButton = true    // Hides the back button
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)    // Registering the xib
        
        loadMessages()
    }
    
    func loadMessages() {
        
        // If I only want to get the data just once I would use .getDocuments
        // If I want to get the newwest data everytime I would use .addSnapshotListener
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { (querySnapshot, error) in
            
            self.messages = []    // Put this line here to only show the newest message to the tableView
            
            if let e = error {
                print("There was an issue retrieving data from Firestore. \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                
                                self.tableView.reloadData()
                                // This helps the message to show up on the tableView faster
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                // ["A", "B"], if we set to 2 it's going to be out of bounce, so we need to subtract 1
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                                // scroll the selected row to the top of the screen
                            }    // To ensure that the retrieving in the background will update to the foreground.
                        }
                    }
                }
            }
        }    // Retrieve messages from Firestore
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
//        let messageBody = messageTextfield.text
//        let messageSender = Auth.auth().currentUser?.email
        // Both constant are optional so we can use the "if let"
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.bodyField: messageBody,
                K.FStore.senderField: messageSender,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print("There was an error saving data. \(e)")
                } else {
                    print("Message saved successfully.")
                    
                    DispatchQueue.main.async {    // Ensure the process takes place on the main thread rather than at the background
                        self.messageTextfield.text = ""
                    }
                }
            }
        }    // Save messages to the Firestore.
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)    // Take the user to the root ViewController
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    // This delegate (UITableViewDataSource) is responsible for populating the tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }    // Create the number of cells that match the number of messages
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
            as! MessageCell
        cell.label.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email {    // This is a message from the current user
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        } else {    // This is a message from the other user
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
        
        return cell
    }    // Creates a cell for each messages, so it will run as many times as the number of the messages
}

//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Alan Hsu on 2021/1/13.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    
    override func awakeFromNib() {    // This is going to be called when a MessageCell is created
        super.awakeFromNib()
        
        messageBubble.layer.cornerRadius = messageBubble.frame.height / 5
        // This rounds the corner of the message bubble and adapts to the height of the message
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

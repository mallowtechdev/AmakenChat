//
//  ACUserCardTableViewCell.swift
//  AmakenChat
//
//  Created by Yogesh Murugesh on 17/11/16.
//  Copyright © 2016 Mallow Technologies Private Limited. All rights reserved.
//

import UIKit

class ACUserCardTableViewCell: ACTableViewCell {

    @IBOutlet weak var bubbleImageView: UIImageView!
    @IBOutlet weak var messageText: ACLabel!
    @IBOutlet weak var sentDate: ACLabel!
    
    var userCard: ACUserCardEntity?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
       
    }

    
    // MARK:- Custom methods
    
    func updateCell() {
        messageText.text = userCard?.messageTextBody
        messageText.textColor = UIColor(hexString: (userCard?.messageTextColor)!)
        messageText.textAlignment = ACHelper.parseTextAlignmentFromString(align: (userCard?.messageTextAlign)!)
        if userCard?.messageTextBody == "true" {
            messageText.font = UIFont.acBoldFontWithSize(size: 17.0)
        }
        sentDate.text = ACHelper.changeUserCardDateFormat(dateString: (userCard?.addedDate)!)
        sentDate.textColor = UIColor(hexString: (userCard?.addedDateColor)!)
    }

}

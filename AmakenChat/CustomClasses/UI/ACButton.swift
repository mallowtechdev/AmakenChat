//
//  ACButton.swift
//  AmakenChat
//
//  Created by Yogesh Murugesh on 15/11/16.
//  Copyright © 2016 Mallow Technologies Private Limited. All rights reserved.
//

import UIKit

class ACButton: UIButton {
    
    // MARK:- Initialization methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        customize()
        disableExclusiveTouch()
        disableKeyboard()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        customize()
        disableExclusiveTouch()
        disableKeyboard()
    }
    
    
    // MARK:- Custom methods
    
    func buttonPressed(sender: AnyObject) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kHideKeyboardOnButtonPress), object: nil)
    }
    
    func disableExclusiveTouch() {
        //this is to disable touching multiple buttons at the same.
        isExclusiveTouch = false
    }
    
    func disableKeyboard() {
        //this is to disable keyboard when touch.
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    func customize() {
        layer.cornerRadius = 22.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.acButtonBorderColor().cgColor
    }
    
}

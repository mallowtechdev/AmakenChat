//
//  ACViewController.swift
//  AmakenChat
//
//  Created by Yogesh Murugesh on 15/11/16.
//  Copyright © 2016 Mallow Technologies Private Limited. All rights reserved.
//

import UIKit

class ACViewController: MTHandleKeyBoardViewController {
    
    // MARK:- View life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting notification for hiding keyboard when button is pressed
        NotificationCenter.default.addObserver(self, selector:#selector(resignKeyboardOnButtonPress), name:NSNotification.Name(rawValue: kHideKeyboardOnButtonPress), object: nil)
    }
    
    
    // MARK:- Custom methods
    
    func resignKeyboardOnButtonPress() {
        if ((self.currentField) != nil) {
            self.currentField.resignFirstResponder()
        }
        self.view.endEditing(true)
    }

}

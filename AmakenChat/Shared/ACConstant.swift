//
//  ACConstant.swift
//  AmakenChat
//
//  Created by Yogesh Murugesh on 15/11/16.
//  Copyright © 2016 Mallow Technologies Private Limited. All rights reserved.
//

import Foundation

let kAppDelegate = UIApplication.shared.delegate as! AppDelegate

// Notification Names
let kHideKeyboardOnButtonPress = "HideKeyboardOnButtonPress"
let kEnterForegroundNotification = "ForegroundEntered"

// Storyboard names
let kAmakenChatStoryboard = "AmakenChatStoryboard"


// Enum
enum CardType: Int {
    case WelcomeCard = 1
    case InstructionCard = 2
    case ContentCard = 3
    case MessageCard = 4
    case BannerCard = 5
    case PromotionCard = 6
    case ServerResponseCard = 7
    case UserCard = 8
    case HelpCard = 9
}

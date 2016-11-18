//
//  ACHelper.swift
//  AmakenChat
//
//  Created by Arasuvel Theerthapathy on 17/11/16.
//  Copyright © 2016 Mallow Technologies Private Limited. All rights reserved.
//

import Foundation


class ACHelper {
    
    class func parseTextAlignmentFromString(align: String = "center") -> NSTextAlignment {
        
        switch align.lowercased() {
        case "center":
            return .center
            
        case "left":
            return .left
            
        case "right":
            return .right
            
        default:
            return .left
        }
        
    }
    
    class func changeWelcomeCardDateFormat(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"//7/21/2016 10:02:36 AM
        let formattedDate = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "dd MMM, yy hh:mm a"
        let displayDateString = dateFormatter.string(from: formattedDate!)

        return displayDateString
    }
    
    class func changePromotionCardDateFormat(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm:ss a"
        let formattedDate = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "dd MMM, yy hh:mm a"
        let displayDateString = dateFormatter.string(from: formattedDate!)
        
        return displayDateString
    }
    
    class func changeUserCardDateFormat(dateString: String) -> String {
        return self.changeWelcomeCardDateFormat(dateString: dateString)
    }
}

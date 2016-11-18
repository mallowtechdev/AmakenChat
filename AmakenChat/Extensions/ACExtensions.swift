//
//  ACExtensions.swift
//  AmakenChat
//
//  Created by Yogesh Murugesh on 15/11/16.
//  Copyright © 2016 Mallow Technologies Private Limited. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    class func acBoldFontWithSize(size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }
    
    class func acSmallFont() -> UIFont {
        return UIFont.systemFont(ofSize: 13.0)
    }
    
}

extension UIColor {
    
    convenience init(hexString: String, alpha: Double = 1.0) {
        let hex = hexString.trimmingCharacters(in: NSCharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let red, green, blue: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (red, green, blue) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (red, green, blue) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (red, green, blue) = (1, 1, 0)
        }
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: CGFloat(255 * alpha) / 255)
    }
    
    class func acButtonBorderColor() -> UIColor {
        return UIColor(red: 0.37, green: 0.70, blue: 0.53, alpha: 1.0)
    }
    
    class func acWhiteColor() -> UIColor {
        return UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
    }
    
    class func acThemeColor() -> UIColor {
        return UIColor(red: 0.07, green: 0.51, blue: 0.67, alpha: 1)
    }
    
    class func acLightGrayColor() -> UIColor {
        return UIColor(red: 0.87, green: 0.94, blue: 0.96, alpha: 1)
    }

}

extension String {
    
    func base64Decoded() -> [[String : AnyObject]]? {
        let decodedData = NSData(base64Encoded: self, options: .init(rawValue: 0))
        do {
            let json = try JSONSerialization.jsonObject(with: decodedData as! Data, options: .mutableContainers) as! [[String : AnyObject]]
            print(json[0]["WelcomeCard"]?["ChannelName"])
            return json
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }
    
}

//
//  ACNetworkRequest.swift
//  AmakenChat
//
//  Created by Yogesh Murugesh on 16/11/16.
//  Copyright © 2016 Mallow Technologies Private Limited. All rights reserved.
//

import UIKit

class ACNetworkRequest: NSObject {

    static let sharedInstance = ACNetworkRequest()
    
    func soapRequest(value: @escaping ([[String : AnyObject]]?, NSError?) -> Void) {
        let soap = SOAPEngine()
        soap.userAgent = "SOAPEngine"
        soap.actionNamespaceSlash = true
        soap.responseHeader = true // use only for non standard MS-SOAP service
        soap.setIntegerValue(0, forKey: "LastRecordId")
        soap.setIntegerValue(20, forKey: "TotalRecords")
        soap.requestURL("http://demo.fana.sa/testservice.asmx", soapAction: "http://tempuri.org/GetTvChatCards",
                        completeWithDictionary: { (statusCode : Int,
                            dict : [AnyHashable : Any]?) -> Void in
                            var result:Dictionary = dict! as Dictionary
                            let body = result["Body"] as! [String : AnyObject]
                            let tvChatCardsResponse = body["GetTvChatCardsResponse"] as! [String : AnyObject]
                            let tvChatCardsResult = tvChatCardsResponse["GetTvChatCardsResult"] as! String
                            let json = tvChatCardsResult.base64Decoded()
                            value(json, nil)
        }) { (error : Error?) -> Void in
            value(nil, error as NSError?)
            print(error)
        }
    }

}

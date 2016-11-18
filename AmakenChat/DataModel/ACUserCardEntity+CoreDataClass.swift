//
//  ACUserCardEntity+CoreDataClass.swift
//  
//
//  Created by Yogesh Murugesh on 17/11/16.
//
//

import Foundation
import CoreData


public class ACUserCardEntity: NSManagedObject {

    static let sharedInstance = ACUserCardEntity()
    
    func createUserCard(managedContext: NSManagedObjectContext, element: [String : AnyObject]) ->  NSManagedObject {
        let userCardEntity = NSEntityDescription.entity(forEntityName: "ACUserCardEntity", in: managedContext)
        let userCard = NSManagedObject(entity: userCardEntity!, insertInto: managedContext)
        let userCardJson = element["UserCard"] as! [String : AnyObject]
        userCard.setValue(userCardJson["MessageTextBody"], forKey: "messageTextBody")
        userCard.setValue(userCardJson["MessageTextColor"], forKey: "messageTextColor")
        userCard.setValue(userCardJson["MessageTextAlign"], forKey: "messageTextAlign")
        userCard.setValue(userCardJson["MessageTextBold"], forKey: "messageTextBold")
        userCard.setValue(userCardJson["AddedDate"], forKey: "addedDate")
        userCard.setValue(userCardJson["AddedDateColor"], forKey: "addedDateColor")
        
        return userCard
    }
    
    func updateUserCard(managedContext: NSManagedObjectContext, element: [String : AnyObject], oldCard: ACUserCardEntity) {
        oldCard.messageTextBody = element["MessageTextBody"] as! String?
        oldCard.messageTextColor = element["MessageTextColor"] as! String?
        oldCard.messageTextAlign = element["MessageTextAlign"] as! String?
        oldCard.messageTextBold = element["MessageTextBold"] as! Bool
        oldCard.addedDate = element["AddedDate"] as! String?
        oldCard.addedDateColor = element["AddedDateColor"] as! String?
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }

}

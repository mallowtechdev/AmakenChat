//
//  ACCardEntity+CoreDataClass.swift
//  
//
//  Created by Yogesh Murugesh on 16/11/16.
//
//

import Foundation
import CoreData


public class ACCardEntity: NSManagedObject {

    static let sharedInstance = ACCardEntity()
    
    func createCard(managedContext: NSManagedObjectContext, element: [String : AnyObject]) ->  NSManagedObject {
        let cardEntity = NSEntityDescription.entity(forEntityName: "ACCardEntity", in: managedContext)
        let card = NSManagedObject(entity: cardEntity!, insertInto: managedContext)
        card.setValue(element["CardTypeId"], forKey: "cardTypeId")
        card.setValue(element["Id"], forKey: "id")
        return  card
    }
    
    func updateCard(managedContext: NSManagedObjectContext, element: [String : AnyObject], oldCard: ACCardEntity) {
        oldCard.id = element["Id"] as! Int
        oldCard.cardTypeId = element["CardTypeId"] as! Int
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }

}

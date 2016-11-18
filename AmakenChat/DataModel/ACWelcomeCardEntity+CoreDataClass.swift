//
//  ACWelcomeCardEntity+CoreDataClass.swift
//  
//
//  Created by Yogesh Murugesh on 16/11/16.
//
//

import Foundation
import CoreData


public class ACWelcomeCardEntity: NSManagedObject {

    static let sharedInstance = ACWelcomeCardEntity()
    
    func createWelcomeCard(managedContext: NSManagedObjectContext, element: [String : AnyObject]) ->  NSManagedObject {
        let welcomeCardEntity = NSEntityDescription.entity(forEntityName: "ACWelcomeCardEntity", in: managedContext)
        let welcomeCard = NSManagedObject(entity: welcomeCardEntity!, insertInto: managedContext)
        let welcomeCardJson = element["WelcomeCard"] as! [String : AnyObject]
        self.assignDetails(element: welcomeCardJson, card: welcomeCard as! ACWelcomeCardEntity)        
        let contents = ACContentEntity.sharedInstance.createContent(managedContext: managedContext, element: welcomeCardJson)
        welcomeCard.setValue(contents, forKey: "contents")
        
        return welcomeCard
    }
    
    func updateWelcomeCard(managedContext: NSManagedObjectContext, element: [String : AnyObject], card: ACWelcomeCardEntity) {
        self.assignDetails(element: element, card: card)
        ACContentEntity.sharedInstance.updateContent(managedContext: managedContext, element: element["Contents"] as! [[String : AnyObject]], oldContents: card.contents!)
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }

    func assignDetails(element: [String : AnyObject], card: ACWelcomeCardEntity) {
        card.serviceTypeId = element["ServiceTypeId"] as! Int
        card.serviceTypeCategoryId = element["ServiceTypeCategoryId"] as! Int
        card.cardLogo = element["CardLogo"] as! String?
        card.sharingText = element["SharingText"] as! String?
        card.channelName = element["ChannelName"] as! String?
        card.channelNameColor = element["ChannelNameColor"] as! String?
        card.channelNameAlign = element["ChannelNameAlign"] as! String?
        card.channelNo = element["ChannelNo"] as! String?
        card.channelNoColor = element["ChannelNoColor"] as! String?
        card.channelNoAlign = element["ChannelNoAlign"] as! String?
        card.addedDate = element["AddedDate"] as! String?
        card.addedDateColor = element["AddedDateColor"] as! String?
        card.headText = element["HeadText"] as! String?
        card.headTextColor = element["HeadTextColor"] as! String?
        card.headTextAlign = element["HeadTextAlign"] as! String?
        card.headTextBold = element["HeadTextBold"]  as! Bool
        card.bodyText = element["BodyText"] as! String?
        card.bodyTextColor = element["BodyTextColor"] as! String?
        card.bodyTextAlign = element["BodyTextAlign"] as! String?
        card.bodyTextBold = element["BodyTextBold"]  as! Bool
        card.serviceNo = element["ServiceNo"] as! Int
        card.serviceShortCodeNo = element["ServiceShortCodeNo"] as! Int
        card.shortCode = element["ShortCode"] as! String?
        card.showFooter = element["ShowFooter"] as! Bool
        card.showHelpIcon = element["ShowHelpIcon"] as! Bool
        card.footerHelpCommand = element["FooterHelpCommand"] as! String?
    }
}

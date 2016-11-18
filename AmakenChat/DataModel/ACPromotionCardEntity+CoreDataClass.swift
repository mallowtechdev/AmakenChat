//
//  ACPromotionCardEntity+CoreDataClass.swift
//  
//
//  Created by Yogesh Murugesh on 16/11/16.
//
//

import Foundation
import CoreData


public class ACPromotionCardEntity: NSManagedObject {
    
    static let sharedInstance = ACPromotionCardEntity()
    
    func createPrmotionCard(managedContext: NSManagedObjectContext, element: [String : AnyObject]) ->  NSManagedObject {
        let promotionCardEntity = NSEntityDescription.entity(forEntityName: "ACPromotionCardEntity", in: managedContext)
        let promotionCard = NSManagedObject(entity: promotionCardEntity!, insertInto: managedContext)
        let promotionCardJson = element["PromotionCard"] as! [String : AnyObject]
        self.assignDetails(element: promotionCardJson, card: promotionCard as! ACPromotionCardEntity)
        
        let contents = ACContentEntity.sharedInstance.createContent(managedContext: managedContext, element: promotionCardJson)
        promotionCard.setValue(contents, forKey: "contents")
        
        return promotionCard
    }
    
    func updatePromotionCard(managedContext: NSManagedObjectContext, element: [String : AnyObject], card: ACPromotionCardEntity) {
        self.assignDetails(element: element, card: card)
        ACContentEntity.sharedInstance.updateContent(managedContext: managedContext, element: element["Contents"] as! [[String : AnyObject]], oldContents: card.contents!)
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }

    func assignDetails(element: [String : AnyObject], card: ACPromotionCardEntity) {
        card.serviceTypeID = element["ServiceTypeID"] as! Int
        card.serviceTypeCategoryID = element["ServiceTypeCategoryID"] as! Int
        card.cardLogo = element["CardLogo"] as! String?
        card.channelName = element["ChannelName"] as! String?
        card.channelNameColor = element["ChannelNameColor"] as! String?
        card.channelNameAlign = element["ChannelNameAlign"] as! String?
        card.channelNo = element["ChannelNo"] as! Int
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
        card.commentsCount = element["CommentsCount"] as! String?
        card.likeCount = element["LikeCount"] as! String?
        card.viewersCount = element["ViewersCount"] as! String?
        card.canComment = element["CanComment"] as! Bool
        card.canLike = element["CanLike"] as! Bool
        card.canView = element["CanView"] as! Bool
        card.showComments = element["ShowComments"] as! Bool
        card.showLikes = element["ShowLikes"] as! Bool
        card.showViews = element["ShowViews"] as! Bool
        card.showMore = element["ShowMore"] as! Bool
        card.moreText = element["MoreText"] as! String?
        card.moreColor = element["MoreColor"] as! String?
        card.actionType = element["ActionType"] as! Int
        card.showAction = element["ShowAction"] as! Bool
        card.actionText = element["ActionText"] as! String?
        card.actionColor = element["ActionColor"] as! String?
        card.promotionId = element["PromotionId"] as! Int
        card.otherId = element["OtherId"] as! Int
        card.showFooter = element["ShowFooter"] as! Bool
        card.showHelpIcon = element["ShowHelpIcon"] as! Bool
        card.footerHelpCommand = element["FooterHelpCommand"] as! String?
    }
}

//
//  ACPromotionCardEntity+CoreDataProperties.swift
//  
//
//  Created by Yogesh Murugesh on 16/11/16.
//
//

import Foundation
import CoreData

extension ACPromotionCardEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ACPromotionCardEntity> {
        return NSFetchRequest<ACPromotionCardEntity>(entityName: "ACPromotionCardEntity");
    }

    @NSManaged public var serviceTypeID: Int
    @NSManaged public var serviceTypeCategoryID: Int
    @NSManaged public var cardLogo: String?
    @NSManaged public var channelName: String?
    @NSManaged public var channelNameColor: String?
    @NSManaged public var channelNameAlign: String?
    @NSManaged public var channelNo: Int
    @NSManaged public var channelNoColor: String?
    @NSManaged public var channelNoAlign: String?
    @NSManaged public var addedDate: String?
    @NSManaged public var addedDateColor: String?
    @NSManaged public var headText: String?
    @NSManaged public var headTextColor: String?
    @NSManaged public var headTextAlign: String?
    @NSManaged public var headTextBold: Bool
    @NSManaged public var bodyText: String?
    @NSManaged public var bodyTextColor: String?
    @NSManaged public var bodyTextAlign: String?
    @NSManaged public var bodyTextBold: Bool
    @NSManaged public var commentsCount: String?
    @NSManaged public var likeCount: String?
    @NSManaged public var viewersCount: String?
    @NSManaged public var canComment: Bool
    @NSManaged public var canLike: Bool
    @NSManaged public var canView: Bool
    @NSManaged public var showComments: Bool
    @NSManaged public var showLikes: Bool
    @NSManaged public var showViews: Bool
    @NSManaged public var showMore: Bool
    @NSManaged public var moreText: String?
    @NSManaged public var moreColor: String?
    @NSManaged public var actionType: Int
    @NSManaged public var showAction: Bool
    @NSManaged public var actionText: String?
    @NSManaged public var actionColor: String?
    @NSManaged public var promotionId: Int
    @NSManaged public var otherId: Int
    @NSManaged public var showFooter: Bool
    @NSManaged public var showHelpIcon: Bool
    @NSManaged public var footerHelpCommand: String?
    @NSManaged public var contents: NSSet?

}

// MARK: Generated accessors for contents
extension ACPromotionCardEntity {

    @objc(addContentsObject:)
    @NSManaged public func addToContents(_ value: ACContentEntity)

    @objc(removeContentsObject:)
    @NSManaged public func removeFromContents(_ value: ACContentEntity)

    @objc(addContents:)
    @NSManaged public func addToContents(_ values: NSSet)

    @objc(removeContents:)
    @NSManaged public func removeFromContents(_ values: NSSet)

}

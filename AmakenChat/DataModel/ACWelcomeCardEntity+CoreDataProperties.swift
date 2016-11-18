//
//  ACWelcomeCardEntity+CoreDataProperties.swift
//  
//
//  Created by Yogesh Murugesh on 16/11/16.
//
//

import Foundation
import CoreData 

extension ACWelcomeCardEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ACWelcomeCardEntity> {
        return NSFetchRequest<ACWelcomeCardEntity>(entityName: "ACWelcomeCardEntity");
    }

    @NSManaged public var serviceTypeId: Int
    @NSManaged public var serviceTypeCategoryId: Int
    @NSManaged public var cardLogo: String?
    @NSManaged public var sharingText: String?
    @NSManaged public var channelName: String?
    @NSManaged public var channelNameColor: String?
    @NSManaged public var channelNameAlign: String?
    @NSManaged public var channelNo: String?
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
    @NSManaged public var serviceNo: Int
    @NSManaged public var serviceShortCodeNo: Int
    @NSManaged public var shortCode: String?
    @NSManaged public var showFooter: Bool
    @NSManaged public var showHelpIcon: Bool
    @NSManaged public var footerHelpCommand: String?
    @NSManaged public var contents: NSSet?

}

// MARK: Generated accessors for contents
extension ACWelcomeCardEntity {

    @objc(addContentsObject:)
    @NSManaged public func addToContents(_ value: ACContentEntity)

    @objc(removeContentsObject:)
    @NSManaged public func removeFromContents(_ value: ACContentEntity)

    @objc(addContents:)
    @NSManaged public func addToContents(_ values: NSSet)

    @objc(removeContents:)
    @NSManaged public func removeFromContents(_ values: NSSet)

}

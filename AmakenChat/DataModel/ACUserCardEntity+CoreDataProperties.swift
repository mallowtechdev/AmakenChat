//
//  ACUserCardEntity+CoreDataProperties.swift
//  
//
//  Created by Yogesh Murugesh on 17/11/16.
//
//

import Foundation
import CoreData


extension ACUserCardEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ACUserCardEntity> {
        return NSFetchRequest<ACUserCardEntity>(entityName: "ACUserCardEntity");
    }

    @NSManaged public var messageTextBody: String?
    @NSManaged public var messageTextColor: String?
    @NSManaged public var messageTextAlign: String?
    @NSManaged public var messageTextBold: Bool
    @NSManaged public var addedDate: String?
    @NSManaged public var addedDateColor: String?

}

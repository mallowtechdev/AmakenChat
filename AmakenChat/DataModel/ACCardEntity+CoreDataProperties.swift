//
//  ACCardEntity+CoreDataProperties.swift
//  
//
//  Created by Yogesh Murugesh on 16/11/16.
//
//

import Foundation
import CoreData 

extension ACCardEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ACCardEntity> {
        return NSFetchRequest<ACCardEntity>(entityName: "ACCardEntity");
    }

    @NSManaged public var cardTypeId: Int
    @NSManaged public var id: Int
    @NSManaged public var welcomeCard: ACWelcomeCardEntity?
    @NSManaged public var promotionCard: ACPromotionCardEntity?
    @NSManaged public var userCard: ACUserCardEntity?

}

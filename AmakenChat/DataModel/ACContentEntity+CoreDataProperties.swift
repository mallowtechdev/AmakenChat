//
//  ACContentEntity+CoreDataProperties.swift
//  
//
//  Created by Yogesh Murugesh on 16/11/16.
//
//

import Foundation
import CoreData


extension ACContentEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ACContentEntity> {
        return NSFetchRequest<ACContentEntity>(entityName: "ACContentEntity");
    }

    @NSManaged public var fileType: Int
    @NSManaged public var fileUrl: String?
    @NSManaged public var fileHeight: Int
    @NSManaged public var fileWidth: Int
    @NSManaged public var thumbnail: String?
    @NSManaged public var thumbnailHeight: Int
    @NSManaged public var thumbnailWidth: Int

}

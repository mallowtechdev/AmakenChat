//
//  ACContentEntity+CoreDataClass.swift
//  
//
//  Created by Yogesh Murugesh on 16/11/16.
//
//

import Foundation
import CoreData


public class ACContentEntity: NSManagedObject {

    static let sharedInstance = ACContentEntity()
    
    func createContent(managedContext: NSManagedObjectContext, element: [String : AnyObject]) ->  NSSet {
        let contentEntity = NSEntityDescription.entity(forEntityName: "ACContentEntity", in: managedContext)
        let contentsJson = element["Contents"] as! [[String : AnyObject]]
        var contentArray: [NSManagedObject] = []
        for content in contentsJson {
            let contents = NSManagedObject(entity: contentEntity!, insertInto: managedContext)
            contents.setValue(content["FileType"], forKey: "fileType")
            contents.setValue(content["FileUrl"], forKey: "fileUrl")
            contents.setValue(content["File_Height"], forKey: "fileHeight")
            contents.setValue(content["File_Width"], forKey: "fileWidth")
            contents.setValue(content["Thumbnail"], forKey: "thumbnail")
            contents.setValue(content["Thumbnail_Height"], forKey: "thumbnailHeight")
            contents.setValue(content["Thumbnail_Width"], forKey: "thumbnailWidth")
            contentArray.append(contents)
        }
        return NSSet(array: contentArray)
    }
    
    func updateContent(managedContext: NSManagedObjectContext, element: [[String : AnyObject]], oldContents: NSSet) {
        print(element)
        var couter = 0
        for eachContent in oldContents {
            let eachContent = eachContent as! ACContentEntity
            eachContent.fileType = element[couter]["FileType"] as! Int
            eachContent.fileUrl = element[couter]["FileUrl"] as! String?
            eachContent.fileHeight = element[couter]["File_Height"] as! Int
            eachContent.fileWidth = element[couter]["File_Width"] as! Int
            eachContent.thumbnail = element[couter]["Thumbnail"] as! String?
            eachContent.thumbnailHeight = element[couter]["Thumbnail_Height"] as! Int
            eachContent.thumbnailWidth = element[couter]["Thumbnail_Width"] as! Int
            print(eachContent.fileType)
            couter = couter + 1
        }
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }

}

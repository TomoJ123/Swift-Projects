//
//  Commit+CoreDataProperties.swift
//  Project38
//
//  Created by Tomislav Jurić-Arambašić on 05/12/2020.
//
//

import Foundation
import CoreData


extension Commit {

    @nonobjc public class func createfetchRequest() -> NSFetchRequest<Commit> {
        return NSFetchRequest<Commit>(entityName: "Commit")
    }

    @NSManaged public var date: Date
    @NSManaged public var message: String
    @NSManaged public var sha: String
    @NSManaged public var url: String
    @NSManaged public var author: Author

}

extension Commit : Identifiable {

}

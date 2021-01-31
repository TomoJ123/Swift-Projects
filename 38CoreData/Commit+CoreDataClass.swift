//
//  Commit+CoreDataClass.swift
//  Project38
//
//  Created by Tomislav Jurić-Arambašić on 04/12/2020.
//
//

import Foundation
import CoreData

@objc(Commit)
public class Commit: NSManagedObject {
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
            super.init(entity: entity, insertInto: context)
            print("Init called!")
        }
}

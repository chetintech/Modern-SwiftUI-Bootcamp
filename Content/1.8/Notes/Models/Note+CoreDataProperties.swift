//
//  Note+CoreDataProperties.swift
//  Notes
//
//  Created by Mehmet Emin Cetin on 22.09.2025.
//
//

public import Foundation
public import CoreData


public typealias NoteCoreDataPropertiesSet = NSSet

extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var date: Date?

}

extension Note : Identifiable {

}

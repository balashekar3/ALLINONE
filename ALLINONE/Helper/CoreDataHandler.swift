//
//  CoreDataHandler.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 08/03/23.
//

import Foundation
import CoreData
import UIKit
class CoreDataHandler {
    private var viewContext: NSManagedObjectContext!
    
    static let shared = CoreDataHandler()
    
    init() {
        viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
    }
    
    func add<T: NSManagedObject>(_ type: T.Type) -> T? {
        guard let entityName = T.entity().name else {return nil}
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: viewContext) else {return nil}
        let object = T(entity: entity, insertInto: viewContext)
        return object
    }
    
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetch<T: NSManagedObject>(_ type: T.Type) -> [T] {
        let request = T.fetchRequest()
        do {
            let result = try viewContext.fetch(request)
            return result as! [T]
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func delete<T: NSManagedObject>(object: T) {
        viewContext.delete(object)
        save()
    }
}

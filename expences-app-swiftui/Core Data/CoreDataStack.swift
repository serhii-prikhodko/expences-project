//
//  CoreDataStack.swift
//  JournalCoreDataSwiftUI
//
//  Created by Nelson Gonzalez on 12/10/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation
import CoreData


class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    lazy var container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
}


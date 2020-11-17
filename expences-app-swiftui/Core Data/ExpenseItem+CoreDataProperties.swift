//
//  ExpenseItem+CoreDataProperties.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 16.11.2020.
//
//

import Foundation
import CoreData


extension ExpenseItem {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpenseItem> {
        return NSFetchRequest<ExpenseItem>(entityName: "ExpenseItem")
    }
    
    @NSManaged public var amount: Double
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var dailyExpenses: DailyExpensesItem?
    
    convenience init(name: String, id: UUID = UUID(), amount: Double, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.id = id
        self.name = name
        self.amount = amount
    }
    
    public var wrappedName: String {
        name ?? "Unknown expense"
    }
}

extension ExpenseItem : Identifiable {
    
}

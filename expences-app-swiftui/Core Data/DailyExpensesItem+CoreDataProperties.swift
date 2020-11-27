//
//  DailyExpensesItem+CoreDataProperties.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 16.11.2020.
//
//

import Foundation
import CoreData


extension DailyExpensesItem {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyExpensesItem> {
        return NSFetchRequest<DailyExpensesItem>(entityName: "DailyExpensesItem")
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var date: Date
    @NSManaged public var expenses: NSSet?
    @NSManaged public var expensesByPerson: ExpensesByPersonItem?
    
    public var expensesArray: [ExpenseItem] {
        let set = expenses as? Set<ExpenseItem> ?? []
        
        return set.sorted {
            $0.date < $1.date
        }
    }
    convenience init(id: UUID, date: Date, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = id
        self.date = date
    }
}

// MARK: Generated accessors for expenses
extension DailyExpensesItem {
    
    @objc(addExpensesObject:)
    @NSManaged public func addToExpenses(_ value: ExpenseItem)
    
    @objc(removeExpensesObject:)
    @NSManaged public func removeFromExpenses(_ value: ExpenseItem)
    
    @objc(addExpenses:)
    @NSManaged public func addToExpenses(_ values: NSSet)
    
    @objc(removeExpenses:)
    @NSManaged public func removeFromExpenses(_ values: NSSet)
}

extension DailyExpensesItem : Identifiable {
    
}

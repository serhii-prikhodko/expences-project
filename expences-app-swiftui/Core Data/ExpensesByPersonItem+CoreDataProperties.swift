//
//  ExpensesByPersonItem+CoreDataProperties.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 16.11.2020.
//
//

import Foundation
import CoreData


extension ExpensesByPersonItem {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpensesByPersonItem> {
        return NSFetchRequest<ExpensesByPersonItem>(entityName: "ExpensesByPersonItem")
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var weeklyExpenses: NSSet?
    
    public var wrappedName: String {
        name ?? "Unknown person"
    }
    
    public var weeklyExpensesArray: [DailyExpensesItem] {
        let set = weeklyExpenses as? Set<DailyExpensesItem> ?? []
        
        return set.sorted {
            $0.date < $1.date
        }
    }
}

// MARK: Generated accessors for weeklyExpenses
extension ExpensesByPersonItem {
    
    @objc(addWeeklyExpensesObject:)
    @NSManaged public func addToWeeklyExpenses(_ value: DailyExpensesItem)
    
    @objc(removeWeeklyExpensesObject:)
    @NSManaged public func removeFromWeeklyExpenses(_ value: DailyExpensesItem)
    
    @objc(addWeeklyExpenses:)
    @NSManaged public func addToWeeklyExpenses(_ values: NSSet)
    
    @objc(removeWeeklyExpenses:)
    @NSManaged public func removeFromWeeklyExpenses(_ values: NSSet)
    
    func getDailyExpensesByIndex(index: Int) -> DailyExpensesItem {
        
        return weeklyExpensesArray[index]
    }
    
}

extension ExpensesByPersonItem : Identifiable {
    
}

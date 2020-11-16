//
//  EspensesStore.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 19.10.2020.
//

import Foundation
import CoreData

class ExpensesStore: NSObject, ObservableObject {
    
    @Published var expenses: [ExpensesByPersonItem] = []
    
    private let expensesController: NSFetchedResultsController<ExpensesByPersonItem>
    
    init(managedObjectContext: NSManagedObjectContext) {
        expensesController = NSFetchedResultsController(fetchRequest: ExpensesByPersonItem.expensesFetchRequest,
                                                        managedObjectContext: managedObjectContext,
                                                        sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        
        expensesController.delegate = self
        
        do {
            try expensesController.performFetch()
            expenses = expensesController.fetchedObjects ?? []
        } catch {
            print("failed to fetch items!")
        }
    }
    
    func addExpense(personIndex: Int, dayIndex: Int, name: String, amount: Double) {
        let expense = ExpenseItem(context: expensesController.managedObjectContext)
        expense.name = name
        expense.amount = amount
        expenses[personIndex].weeklyExpenses?[dayIndex].dailyExpenses?.append(expense)
        
        saveContext()
    }
    
    func updateExpense(personIndex: Int, dayIndex: Int, positionIndex: Int, name: String, amount: Double) {
        let expense = ExpenseItem(context: expensesController.managedObjectContext)
        expense.name = name
        expense.amount = amount
        expenses[personIndex].weeklyExpenses?[dayIndex].dailyExpenses?[positionIndex] = expense
        
        saveContext()
    }
    
    func deleteExpense(personIndex: Int, dayIndex: Int, at offsets: IndexSet) {
        
        for index in offsets {
            guard let expense = expenses[personIndex].weeklyExpenses?[dayIndex].dailyExpenses?[index] else { return }
            expensesController.managedObjectContext.delete(expense)
        }
        
        saveContext()
    }
    
    func addPerson(name: String) {
        let person = ExpensesByPersonItem(context: expensesController.managedObjectContext)
        person.name = name
        
        let dayOne = DailyExpensesItem(context: expensesController.managedObjectContext)
        dayOne.expenses = []
        
        person.weeklyExpenses = NSSet(array: [dayOne])
        
        saveContext()
    }
    
    func deletePerson(at offsets: IndexSet) {
        for index in offsets {
            let person = expenses[index]
            expensesController.managedObjectContext.delete(person)
        }
        
        saveContext()
    }
    
    func updatePersonName(name: String, personIndex: Int) {
        expenses[personIndex].name = name
        
        saveContext()
    }
    
    private func saveContext() {
        do {
            try expensesController.managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
}

extension ExpensesByPersonItem {
    static var expensesFetchRequest: NSFetchRequest<ExpensesByPersonItem> {
        let request: NSFetchRequest<ExpensesByPersonItem> = ExpensesByPersonItem.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        return request
    }
}

extension ExpensesStore: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let expenses = controller.fetchedObjects as? [ExpensesByPersonItem]
        else { return }
        
        self.expenses = expenses
    }
}

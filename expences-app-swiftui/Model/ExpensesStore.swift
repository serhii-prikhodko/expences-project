//
//  EspensesStore.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 19.10.2020.
//
import Foundation
import CoreData

class ExpensesStore: ObservableObject {
    
    // MARK: - Properties
    
    @Published var expenses: [ExpensesByPersonItem] = []
    
    init() {
        getExpenses()
    }
    
     
    func saveContext() {
        let mainContext = CoreDataStack.shared.mainContext
        do {
            try mainContext.save()
            getExpenses()
         
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
    
    func getExpenses() {
        let fetchRequest: NSFetchRequest<ExpensesByPersonItem> = ExpensesByPersonItem.fetchRequest()
        let mainContext = CoreDataStack.shared.mainContext
        
        do {
            expenses = try mainContext.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching expenses: \(error)")
        }
    }
    
    // MARK: CRUD methods for expense
    
    func addExpense(name: String, amount: Double, personIndex: Int, index: Int) {
        let expense = ExpenseItem(name: name, amount: amount)
        
        expenses[personIndex].getDailyExpensesByIndex(index: index).addToExpenses(expense)
        
        saveContext()
    }
    
    func updateExpense(expense: ExpenseItem, name: String, amount: Double) {
        expense.name = name
        expense.amount = amount
        
        saveContext()
    }
    
    func deleteExpense(personIndex: Int, dayIndex: Int, at offsets: IndexSet) {
        let mainContext = CoreDataStack.shared.mainContext
        
        for index in offsets {
            let expense = expenses[personIndex].getDailyExpensesByIndex(index: dayIndex).expensesArray[index]
            mainContext.delete(expense)
        }
        
        saveContext()
    }
    
    // MARK: CRUD methods for person
    
    func addPerson(name: String) {
        let mainContext = CoreDataStack.shared.mainContext
        let person = ExpensesByPersonItem(context: mainContext)
        person.name = name
        
        let dayOne = DailyExpensesItem(id: UUID(), date: Date(), context: mainContext)
        let dayTwo = DailyExpensesItem(id: UUID(), date: Date(), context: mainContext)
        let dayThree = DailyExpensesItem(id: UUID(), date: Date(), context: mainContext)
        
        person.addToWeeklyExpenses(dayOne)
        person.addToWeeklyExpenses(dayTwo)
        person.addToWeeklyExpenses(dayThree)
        
        saveContext()
    }
    
    func deletePerson(at offsets: IndexSet) {
        let mainContext = CoreDataStack.shared.mainContext
        
        for index in offsets {
            let person = expenses[index]
            mainContext.delete(person)
        }
        
        saveContext()
    }
    
    func updatePersonName(name: String, personIndex: Int) {
        expenses[personIndex].name = name
        
        saveContext()
    }
}

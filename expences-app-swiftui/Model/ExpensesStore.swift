//
//  EspensesStore.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 19.10.2020.
//
import Foundation
import CoreData

class ExpensesStore: ObservableObject {
    
    @Published var expenses: [ExpensesByPersonItem] = []
    
    init() {
        getExpenses()
    }
    
     
    func saveContext() {
        let moc = CoreDataStack.shared.mainContext
        do {
            try moc.save()
            getExpenses()
         
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
    
    func getExpenses() {
        let fetchRequest: NSFetchRequest<ExpensesByPersonItem> = ExpensesByPersonItem.fetchRequest()
        let moc = CoreDataStack.shared.mainContext
        
        do {
            expenses = try moc.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching expenses: \(error)")
        }
    }
    
    
    func addExpense(name: String, amount: Double, personIndex: Int, index: Int) {
        let expense = ExpenseItem(name: name, amount: amount)
        
        expenses[personIndex].getDailyExpensesByIndex(index: index).addToExpenses(expense)
        
        saveContext()
    }
    
    func createMocData() {
        let moc = CoreDataStack.shared.mainContext
        let expense = ExpenseItem(name: "First Item", amount: 2.23)
        let dailyExpenses = DailyExpensesItem(context: moc)
        dailyExpenses.addToExpenses(expense)
        let expensesByPerson = ExpensesByPersonItem(context: moc)
        expensesByPerson.name = "Mike"
        expensesByPerson.addToWeeklyExpenses(dailyExpenses)
        
        saveContext()
    }
    
    func updateExpense(expense: ExpenseItem, name: String, amount: Double) {
        expense.name = name
        expense.amount = amount
        
        saveContext()
    }
    
    func deleteExpense(personIndex: Int, dayIndex: Int, at offsets: IndexSet) {
        let moc = CoreDataStack.shared.mainContext
        
        for index in offsets {
            let expense = expenses[personIndex].getDailyExpensesByIndex(index: dayIndex).expensesArray[index]
            moc.delete(expense)
        }
        
        saveContext()
    }
//    
//    func addPerson(name: String) {
//        let person = ExpensesByPersonItem(context: expensesController.managedObjectContext)
//        person.name = name
//        
//        let dayOne = DailyExpensesItem(context: expensesController.managedObjectContext)
//        dayOne.expenses = []
//        
//        person.weeklyExpenses = NSSet(array: [dayOne])
//        
//        saveContext()
//    }
//    
//    func deletePerson(at offsets: IndexSet) {
//        for index in offsets {
//            let person = expenses[index]
//            expensesController.managedObjectContext.delete(person)
//        }
//        
//        saveContext()
//    }
//    
//    func updatePersonName(name: String, personIndex: Int) {
//        expenses[personIndex].name = name
//        
//        saveContext()
//    }
}

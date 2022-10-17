//
//  RealmManager.swift
//  MoneyTracker
//
//  Created by Viktoriya on 17.10.22.
//

import Foundation
import RealmSwift

class RealmManager {
    private let realm = try! Realm()
    
    // сохранение
    func saveExpense(name: String, price: Double, date: Date, category: ExpenseCategory) {
        let expense = ExpenseRealmModel.create(name: name, price: price, date: date, category: category)
        try! realm.write({
            realm.add(expense)
        })
    }
    
    // получение
    func getExpenses() -> [Expense] {
        let expenses = realm.objects(ExpenseRealmModel.self)
        var resalt = [Expense]()
        for expense in expenses {
            let model = Expense(model: expense)
            resalt.append(model)
            
        }
        return resalt
    }
}

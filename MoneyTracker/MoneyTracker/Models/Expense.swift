//
//  Expense.swift
//  MoneyTracker
//
//  Created by Viktoriya on 10.10.22.
//

import Foundation
import RealmSwift

enum ExpenseCategory: String {
    case food
    case house
    case car
}

struct Expense {
    let id: String
    let name: String
    let price: Double
    let date: Date
    let category: ExpenseCategory
    
    init(model: ExpenseRealmModel) {
        id = model.id.stringValue
        name = model.name
        price = model.price
        date = model.date
        category = ExpenseCategory(rawValue: model.caregory) ?? .food
    }

}

class ExpenseRealmModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name = ""
    @Persisted var price: Double = 0.0
    @Persisted var date = Date()
    @Persisted var caregory = ""
    
    static func create(name: String, price: Double, date: Date, category: ExpenseCategory) -> ExpenseRealmModel {
        let model = ExpenseRealmModel()
        model.name = name
        model.price = price
        model.date = date
        model.caregory = category.rawValue
        return model
    }
}

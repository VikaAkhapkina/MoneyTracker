//
//  Expense.swift
//  MoneyTracker
//
//  Created by Viktoriya on 10.10.22.
//

import Foundation

enum ExpenseCategory {
    case food
    case house
    case car
}

struct Expense {
    let name: String
    let price: Double
    let date: Date
    let category: ExpenseCategory
}

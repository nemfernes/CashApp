//
//  Goal.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 18.09.2025.
//

import Foundation
import RealmSwift
import UIKit


public class Goal: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var emoji: String = ""
    @objc dynamic var amount: Int = 0
    @objc dynamic var currency: String = ""
    @objc dynamic var date: String = ""

    let transactions = List<Transaction>()
    
    public override static func primaryKey() -> String? { "id" }
}
public class Transaction: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var amount: Int = 0
    @objc dynamic var date: Date = Date()
    @objc dynamic var typeRaw: String = TransactionType.withdraw.rawValue
    
    @objc dynamic var goal: Goal?
    
    var type: TransactionType {
        get { TransactionType(rawValue: typeRaw) ?? .withdraw }
        set { typeRaw = newValue.rawValue }
    }
    
    public override static func primaryKey() -> String? { "id" }
}

extension Goal {
    /// Сумма всех income
    var totalIncome: Int {
        transactions
            .filter { $0.type == .income }
            .map { $0.amount }
            .reduce(0, +)
    }
    
    /// Сумма всех withdraw
    var totalWithdraw: Int {
        transactions
            .filter { $0.type == .withdraw }
            .map { $0.amount }
            .reduce(0, +)
    }
    
    /// Чисто накоплено = income - withdraw
    var accumulated: Int {
        totalIncome - totalWithdraw
    }
    
    /// Сколько осталось до цели
    var remaining: Int {
        max(amount - accumulated, 0)
    }
    
    /// Прогресс выполнения (0...1)
    var progress: Double {
        guard amount > 0 else { return 0 }
        return Double(accumulated) / Double(amount)
    }
    
    /// Средний доход в месяц
    var averagePerMonth: Int {
        let incomes = transactions.filter { $0.type == .income }
        guard let firstDate = incomes.min(by: { $0.date < $1.date })?.date else { return 0 }
        guard let lastDate = incomes.max(by: { $0.date < $1.date })?.date else { return 0 }
        
        let months = Calendar.current.dateComponents([.month], from: firstDate, to: lastDate).month ?? 0
        if months == 0 { return accumulated }
        return accumulated / months
    }
    
    var currencySymbol: String {
           switch currency.uppercased() {
           case "USD": return "$"
           case "EUR": return "€"
           case "JPY": return "¥"
           case "GBP": return "£"
           case "CNY": return "元"
           default: return currency  
           }
       }
}

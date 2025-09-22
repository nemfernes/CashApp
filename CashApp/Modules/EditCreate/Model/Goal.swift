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
    @objc dynamic var colorHex: String = "#2B6CF0"
    
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
        return min(Double(accumulated) / Double(amount), 1.0)
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
    
    var incomeThisMonth: Int {
        let calendar = Calendar.current
        let now = Date()
        
        // начало месяца
        guard let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now)) else {
            return 0
        }
        
        return transactions
            .filter { $0.type == .income && $0.date >= startOfMonth && $0.date <= now }
            .map { $0.amount }
            .reduce(0, +)
    }
    
    var targetDate: Date? {
           let formatter = DateFormatter()
           formatter.locale = Locale.current
          formatter.dateFormat = "dd MMMM yyyy"
           return formatter.date(from: date)
       }
    
    var targetDateText: String {
           guard let targetDate else { return "" }
           let formatter = DateFormatter()
           formatter.locale = Locale.current
           formatter.dateFormat = "MMMM yyyy"
           return formatter.string(from: targetDate)
       }
    
    var timeRemainingMonths: Int {
            guard let targetDate else { return 0 }
            let now = Date()
            let diff = Calendar.current.dateComponents([.month], from: now, to: targetDate).month ?? 0
            return max(diff, 0)
        }
    
    var elapsedMonths: Int {
           guard let first = transactions.min(by: { $0.date < $1.date })?.date,
                 let targetDate else { return 0 }
           let diff = Calendar.current.dateComponents([.month], from: first, to: Date()).month ?? 0
           return max(diff, 0)
       }
    
    var progressOverTimeString: String {
           let months = elapsedMonths
           let percent = progressOverTimePercent
        return "\(months) \(LS.Common.Strings.month.localized) (\(percent)%)"
       }
    
    var progressOverTimePercent: Int {
            guard let first = transactions.min(by: { $0.date < $1.date })?.date,
                  let targetDate else { return 0 }
            let totalMonths = Calendar.current.dateComponents([.month], from: first, to: targetDate).month ?? 0
            guard totalMonths > 0 else { return 0 }
            return min(Int((Double(elapsedMonths) / Double(totalMonths)) * 100), 100)
        }

    /// Сколько осталось дней
    private var daysLeft: Int {
        guard let target = targetDate else { return 0 }
        let now = Date()
        let diff = Calendar.current.dateComponents([.day], from: now, to: target).day ?? 0
        return max(diff, 0)
    }
    
    /// Сколько осталось недель
    private var weeksLeft: Int {
        daysLeft / 7
    }
    
    /// Сколько осталось месяцев
    private var monthsLeft: Int {
        guard let target = targetDate else { return 0 }
        let now = Date()
        let diff = Calendar.current.dateComponents([.month], from: now, to: target).month ?? 0
        return max(diff, 0)
    }
    
    /// Процент оставшейся суммы (для "40% of the goal")
    var remainingPercent: Int {
        guard amount > 0 else { return 0 }
        return Int((Double(remaining) / Double(amount)) * 100)
    }
    
    var perDayPlan: Int {
        guard daysLeft > 0 else { return remaining }
        return remaining / daysLeft
    }
    
    var perWeekPlan: Int {
        guard weeksLeft > 0 else { return remaining }
        return remaining / weeksLeft
    }
    
    var perMonthPlan: Int {
        guard monthsLeft > 0 else { return remaining }
        return remaining / monthsLeft
    }
    
    var uiColor: UIColor {
           return UIColor(hex: colorHex) ?? .systemBlue
       }
}

extension Transaction {
   
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.string(from: date)
    }
    
   
    var formattedAmount: String {
        let symbol = goal?.currencySymbol ?? "$"
        let sign = type == .income ? "+" : "-"
        return "\(sign) \(symbol)\(amount.formattedWithSeparator)"
    }
    
    var typeText: String {
        switch type {
        case .income: return LS.Common.Strings.savings.localized
        case .withdraw: return LS.Common.Strings.withdraw.localized
        }
    }
    
    var amountColor: UIColor {
        switch type {
        case .income: return .color1BC04D
        case .withdraw: return .colorCF212C
        }
    }
}

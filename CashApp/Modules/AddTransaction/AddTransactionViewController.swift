//
//  AddTransactionViewController.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 21.09.2025.
//

import UIKit
import RealmSwift

public enum TransactionType: String, PersistableEnum {
    case income
    case withdraw
}

final class AddTransactionViewController<Router: AddTransactionRouter>: ViewController<AddTransactionView, Router> {
	
	// MARK: - Properties
     var transactionCompletion: (() -> Void)?
     let transactionType: TransactionType
     let goal: Goal
     private var editingTransaction: Transaction?
    
    init(transactionCompletion: (() -> Void)?, transactionType: TransactionType, goal: Goal, editingTransaction: Transaction? = nil) {
        self.transactionCompletion = transactionCompletion
        self.transactionType = transactionType
        self.goal = goal
        self.editingTransaction = editingTransaction
        super.init()
    }
	// MARK: - Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		setupActions()
	}
	
	// MARK: - Private methods
	private func setupView() {
        mainView.setupUI(type: transactionType)
        if let transaction = editingTransaction {
                   mainView.amountTextField.text = "\(transaction.amount)"
                   
                   let formatter = DateFormatter()
                   formatter.dateFormat = "MMM dd, yyyy"
                   mainView.dateValueLabel.text = formatter.string(from: transaction.date)
               }
	}

	private func setupActions() {
        mainView.addAction = { [weak self] in
			guard let self else { return }
            validateAndSave()
		}
        
        mainView.dateAction = { [weak self] in
            guard let self else { return }
            self.router.toDatePick { date in
                self.mainView.updateDate(date: date)
            }
        }
	}
    
    private func validateAndSave() {
        let amountText = mainView.amountTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
          let dateText = mainView.dateValueLabel.text ?? ""
          
        guard let amount = Int(amountText), amount > 0 else {
              router.openWarningAlert(
                  title: LS.Common.Strings.warning.localized,
                  text: LS.Common.Strings.notAll.localized
              )
              return
          }
          
          if dateText.isEmpty || dateText == LS.Common.Strings.december.localized {
              router.openWarningAlert(
                  title: LS.Common.Strings.warning.localized,
                  text: LS.Common.Strings.notAll.localized
              )
              return
          }
        
        if transactionType == .withdraw, amount > goal.accumulated {
                router.openWarningAlert(
                    title: LS.Common.Strings.warning.localized,
                    text: LS.Common.Strings.notEnoughFunds.localized 
                )
                return
            }
    
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "dd MMMM yyyy"
        let parsedDate = formatter.date(from: dateText) ?? Date()
           
        if let transaction = editingTransaction {
                    DatabaseManager.shared.update(transaction) {
                        transaction.amount = amount
                        transaction.date = parsedDate
                        transaction.type = self.transactionType
                    }
                } else {
                    let transaction = Transaction()
                    transaction.amount = amount
                    transaction.date = parsedDate
                    transaction.type = transactionType
                    transaction.goal = goal
                    
                    DatabaseManager.shared.update(goal) {
                        goal.transactions.append(transaction)
                    }
                }
            
        
        print(DatabaseManager.shared
            .getAll(Goal.self))
        transactionCompletion?()
        router.close()
    }
}

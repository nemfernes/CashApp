//
//  DetailGoalRouter.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 20.09.2025.
//

import UIKit

public class DetailGoalRouter: Router {
    
    func toTransaction(transactionCompletion: (() -> Void)?, transactionType: TransactionType,  goal: Goal, editingTransaction: Transaction? = nil) {
        openAddTransaction(transition: ModalTransition(fromViewController: viewController, transitionStyle: .crossDissolve, presentationStyle: .pageSheet), router: AddTransactionRouter.self, transactionCompletion: transactionCompletion, transactionType: transactionType, goal: goal, editingTransaction: editingTransaction)
    }
    
    func toFilter(filterCompletion: ((_ selectedType: String, _ selectedOrder: String) -> Void)?) {
        openFilter(transition:  ModalTransition(fromViewController: viewController, transitionStyle: .crossDissolve, presentationStyle: .pageSheet), router: FilterRouter.self, filterCompletion: filterCompletion)
    }
    
    func toEditCreate(goal: Goal, closeCompletion: (() -> Void)?) {
        openEditCreate(transition: ModalTransition(fromViewController: viewController, transitionStyle: .crossDissolve, presentationStyle: .fullScreen), router: EditCreateRouter.self, goal: goal, closeCompletion: closeCompletion)
    }
}

extension DetailGoalRouter: AddTransactionRoute {}
extension DetailGoalRouter: FilterRoute {}
extension DetailGoalRouter: EditCreateRoute {}

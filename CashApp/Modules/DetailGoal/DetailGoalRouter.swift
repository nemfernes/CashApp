//
//  DetailGoalRouter.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 20.09.2025.
//

import UIKit

public class DetailGoalRouter: Router {
    
    func toTransaction(transactionCompletion: (() -> Void)?, transactionType: TransactionType,  goal: Goal) {
        openAddTransaction(transition: ModalTransition(fromViewController: viewController, transitionStyle: .crossDissolve, presentationStyle: .pageSheet), router: AddTransactionRouter.self, transactionCompletion: transactionCompletion, transactionType: transactionType, goal: goal)
    }
}

extension DetailGoalRouter: AddTransactionRoute {}

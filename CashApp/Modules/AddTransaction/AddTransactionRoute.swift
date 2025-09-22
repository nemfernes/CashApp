//
//  AddTransactionRoute.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 21.09.2025.
//


public protocol AddTransactionRoute where Self: RouterProtocol {
	func openAddTransaction<Router: AddTransactionRouter>(transition: TransitionProtocol, router: Router.Type, transactionCompletion: (() -> Void)?, transactionType: TransactionType, goal: Goal, editingTransaction: Transaction?)
}

public extension AddTransactionRoute {
	func openAddTransaction<Router: AddTransactionRouter>(transition: TransitionProtocol, router: Router.Type, transactionCompletion: (() -> Void)?, transactionType: TransactionType, goal: Goal, editingTransaction: Transaction? = nil) {
        let controller = AddTransactionViewController<Router>(transactionCompletion: transactionCompletion, transactionType: transactionType, goal: goal, editingTransaction: editingTransaction)
		controller.router = Router(viewController: controller, fromTransition: transition)
		transition.open(controller, animated: true, completion: nil)
	}
}

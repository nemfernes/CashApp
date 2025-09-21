//
//  AddTransactionRoute.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 21.09.2025.
//


public protocol AddTransactionRoute where Self: RouterProtocol {
	func openAddTransaction<Router: AddTransactionRouter>(transition: TransitionProtocol, router: Router.Type, transactionCompletion: (() -> Void)?, transactionType: TransactionType, goal: Goal)
}

public extension AddTransactionRoute {
	func openAddTransaction<Router: AddTransactionRouter>(transition: TransitionProtocol, router: Router.Type, transactionCompletion: (() -> Void)?, transactionType: TransactionType, goal: Goal) {
        let controller = AddTransactionViewController<Router>(transactionCompletion: transactionCompletion, transactionType: transactionType, goal: goal)
		controller.router = Router(viewController: controller, fromTransition: transition)
		transition.open(controller, animated: true, completion: nil)
	}
}

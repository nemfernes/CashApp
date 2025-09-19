//
//  EditCreateRoute.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 17.09.2025.
//


public protocol EditCreateRoute where Self: RouterProtocol {
	func openEditCreate<Router: EditCreateRouter>(transition: TransitionProtocol, router: Router.Type)
}

public extension EditCreateRoute {
	func openEditCreate<Router: EditCreateRouter>(transition: TransitionProtocol, router: Router.Type) {
        let controller = EditCreateViewController<Router>(goal: nil)
		controller.router = Router(viewController: controller, fromTransition: transition)
		transition.open(controller, animated: true, completion: nil)
	}
}

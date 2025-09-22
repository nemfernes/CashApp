//
//  EditCreateRoute.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 17.09.2025.
//


public protocol EditCreateRoute where Self: RouterProtocol {
	func openEditCreate<Router: EditCreateRouter>(transition: TransitionProtocol, router: Router.Type, goal: Goal?, closeCompletion: (() -> Void)?)
}

public extension EditCreateRoute {
    func openEditCreate<Router: EditCreateRouter>(transition: TransitionProtocol, router: Router.Type, goal: Goal? = nil, closeCompletion: (() -> Void)?) {
        let controller = EditCreateViewController<Router>(goal: goal, closeCompletion: closeCompletion)
        controller.router = Router(viewController: controller, fromTransition: transition)
		transition.open(controller, animated: true, completion: nil)
	}
}

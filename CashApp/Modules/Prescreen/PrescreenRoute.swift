//
//  PrescreenRoute.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 17.09.2025.
//


public protocol PrescreenRoute where Self: RouterProtocol {
	func openPrescreen<Router: PrescreenRouter>(transition: TransitionProtocol, router: Router.Type)
}

public extension PrescreenRoute {
	func openPrescreen<Router: PrescreenRouter>(transition: TransitionProtocol, router: Router.Type) {
		let controller = PrescreenViewController<Router>()
		controller.router = Router(viewController: controller, fromTransition: transition)
		transition.open(controller, animated: true, completion: nil)
	}
}

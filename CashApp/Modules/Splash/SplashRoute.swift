//
//  SplashRoute.swift
//  AI Logo Generator
//
//  Created by Oleksii on 28.07.2025.
//


public protocol SplashRoute where Self: RouterProtocol {
	func openSplash<Router: SplashRouter>(transition: TransitionProtocol, router: Router.Type)
}

public extension SplashRoute {
	func openSplash<Router: SplashRouter>(transition: TransitionProtocol, router: Router.Type) {
		let controller = SplashViewController<Router>()
		controller.router = Router(viewController: controller, fromTransition: transition)
		transition.open(controller, animated: true, completion: nil)
	}
}

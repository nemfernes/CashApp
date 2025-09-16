//
//  OnboardingRoute.swift
//  AI Logo Generator
//
//  Created by Oleksii on 28.07.2025.
//


public protocol OnboardingRoute where Self: RouterProtocol {
	func openOnboarding<Router: OnboardingRouter>(transition: TransitionProtocol, router: Router.Type)
}

public extension OnboardingRoute {
	func openOnboarding<Router: OnboardingRouter>(transition: TransitionProtocol, router: Router.Type) {
		let controller = OnboardingViewController<Router>()
		controller.router = Router(viewController: controller, fromTransition: transition)
		transition.open(controller, animated: true, completion: nil)
	}
}

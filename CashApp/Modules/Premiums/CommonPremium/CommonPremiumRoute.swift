//
//  CommonPremiumRoute.swift
//  AI Logo Generator
//
//  Created by Oleksii on 29.07.2025.
//


public protocol CommonPremiumRoute where Self: RouterProtocol {
	func openCommonPremium<Router: CommonPremiumRouter>(transition: TransitionProtocol, router: Router.Type)
}

public extension CommonPremiumRoute {
	func openCommonPremium<Router: CommonPremiumRouter>(transition: TransitionProtocol, router: Router.Type) {
		fatalError()
	}
}

public func initCommonPremium<Router: CommonPremiumRouter>(delegate: PremiumControllerDelegate,
														   adaptyPlacement: AdaptyPlacement,
														   transition: TransitionProtocol,
														   router: Router.Type) {
	let controller = CommonPremiumViewController<Router>(delegate: delegate, adaptyPlacement: adaptyPlacement)
	controller.router = Router(viewController: controller, fromTransition: transition)
	transition.open(controller, animated: true, completion: nil)
}

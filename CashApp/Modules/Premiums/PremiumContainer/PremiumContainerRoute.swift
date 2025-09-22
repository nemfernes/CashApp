//
//  PremiumContainerRoute.swift
//  AI Logo Generator
//
//  Created by Oleksii on 29.07.2025.
//


public protocol PremiumContainerRoute where Self: RouterProtocol {
	func openPremiumContainer<Router: PremiumContainerRouter>(closeCompletion: (() -> Void)?,
															  adaptyPlacement: AdaptyPlacement,
															  transition: TransitionProtocol, router: Router.Type)
}

public extension PremiumContainerRoute {
	func openPremiumContainer<Router: PremiumContainerRouter>(closeCompletion: (() -> Void)?,
															  adaptyPlacement: AdaptyPlacement,
															  transition: TransitionProtocol, router: Router.Type) {
		let controller = PremiumContainerViewController<Router>(closeCompletion: closeCompletion, adaptyPlacement: adaptyPlacement)
		controller.router = Router(viewController: controller, fromTransition: transition)
		transition.open(controller, animated: true, completion: nil)
	}
}

//
//  FilterRoute.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 22.09.2025.
//


public protocol FilterRoute where Self: RouterProtocol {
	func openFilter<Router: FilterRouter>(transition: TransitionProtocol, router: Router.Type, filterCompletion: ((_ selectedType: String, _ selectedOrder: String) -> Void)?)
}

public extension FilterRoute {
	func openFilter<Router: FilterRouter>(transition: TransitionProtocol, router: Router.Type, filterCompletion: ((_ selectedType: String, _ selectedOrder: String) -> Void)?) {
        let controller = FilterViewController<Router>(filterCompletion: filterCompletion)
		controller.router = Router(viewController: controller, fromTransition: transition)
		transition.open(controller, animated: true, completion: nil)
	}
}

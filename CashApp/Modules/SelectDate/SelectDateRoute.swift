//
//  SelectDateRoute.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 18.09.2025.
//


public protocol SelectDateRoute where Self: RouterProtocol {
	func openSelectDate<Router: SelectDateRouter>(transition: TransitionProtocol, router: Router.Type, dateCompletion: ((String) -> Void)?)
}

public extension SelectDateRoute {
	func openSelectDate<Router: SelectDateRouter>(transition: TransitionProtocol, router: Router.Type, dateCompletion: ((String) -> Void)?) {
        let controller = SelectDateViewController<Router>(dateCompletion: dateCompletion)
		controller.router = Router(viewController: controller, fromTransition: transition)
		transition.open(controller, animated: true, completion: nil)
	}
}

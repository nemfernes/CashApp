//
//  SelectCurrencyRoute.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 18.09.2025.
//


public protocol SelectCurrencyRoute where Self: RouterProtocol {
	func openSelectCurrency<Router: SelectCurrencyRouter>(transition: TransitionProtocol, router: Router.Type, currencyCompletion: ((String) -> Void)?)
}

public extension SelectCurrencyRoute {
	func openSelectCurrency<Router: SelectCurrencyRouter>(transition: TransitionProtocol, router: Router.Type, currencyCompletion: ((String) -> Void)?) {
        let controller = SelectCurrencyViewController<Router>(currencyCompletion: currencyCompletion)
		controller.router = Router(viewController: controller, fromTransition: transition)
		transition.open(controller, animated: true, completion: nil)
	}
}

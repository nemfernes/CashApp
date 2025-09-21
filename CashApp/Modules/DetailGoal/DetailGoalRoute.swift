//
//  DetailGoalRoute.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 20.09.2025.
//


public protocol DetailGoalRoute where Self: RouterProtocol {
	func openDetailGoal<Router: DetailGoalRouter>(transition: TransitionProtocol, router: Router.Type, goal: Goal)
}

public extension DetailGoalRoute {
	func openDetailGoal<Router: DetailGoalRouter>(transition: TransitionProtocol, router: Router.Type, goal: Goal) {
        let controller = DetailGoalViewController<Router>(goal: goal)
		controller.router = Router(viewController: controller, fromTransition: transition)
		transition.open(controller, animated: true, completion: nil)
	}
}

//
//  SelectEmojiRoute.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 17.09.2025.
//


public protocol SelectEmojiRoute where Self: RouterProtocol {
	func openSelectEmoji<Router: SelectEmojiRouter>(transition: TransitionProtocol, router: Router.Type, emojiCompletion: ((String) -> Void)?)
}

public extension SelectEmojiRoute {
	func openSelectEmoji<Router: SelectEmojiRouter>(transition: TransitionProtocol, router: Router.Type, emojiCompletion: ((String) -> Void)?) {
        let controller = SelectEmojiViewController<Router>(emojiCompletion: emojiCompletion)
		controller.router = Router(viewController: controller, fromTransition: transition)
		transition.open(controller, animated: true, completion: nil)
	}
}

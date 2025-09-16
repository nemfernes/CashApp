//
//  CloseRoute.swift
//  IOSScanner-UI
//
//  Created by Artie on 27.03.2023.
//

import UIKit

public protocol CloseRoute where Self: RouterProtocol {
	func close(_ completion: Transition.Completion?)
	func closeTabBar(_ completion: Transition.Completion?)
}

public extension CloseRoute {
	func close(_ completion: Transition.Completion? = nil) {
		guard let fromTransition = fromTransition else {
			fatalError("You should specify an open transition in order to close a module.")
		}
		
		guard let viewController = viewController else {
			fatalError("Nothing to close.")
		}
		
		fromTransition.close(viewController, animated: true, completion: completion)
	}
	
	func closeTabBar(_ completion: Transition.Completion?) {
		guard let fromTransition = fromTransition else {
			fatalError("You should specify an open transition in order to close a module.")
		}
		
		guard let viewController = viewController else {
			fatalError("Nothing to close.")
		}
		
		fromTransition.closeTabBar(viewController, animated: true, completion: completion)
	}
}

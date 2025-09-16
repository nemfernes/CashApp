//
//  Transition.swift
//  IOSScanner-UI
//
//  Created by Artie on 27.03.2023.
//

import UIKit

public protocol TransitionProtocol: AnyObject {
	typealias Completion = () -> ()
	
	func open(_ viewController: UIViewController, animated: Bool, completion: Completion?)
	func close(_ viewController: UIViewController, animated: Bool, completion: Completion?)
	func closeTabBar(_ viewController: UIViewController, animated: Bool, completion: Completion?)
	func setInitial(_ viewCintroller: UIViewController)
}

open class Transition: NSObject, TransitionProtocol {
	public private(set) weak var fromViewController: UIViewController?
	public private(set) var animator: Animator?
	public var interaction: UIPercentDrivenInteractiveTransition?

	public init(fromViewController: UIViewController?, animator: Animator? = nil) {
		self.fromViewController = fromViewController
		self.animator = animator
	}
	
	public func push(_ viewController: UIViewController, animated: Bool, completion: Completion?) {
		fatalError("This is abstract method")
	}
	
	open func open(_ viewController: UIViewController, animated: Bool, completion: Completion?) {
		fatalError("This is abstract method")
	}
	
	open func close(_ viewController: UIViewController, animated: Bool, completion: Completion?) {
		fatalError("This is abstract method")
	}
	
	open func closeTabBar(_ viewController: UIViewController, animated: Bool, completion: Completion?) {
		fatalError("This is abstract method")
	}
	
	open func setInitial(_ viewCintroller: UIViewController) {
		fatalError("This is abstract method")
	}
}

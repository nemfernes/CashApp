//
//  Router.swift
//  IOSScanner-UI
//
//  Created by Artie on 27.03.2023.
//

import UIKit

public protocol RouterProtocol where Self: AnyObject {
	var viewController: UIViewController? { get }
	var fromTransition: TransitionProtocol? { get }
	
	init(viewController: UIViewController?, fromTransition: TransitionProtocol?)
	func closeController(completion: Transition.Completion?)
}

open class Router: RouterProtocol {
	public private(set) weak var viewController: UIViewController?
	public private(set) var fromTransition: TransitionProtocol?
	
	public required init(viewController: UIViewController? = nil, fromTransition: TransitionProtocol? = nil) {
		self.viewController = viewController
		self.fromTransition = fromTransition
	}
	public func closeController(completion: Transition.Completion? = nil) {
		close(completion)
	}

}

extension Router: CloseRoute {}
extension Router: SafariRoute {}
extension Router: AlertRoute {}
extension Router: ShareRoute {}

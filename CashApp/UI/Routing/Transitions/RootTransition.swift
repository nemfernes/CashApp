//
//  RootTransition.swift
//  IOSScanner-UI
//
//  Created by Artie on 27.03.2023.
//

import UIKit

public final class RootTransition: TransitionProtocol {
	// MARK: - Properties
	
	private weak var window: UIWindow?
	private let options: UIView.AnimationOptions
	
	// MARK: - Inits
	
	public init(window: UIWindow, options: UIView.AnimationOptions = .transitionCrossDissolve) {
		self.window = window
		self.options = options
	}
	
	// MARK: - Transition methods
	
	public func open(_ viewController: UIViewController, animated: Bool, completion: Completion?) {
		guard let window = window else { fatalError("Window is nil") }
		window.rootViewController = viewController
		if animated {
			UIView.transition(with: window, duration: 0.2, options: options, animations: nil) { _ in completion?() }
		}
	}
	
	@available(*, deprecated)
	public func close(_ viewController: UIViewController, animated: Bool, completion: Completion?) {
		fatalError()
	}
	
	@available(*, deprecated)
	public func closeTabBar(_ viewController: UIViewController, animated: Bool, completion: Completion?) {
		fatalError()
	}
	
	@available(*, deprecated)
	public func setInitial(_ viewCintroller: UIViewController) {
		fatalError()
	}
}

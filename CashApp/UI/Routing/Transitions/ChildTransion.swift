//
//  ChildTransion.swift
//  IOSScanner-UI
//
//  Created by Artie on 07.06.2023.
//

import UIKit


public final class ChildTransition: TransitionProtocol {
	// MARK: - Properties
	
	private weak var containerView: UIView?
	private weak var rootViewController: UIViewController?

	// MARK: - Inits
	
	public init(containerView: UIView?, rootViewController: UIViewController?) {
		self.containerView = containerView
		self.rootViewController = rootViewController
	}
	
	// MARK: - Transition methods
	
	public func open(_ viewController: UIViewController, animated: Bool, completion: Completion?) {
		guard let containerView else { fatalError("containerView is nil") }
		guard let rootViewController else { fatalError("rootViewController is nil") }
		let oldViewController = rootViewController.children.first
		rootViewController.addChild(viewController)
		containerView.addSubview(viewController.view)
		setViewConstraints(rootView: containerView, view: viewController.view)
		viewController.didMove(toParent: rootViewController)
		removeOldChild(viewController: oldViewController)
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
	
	
	// MARK: - Private methods
	private func setViewConstraints(rootView: UIView, view: UIView) {
		view.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			view.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
			view.trailingAnchor.constraint(equalTo: rootView.trailingAnchor),
			view.topAnchor.constraint(equalTo: rootView.topAnchor),
			view.bottomAnchor.constraint(equalTo: rootView.bottomAnchor)
		])
	}

	private func removeOldChild(viewController: UIViewController?) {
		viewController?.willMove(toParent: nil)
		viewController?.view.removeFromSuperview()
	}
}

//
//  ChildFadeTransition.swift
//  IOSScanner-UI
//
//  Created by Artie on 07.06.2023.
//

import UIKit

public final class ChildFadeTransition: TransitionProtocol {
	// MARK: - Properties
	
	private weak var containerView: UIView?
	private weak var rootViewController: UIViewController?
	private weak var currentChildViewController: UIViewController?

	// MARK: - Inits
	
	public init(containerView: UIView?, rootViewController: UIViewController?) {
		self.containerView = containerView
		self.rootViewController = rootViewController
		self.currentChildViewController = rootViewController?.children.first
	}
	
	// MARK: - Transition methods
	
	public func open(_ viewController: UIViewController, animated: Bool, completion: Completion?) {
		guard currentChildViewController != viewController else { return }
		guard let containerView else { fatalError("containerView is nil") }
		guard let rootViewController else { fatalError("rootViewController is nil") }
		if let currentChildViewController {
			currentChildViewController.willMove(toParent: nil)
			rootViewController.addChild(viewController)
			containerView.addSubview(viewController.view)
			viewController.view.frame = containerView.bounds
			setViewConstraints(rootView: containerView, view: viewController.view)
			
			rootViewController.transition(from: currentChildViewController, to: viewController, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
			}) { completed in
				currentChildViewController.removeFromParent()
				viewController.didMove(toParent: rootViewController)
			}
		} else {
			rootViewController.addChild(viewController)
			containerView.addSubview(viewController.view)
			viewController.view.alpha = 0
			setViewConstraints(rootView: containerView, view: viewController.view)
			viewController.didMove(toParent: rootViewController)
			viewController.view.alpha = 0
			UIView.animate(withDuration: 0.3, delay: 0, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
				viewController.view.alpha = 1
			})
		}
	}
	
	public func checkControllers(_ viewController: UIViewController) -> Bool {
		guard currentChildViewController != viewController else { return false }
		guard let containerView else { fatalError("containerView is nil") }
		guard let rootViewController else { fatalError("rootViewController is nil") }
		return true
	}
	
	@available(*, deprecated)
	public func close(_ viewController: UIViewController, animated: Bool, completion: Completion?) {
		UIView.animate(withDuration: 0.3, delay: 0, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
			viewController.view.alpha = 0
		}, completion: { _ in
			viewController.removeFromParent()
			viewController.willMove(toParent: nil)
			viewController.view.removeFromSuperview()
			completion?()
		})
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

//
//  ShadowPresentationController.swift
//  Translator-UI
//
//  Created by Oleksii on 12.04.2024.
//

import UIKit

class ShadowPresentationController: UIPresentationController {
	
	private lazy var shadowView: UIView = {
		let view = UIView()
		view.alpha = 0
		view.frame = containerView?.bounds ?? .zero
        view.backgroundColor = .color151718
		return view
	}()
	// MARK: - Private properties
	
	private var transition: TransitionProtocol
	private var interaction: UIPercentDrivenInteractiveTransition?
	
	// MARK: - Inits
	
	init(presentedViewController: UIViewController,
		 presenting presentingViewController: UIViewController?,
		 transition: TransitionProtocol) {
		self.transition = transition
		super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
	}
	
	// MARK: - Override properties
	
	override var frameOfPresentedViewInContainerView: CGRect {
		let maxSize = (containerView?.bounds ?? .zero).size
		let origin = CGPoint(x: 0, y: 0)
		return .init(origin: origin, size: maxSize)
	}
	
	// MARK: - Overrise methods
	
	override func containerViewWillLayoutSubviews() {
		super.containerViewWillLayoutSubviews()
		presentedViewController.view.frame = frameOfPresentedViewInContainerView
	}
	
	override func presentationTransitionWillBegin() {
		containerView?.backgroundColor = UIColor.black.withAlphaComponent(0)
		containerView?.insertSubview(shadowView, at: 0)

		presentedView?.frame = frameOfPresentedViewInContainerView
		containerView?.addSubview(presentedViewController.view)
		
		presentingViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
			self.shadowView.alpha = 1
		}, completion: nil)
	}
	
	override func presentationTransitionDidEnd(_ completed: Bool) {
		super.presentationTransitionDidEnd(completed)
		
	}
	
	override func dismissalTransitionWillBegin() {
		presentingViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
			self.shadowView.alpha = 0
		}, completion: nil)
	}
	
	override func dismissalTransitionDidEnd(_ completed: Bool) {
		super.dismissalTransitionDidEnd(completed)
	}
}

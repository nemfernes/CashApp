//
//  BlurPresentationController.swift
//  IOSScanner-UI
//
//  Created by Artie on 23.06.2023.
//

import UIKit
class BlurPresentationController: UIPresentationController {
	
	private lazy var blurView: UIVisualEffectView = {
		let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.alpha = 0
		blurEffectView.frame = containerView?.bounds ?? .zero
		return blurEffectView
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
		containerView?.insertSubview(blurView, at: 0)

		presentedView?.frame = frameOfPresentedViewInContainerView
		containerView?.addSubview(presentedViewController.view)
		
		presentingViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
			self.blurView.alpha = 0.8
		}, completion: nil)
	}
	
	override func presentationTransitionDidEnd(_ completed: Bool) {
		super.presentationTransitionDidEnd(completed)
		
	}
	
	override func dismissalTransitionWillBegin() {
		presentingViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
			self.blurView.alpha = 0
		}, completion: nil)
	}
	
	override func dismissalTransitionDidEnd(_ completed: Bool) {
		super.dismissalTransitionDidEnd(completed)
	}
}

//
//  BlurBottomTransition.swift
//  IOSScanner-UI
//
//  Created by Artie on 23.06.2023.
//

import UIKit

public class BlurBottomTransition: Transition {
	// MARK: - Properties
	
	private var presentTransition: UIViewControllerAnimatedTransitioning?
	private var dismissTransition: UIViewControllerAnimatedTransitioning?
	private var closeCompletion: (() -> Void)?
	// MARK: - Inits
	
	public init(fromViewController: UIViewController?, closeCompletion: (() -> Void)? = nil) {
		self.closeCompletion = closeCompletion
		super.init(fromViewController: fromViewController, animator: BottomAnimator())
	}
	
	// MARK: - Transition methods
	
	public override func open(_ viewController: UIViewController, animated: Bool, completion: Completion?) {
		viewController.transitioningDelegate = self
		viewController.modalTransitionStyle = .coverVertical
		viewController.modalPresentationStyle = .custom
		fromViewController?.present(viewController, animated: animated, completion: completion)
	}
	
	public override func close(_ viewController: UIViewController, animated: Bool, completion: Completion?) {
		viewController.dismiss(animated: animated, completion: completion ?? closeCompletion)
	}
	
}

// MARK: - UIViewControllerTransitioningDelegate
extension BlurBottomTransition: UIViewControllerTransitioningDelegate {
	public func animationController(forPresented presented: UIViewController,
																	presenting: UIViewController,
																	source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		animator?.isPresenting = true
		return animator
	}
	
	public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		animator?.isPresenting = false
		return animator
	}

	public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
		BlurPresentationController(presentedViewController: presented, presenting: presenting, transition: self)
	}

	public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
		return interaction
	}

	public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
		return interaction
	}
}

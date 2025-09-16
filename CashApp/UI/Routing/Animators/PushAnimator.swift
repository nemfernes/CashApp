//
//  PushAnimator.swift
//  IOSScanner-UI
//
//  Created by Artie on 27.03.2023.
//

import UIKit

public final class PushAnimator: NSObject, Animator {
	// MARK: - Public properties
	
	public var isPresenting: Bool = true
	
	// MARK: - Private properties
	
	private let duration: TimeInterval
	private let curve: CAMediaTimingFunctionName
	
	// MARK: - Inits
	
	public init(duration: TimeInterval = 0.2, curve: CAMediaTimingFunctionName = .easeInEaseOut) {
		self.duration = duration
		self.curve = curve
	}
	
	// MARK: - UIViewControllerAnimatedTransitioning
	
	public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return duration
	}
	
	public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		if let fromView = transitionContext.view(forKey: .from) {
			let containerView = transitionContext.containerView
			
			containerView.addSubview(fromView)
			fromView.frame.origin = .zero
			
			UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
				fromView.frame.origin = CGPoint(x: fromView.frame.width, y: 0)
			}, completion: { _ in
				fromView.removeFromSuperview()
				transitionContext.completeTransition(true)
			})
		}
		
		if let toView = transitionContext.view(forKey: .to) {
			let containerView = transitionContext.containerView
			containerView.addSubview(toView)
			toView.frame = containerView.frame
			toView.frame.origin = CGPoint(x: containerView.frame.width, y: 0)
			
			UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
				toView.frame.origin = CGPoint(x: 0, y: 0)
			}, completion: { _ in
				transitionContext.completeTransition(true)
			})
		}
	}
}

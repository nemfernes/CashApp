//
//  DarkerPresentationController.swift
//  IOSScanner-UI
//
//  Created by Artie on 27.03.2023.
//

import UIKit

class DarkerPresentationController: UIPresentationController {
	
	// MARK: - Override methods
	
	override func presentationTransitionWillBegin() {
		containerView?.backgroundColor = UIColor.black.withAlphaComponent(0)
		
		presentedView?.frame = frameOfPresentedViewInContainerView
		containerView?.addSubview(presentedViewController.view)
		
		presentingViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.containerView?.backgroundColor = UIColor.color151718
		}, completion: nil)
	}
	
	override func presentationTransitionDidEnd(_ completed: Bool) {
		super.presentationTransitionDidEnd(completed)
	}
	
	override func dismissalTransitionWillBegin() {
		presentingViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
			self.containerView?.backgroundColor = UIColor.black.withAlphaComponent(0)
		}, completion: nil)
	}
	
	override func dismissalTransitionDidEnd(_ completed: Bool) {
		super.dismissalTransitionDidEnd(completed)
	}
}

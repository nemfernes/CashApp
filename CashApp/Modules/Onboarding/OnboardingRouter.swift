//
//  OnboardingRouter.swift
//  AI Logo Generator
//
//  Created by Oleksii on 28.07.2025.
//

import UIKit

public class OnboardingRouter: Router {
	func toPrescreen() {
//		openPrescreen(transition: RootTransition(window: AppDelegate.window!), router: PrescreenRouter.self)
	}
	
	func toPremium(delegate: PremiumControllerDelegate, placement: AdaptyPlacement, containerView: UIView) {
		openPremium(delegate: delegate, placement: placement, transition: ChildTransition(containerView: containerView, rootViewController: viewController))
	}

}

extension OnboardingRouter: CustomPremiumRoute { }
//extension OnboardingRouter: PrescreenRoute { }

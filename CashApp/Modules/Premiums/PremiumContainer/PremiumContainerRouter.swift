//
//  PremiumContainerRouter.swift
//  AI Logo Generator
//
//  Created by Oleksii on 29.07.2025.
//

import UIKit

public class PremiumContainerRouter: Router {
	
	public func setPremium(placement: AdaptyPlacement, delegate: PremiumControllerDelegate) {
		openPremium(delegate: delegate, placement: placement, transition: ChildTransition(containerView: viewController?.view, rootViewController: viewController))
	}
}

extension PremiumContainerRouter: CustomPremiumRoute { }

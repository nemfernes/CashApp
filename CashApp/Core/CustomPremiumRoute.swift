//
//  CustomPremiumRoute.swift
//  VideoToMp3
//
//  Created by Oleksii on 24.07.2025.
//
import UIKit

public protocol CustomPremiumRoute {
	func openPremium(delegate: PremiumControllerDelegate, placement: AdaptyPlacement, transition: TransitionProtocol)
}
public extension CustomPremiumRoute {
	func openPremium(delegate: PremiumControllerDelegate, placement: AdaptyPlacement, transition: TransitionProtocol) {
		let paywallName: String? = AdaptyService.shared.getRemoteValue(placement: placement, key: .paywallName)
		let paywall: Paywall = .init(rawValue: paywallName ?? "") ?? .getPaywall(placement: placement)
		switch paywall {
		case .commonPremium:
			initCommonPremium(delegate: delegate, adaptyPlacement: placement, transition: transition, router: CommonPremiumRouter.self)
		}
		
	}
}

public enum Paywall: String {
	case commonPremium = "common"

	static func getPaywall(placement: AdaptyPlacement) -> Paywall {
		switch placement {
			case .main:
			return .commonPremium
		case .onboarding:
			return .commonPremium
		}
	}
}
public protocol PremiumControllerDelegate: AnyObject {
	func closePremium()
}

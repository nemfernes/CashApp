//
//  PremiumContainerViewController.swift
//  AI Logo Generator
//
//  Created by Oleksii on 29.07.2025.
//

import UIKit

final class PremiumContainerViewController<Router: PremiumContainerRouter>: ViewController<PremiumContainerView, Router>, PremiumControllerDelegate {
	
	// MARK: - Properties
	private var closeCompletion: (() -> Void)?
	private var adaptyPlacement: AdaptyPlacement

	// MARK: - Life cycle
	init(closeCompletion: (() -> Void)?, adaptyPlacement: AdaptyPlacement) {
		self.closeCompletion = closeCompletion
		self.adaptyPlacement = adaptyPlacement
		super.init()
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		AdaptyService.shared.logPaywallOpen(placement: adaptyPlacement)
		router.setPremium(placement: adaptyPlacement, delegate: self)
	}
	
	func closePremium() {
		router.close(closeCompletion)
	}
}

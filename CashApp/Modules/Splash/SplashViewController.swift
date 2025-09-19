//
//  SplashViewController.swift
//  AI Logo Generator
//
//  Created by Oleksii on 28.07.2025.
//

import UIKit

final class SplashViewController<Router: SplashRouter>: ViewController<SplashView, Router> {
	
	// MARK: - Properties
	
	// MARK: - Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		if Bundle.main.appStoreReceiptURL?.lastPathComponent != "sandboxReceipt" {
			SubscriptionService.shared.validatePurchases()
		}

		DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            if UserDefaults.showMain {
				self.router.toPrescreen()
			} else {
				self.router.toOnboarding()
			}
		})
	}
	
}

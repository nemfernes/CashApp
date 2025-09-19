//
//  SplashRouter.swift
//  AI Logo Generator
//
//  Created by Oleksii on 28.07.2025.
//

import UIKit

public class SplashRouter: Router {
	func toPrescreen() {
		openPrescreen(transition: RootTransition(window: AppDelegate.window!), router: PrescreenRouter.self)
	}
	func toOnboarding() {
		openOnboarding(transition: RootTransition(window: AppDelegate.window!), router: OnboardingRouter.self)
	}

}

extension SplashRouter: PrescreenRoute { }
extension SplashRouter: OnboardingRoute { }

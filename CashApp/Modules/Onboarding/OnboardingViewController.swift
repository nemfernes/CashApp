//
//  OnboardingViewController.swift
//  AI Logo Generator
//
//  Created by Oleksii on 28.07.2025.
//

import UIKit

final class OnboardingViewController<Router: OnboardingRouter>: ViewController<OnboardingView, Router>, PremiumControllerDelegate {
	
	// MARK: - Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
        mainView.updateView(step: .first)
		setupActions()
	}
	
	// MARK: - Private methods

	private func setupActions() {
		mainView.continueAction = { [weak self] step in
			guard let self else { return }
            switch step {
            case .first:
                mainView.updateView(step: .second)
            case .second:
                mainView.updateView(step: .third)
            case .third:
                router?.toPremium(delegate: self, placement: .onboarding, containerView: mainView)
            }
		}
	}
	
	func closePremium() {
        UserDefaults.showMain = true
		router.toPrescreen()
	}

}

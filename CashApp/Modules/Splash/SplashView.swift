//
//  SplashView.swift
//  AI Logo Generator
//
//  Created by Oleksii on 28.07.2025.
//

import UIKit

final class SplashView: UIView {
	
	// MARK: - Outlets
	@IBOutlet private var animationView: MyAnimationView! {
		didSet {
			animationView.backgroundColor = .clear
			animationView.configAnimation(with: .splash, loopMode: .loop, speed: 0.7)
		}
	}
		
	// MARK: - Life cycle
	override func layoutSubviews() {
		super.layoutSubviews()
	}
	
	// MARK: - Private methods
	private func defaultMethod() {
		
	}
	
	// MARK: - Objc methods
}

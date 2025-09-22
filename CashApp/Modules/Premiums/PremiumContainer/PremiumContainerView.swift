//
//  PremiumContainerView.swift
//  AI Logo Generator
//
//  Created by Oleksii on 29.07.2025.
//

import UIKit

final class PremiumContainerView: UIView {
	
	// MARK: - Outlets
	@IBOutlet private var outlet: UIView!
	
	// MARK: - Actions
	public var defaultAction: (() -> Void)?
	
	// MARK: - Life cycle
	override func layoutSubviews() {
		super.layoutSubviews()
	}
	
	// MARK: - Private methods
	private func defaultMethod() {
		
	}
	
	// MARK: - Objc methods
	@objc private func defaultDidTapped() {
		defaultAction?()
	}
	
}

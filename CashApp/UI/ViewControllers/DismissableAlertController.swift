//
//  DismissableAlertController.swift
//  Translator
//
//  Created by Oleksii on 19.02.2025.
//

import UIKit

class DismissableAlertController: UIAlertController {
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		addBackgroundDismissGesture()
	}
	
	private func addBackgroundDismissGesture() {
		guard let superview = view.superview else { return }
		
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
		
		superview.insertSubview(button, belowSubview: self.view)
		
		button.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			button.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
			button.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
			button.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
			button.topAnchor.constraint(equalTo: superview.topAnchor),
		])
	}
	
	@objc private func dismissAlert() {
		self.dismiss(animated: true, completion: nil)
	}
}

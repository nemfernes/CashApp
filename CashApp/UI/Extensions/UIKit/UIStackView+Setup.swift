//
//  UIStackView+Setup.swift
//  openVPN-UI
//
//  Created by Oleksii on 07.07.2024.
//

import UIKit

public extension UIStackView {
	
	func setup(axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment, distribution: UIStackView.Distribution, spacing: CGFloat? = nil) {
		self.distribution = distribution
		self.alignment = alignment
		self.axis = axis
		if let spacing {
			self.spacing = spacing
		}
	}
}

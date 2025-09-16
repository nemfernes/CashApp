//
//  UIView+Setup.swift
//  VoiceTranslatorIOS-UI
//
//  Created by Artie on 01.04.2024.
//

import UIKit

public extension UIView {
	
	func setup(color: UIColor = .white, cornerRadius: CGFloat = 0, maskToBounds: Bool = true) {
		self.backgroundColor = color
		self.layer.cornerRadius = cornerRadius
		self.layer.masksToBounds = maskToBounds
	}
	
}

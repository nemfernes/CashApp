//
//  UIButton+Setup.swift
//  VoiceTranslatorIOS-UI
//
//  Created by Artie on 01.04.2024.
//

import UIKit

public extension UIButton {
	
	func setup(title: String? = "", image: UIImage? = nil, textColor: UIColor? = nil, font: UIFont? = .systemFont(ofSize: 12), action: Action? = nil) {
		if let action {
			self.addAction(for: .touchUpInside, action: action)
		}
		if let title {
			setTitle(title, for: .normal)
		}
		if let textColor {
			setTitleColor(textColor, for: .normal)
		}
		titleLabel?.font = font
		setImage(image, for: .normal)
		if UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute) == .rightToLeft {
			imageView?.transform = CGAffineTransform(scaleX: -1, y: 1)
		}
	}
	
	func setupAttributed(attrTitle: NSAttributedString? = nil, image: UIImage? = nil, textColor: UIColor? = nil, font: UIFont? = .systemFont(ofSize: 12), action: Action? = nil) {
		setAttributedTitle(attrTitle, for: .normal)
		setup(title: nil, image: image, textColor: textColor, font: font, action: action)
	}

}

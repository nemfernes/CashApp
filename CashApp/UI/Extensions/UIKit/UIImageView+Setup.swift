//
//  UIImageView+Setup.swift
//  VoiceTranslatorIOS-UI
//
//  Created by Artie on 01.04.2024.
//

import UIKit

public extension UIImageView {
	
	func setup(image: UIImage? = nil, contentMode: UIView.ContentMode = .scaleAspectFit, allowArabic: Bool = true) {
		self.contentMode = contentMode
		
		self.image = image
		
		if allowArabic {
			if UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute) == .rightToLeft {
				self.transform = CGAffineTransform(scaleX: -1, y: 1)
			}
		}
	}
	
}

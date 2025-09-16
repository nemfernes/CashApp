//
//  UITextField+Setup.swift
//  IOSScanner-UI
//
//  Created by Artie on 08.09.2023.
//

import UIKit

public extension UITextField {
	
	func setup(placeholder: String, textAlignment: NSTextAlignment, textColor: UIColor, placeholderColor: UIColor, font: UIFont) {
		self.placeholder = ""
		self.textAlignment = textAlignment
		self.font = font
		self.textColor = textColor
		self.attributedPlaceholder = .init(string: placeholder, attributes: [.font: font, .foregroundColor: placeholderColor])
	}
}

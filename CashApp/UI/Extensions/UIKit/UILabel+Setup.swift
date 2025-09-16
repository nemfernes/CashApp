//
//  UILabel+Setup.swift
//  IOSScanner-UI
//
//  Created by Artie on 08.09.2023.
//

import UIKit

public extension UILabel {
    
    func setup(
        text: String = "",
        textColor: UIColor = .white,
        font: UIFont = .systemFont(ofSize: 12),
        textAlignment: NSTextAlignment = .center,
        adjustWidth: Bool = true,
        numberOfLines: Int = 1,
        letterSpacing: CGFloat = 0,
        lineSpacing: CGFloat = 0
    ) {
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.adjustsFontSizeToFitWidth = adjustWidth
        self.minimumScaleFactor = 0.5
        self.numberOfLines = numberOfLines
        self.lineBreakMode = .byWordWrapping
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = textAlignment
        paragraphStyle.lineBreakMode = lineBreakMode
        
        
        let attributes: [NSAttributedString.Key: Any] = [
            .kern: letterSpacing,
            .paragraphStyle: paragraphStyle,
            .foregroundColor: textColor,
            .font: font
        ]
        
        let attributedText = NSAttributedString(string: text, attributes: attributes)
        self.attributedText = attributedText
        if UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute) == .rightToLeft {
            switch self.textAlignment {
            case .left:
                self.textAlignment = .right
            case .right:
                self.textAlignment = .left
            default:
                break
            }
        }
    }
    
    
}

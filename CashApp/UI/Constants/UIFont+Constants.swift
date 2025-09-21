//
//  UIFont+Constants.swift
//  IOSScanner-UI
//
//  Created by Oleksii Yerko on 27.03.2023.
//

import UIKit

private extension UIFont {
    enum FontFamily: String {
        case urbanist = "Urbanist"
    }
    
    enum FontStyle: String {
        case black = "Black"
        case blackItalic = "BlackItalic"
        case bold = "Bold"
        case boldItalic = "BoldItalic"
        case extraBold = "ExtraBold"
        case extraBoldItalic = "ExtraBoldItalic"
        case extraLight = "ExtraLight"
        case extraLightItalic = "ExtraLightItalic"
        case italic = "Italic"
        case light = "Light"
        case lightItalic = "LightItalic"
        case medium = "Medium"
        case mediumItalic = "MediumItalic"
        case regular = "Regular"
        case semiBold = "SemiBold"
        case semiBoldItalic = "SemiBoldItalic"
        case thin = "Thin"
        case thinItalic = "ThinItalic"
    }
    
    static func getFont(size: CGFloat, family: FontFamily, style: FontStyle) -> UIFont? {
        let name = "\(family.rawValue)-\(style.rawValue)"
        return UIFont(name: name, size: size)
    }
}

public extension UIFont {
    
    // MARK: - Urbanist SemiBold
    static var urbanistSemiBold44: UIFont! { .getFont(size: 44, family: .urbanist, style: .semiBold) }
    static var urbanistSemiBold36: UIFont! { .getFont(size: 36, family: .urbanist, style: .semiBold) }
    static var urbanistSemiBold28: UIFont! { .getFont(size: 28, family: .urbanist, style: .semiBold) }
    static var urbanistSemiBold24: UIFont! { .getFont(size: 24, family: .urbanist, style: .semiBold) }
    static var urbanistSemiBold20: UIFont! { .getFont(size: 20, family: .urbanist, style: .semiBold) }
    static var urbanistSemiBold16: UIFont! { .getFont(size: 16, family: .urbanist, style: .semiBold) }
    static var urbanistSemiBold14: UIFont! { .getFont(size: 14, family: .urbanist, style: .semiBold) }
    static var urbanistSemiBold10: UIFont! { .getFont(size: 10, family: .urbanist, style: .semiBold) }
    
    static var urbanistBold36: UIFont! { .getFont(size: 36, family: .urbanist, style: .bold) }
    static var urbanistBold28: UIFont! { .getFont(size: 28, family: .urbanist, style: .bold) }
    static var urbanistBold24: UIFont! { .getFont(size: 24, family: .urbanist, style: .bold) }
    static var urbanistBold14: UIFont! { .getFont(size: 14, family: .urbanist, style: .bold) }
    static var urbanistBold10: UIFont! { .getFont(size: 10, family: .urbanist, style: .bold) }
    
    // MARK: - Urbanist Medium
    static var urbanistMedium28: UIFont! { .getFont(size: 28, family: .urbanist, style: .medium) }
    static var urbanistMedium24: UIFont! { .getFont(size: 24, family: .urbanist, style: .medium) }
    static var urbanistMedium20: UIFont! { .getFont(size: 20, family: .urbanist, style: .medium) }
    static var urbanistMedium18: UIFont! { .getFont(size: 18, family: .urbanist, style: .medium) }
    static var urbanistMedium16: UIFont! { .getFont(size: 16, family: .urbanist, style: .medium) }
    static var urbanistMedium14: UIFont! { .getFont(size: 14, family: .urbanist, style: .medium) }
    
    // MARK: - Urbanist Regular
    static var urbanistRegular20: UIFont! { .getFont(size: 20, family: .urbanist, style: .regular) }
    static var urbanistRegular18: UIFont! { .getFont(size: 18, family: .urbanist, style: .regular) }
    static var urbanistRegular16: UIFont! { .getFont(size: 16, family: .urbanist, style: .regular) }
    static var urbanistRegular14: UIFont! { .getFont(size: 14, family: .urbanist, style: .regular) }
    static var urbanistRegular12: UIFont! { .getFont(size: 12, family: .urbanist, style: .regular) }
}

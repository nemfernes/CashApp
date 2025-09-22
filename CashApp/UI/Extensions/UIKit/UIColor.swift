//
//  UIColor.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import UIKit

extension UIColor {
    enum Asset: String {
        case color_1BC04D
        case color_1F1F21
        case color_2B2D2E
        case color_2B6CF0
        case color_99989B
        case color_151718
        case color_CF212C
        case color_DB841D
        
    }
    
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }

    static func asset(_ name: Asset,
                      in bundle: Bundle = .main,
                      compatibleWith traitCollection: UITraitCollection? = nil) -> UIColor {
        UIColor(named: name.rawValue, in: bundle, compatibleWith: traitCollection)
        ?? .clear
    }
    
    static func randomGoalColor() -> UIColor {
          
            let colors: [UIColor] = [
                UIColor(red: 0.95, green: 0.47, blue: 0.47, alpha: 1),
                UIColor(red: 0.47, green: 0.76, blue: 0.95, alpha: 1),
                UIColor(red: 0.47, green: 0.95, blue: 0.65, alpha: 1),
                UIColor(red: 0.95, green: 0.88, blue: 0.47, alpha: 1),
                UIColor(red: 0.73, green: 0.58, blue: 0.95, alpha: 1),
                UIColor(red: 0.95, green: 0.64, blue: 0.47, alpha: 1)
            ]
            return colors.randomElement() ?? .systemBlue
        }
    
    func toHexString() -> String {
        guard let components = cgColor.components else { return "#000000" }

        let r: CGFloat
        let g: CGFloat
        let b: CGFloat

        if components.count >= 3 {
            r = components[0]
            g = components[1]
            b = components[2]
        } else {
            // grayscale
            r = components[0]
            g = components[0]
            b = components[0]
        }

        return String(format: "#%02lX%02lX%02lX",
                      Int(r * 255),
                      Int(g * 255),
                      Int(b * 255))
    }


}


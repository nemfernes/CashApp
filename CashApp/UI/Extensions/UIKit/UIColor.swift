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

    static func asset(_ name: Asset,
                      in bundle: Bundle = .main,
                      compatibleWith traitCollection: UITraitCollection? = nil) -> UIColor {
        UIColor(named: name.rawValue, in: bundle, compatibleWith: traitCollection)
        ?? .clear
    }
}

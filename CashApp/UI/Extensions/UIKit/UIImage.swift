//
//  UIImage.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import UIKit

extension UIImage {
    enum Asset: String {
        case circleCheckIc
        case onboard1Image
        case onboard2Image
        case onboard3Image
        case premiumBackgroundImage
        case closeIc
    }
    
    static func asset(_ name: Asset) -> UIImage {
        return UIImage(named: name.rawValue) ?? UIImage()
    }
}

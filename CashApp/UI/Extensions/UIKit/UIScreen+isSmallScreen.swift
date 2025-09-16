//
//  UIScreen+isSmallScreen.swift
//  openVPN-UI
//
//  Created by Oleksii on 10.07.2024.
//

import UIKit

public extension UIScreen {
	static func isSmallScreen() -> Bool {
		let size = UIScreen.main.bounds.size
		let width = min(size.width, size.height)
//		let height = max(size.width, size.height)
//		let scale = UIScreen.main.scale
//		let nativeWidth = width * scale
//		let nativeHeight = height * scale
//		let smallScreenSizes: [(width: CGFloat, height: CGFloat)] = [
//			(750, 1334),   // iPhone 6, 6s, 7, 8, SE 2/3 (4.7")
//			(1242, 2208),  // iPhone 6+/6s+/7+/8+ (5.5")
//			(1080, 2340),  // iPhone 12 mini, 13 mini (5.4")
//			(1136, 640)    // iPhone 5, 5s, SE 1 (4.0")
//		]

		return width <= 375
	}
}

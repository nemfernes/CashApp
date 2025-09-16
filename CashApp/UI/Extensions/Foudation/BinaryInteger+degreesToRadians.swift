//
//  BinaryInteger+degreesToRadians.swift
//  IOSScanner-UI
//
//  Created by Artie on 27.03.2023.
//

import UIKit

public extension BinaryInteger {
	var degreesToRadians: CGFloat { CGFloat(self) * .pi / 180 }
}

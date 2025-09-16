//
//  FloatingPoint+degreesToRadians.swift
//  IOSScanner-UI
//
//  Created by Artie on 27.03.2023.
//

import Foundation

public extension FloatingPoint {
	var degreesToRadians: Self { self * .pi / 180 }
}

//
//  NSObject+ClassName.swift
//  IOSScanner-UI
//
//  Created by Artie on 27.03.2023.
//

import Foundation

public extension NSObject {
	static var className: String {
		return try! String(describing: self).substringMatches(regex: "[[:word:]]+").first!
	}
}

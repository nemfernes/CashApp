//
//  Reusable.swift
//  IOSScanner-UI
//
//  Created by Artie on 27.03.2023.
//

import Foundation

public protocol Reusable {
	static var reuseIdentifier: String { get }
	func prepareForReuse()
}

public extension Reusable where Self: AnyObject {
	static var reuseIdentifier: String {
		return try! String(describing: self).substringMatches(regex: "[[:word:]]+").first!
	}
	
	func prepareForReuse() {}
}

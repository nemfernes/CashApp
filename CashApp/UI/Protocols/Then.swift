//
//  Then.swift
//  IOSScanner-UI
//
//  Created by Artie on 27.03.2023.
//

import Foundation
import CoreGraphics
#if os(iOS) || os(tvOS)
import UIKit.UIGeometry
#endif

public protocol Then {}

extension Then where Self: Any {
	
	public func with(_ block: (inout Self) throws -> Void) rethrows -> Self {
		var copy = self
		try block(&copy)
		return copy
	}
	
	public func `do`(_ block: (Self) throws -> Void) rethrows {
		try block(self)
	}
	
}

extension Then where Self: AnyObject {
	
	public func then(_ block: (Self) throws -> Void) rethrows -> Self {
		try block(self)
		return self
	}
	
}

extension NSObject: Then {}

extension CGPoint: Then {}
extension CGRect: Then {}
extension CGSize: Then {}
extension CGVector: Then {}
extension CGMutablePath: Then {}

#if os(iOS) || os(tvOS)
extension UIEdgeInsets: Then {}
extension UIOffset: Then {}
extension UIRectEdge: Then {}
#endif

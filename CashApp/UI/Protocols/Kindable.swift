//
//  Kindable.swift
//  IOSScanner-UI
//
//  Created by Artie on 27.03.2023.
//

import Foundation

public protocol Kindable: Reusable {
	static var kind: String { get }
}

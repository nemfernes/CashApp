//
//  URL+Constraints.swift
//  IOSScanner-UI
//
//  Created by Artie on 27.03.2023.
//

import Foundation

public extension URL {
	func getSong(by index: Int) -> URL! {
		return URL(fileURLWithPath: Bundle.main.path(forResource: "\(index)", ofType: "mp3")!)
	}
}

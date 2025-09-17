//
//	Localizable.swift
//	Translator-UI
//
//	Created by Artie on 01.08.2022.
//

import Foundation

public protocol Localizable: RawRepresentable, CustomStringConvertible where RawValue == String {
	var tableName: String? { get }
	var bundle: Bundle { get }
	var localized: String { get }
}

public extension Localizable {
	var localized: String {
		return NSLocalizedString(rawValue, tableName: tableName, bundle: bundle, value: "", comment: "").replacingOccurrences(of: " \n ", with: "\n")
	}
}

public extension Localizable {
	var description: String {
		return localized
	}
}

public extension Localizable {
	var bundle: Bundle { return Bundle.main }
}

public enum LS {}

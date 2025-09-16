//
//  String+FormatColored.swift
//  VoiceTranslatorIOS-UI
//
//  Created by Artie on 11.04.2024.
//

import Foundation
import UIKit

public extension String {
    
    var containsLetter: Bool {
            return self.rangeOfCharacter(from: .letters) != nil
        }
    
    var trimmedLeadingSpaces: String {
            return self.replacingOccurrences(of: #"^\s+"#, with: "", options: .regularExpression)
        }
    
	func getColoredText(key: String, color: UIColor) -> NSAttributedString? {

		var str = self
		let key1 = "<\(key)>"
		let key2 = "</\(key)>"

		guard let startPoint = str.endIndex(of: key1) else { return nil }
		guard let endPoint = str.index(of: key2) else { return nil }
		let rangeStr = String(str[startPoint..<endPoint])
		str = str.replacingOccurrences(of: key1, with: "")
		str = str.replacingOccurrences(of: key2, with: "")

		let range = (str as NSString).range(of: rangeStr)

		let mutableAttributedString = NSMutableAttributedString.init(string: str)
		mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
		return mutableAttributedString
	}
	
	func getFontText(key: String, font: UIFont) -> NSAttributedString? {

		var str = self
		let key1 = "<\(key)>"
		let key2 = "</\(key)>"

		guard let startPoint = str.endIndex(of: key1) else { return nil }
		guard let endPoint = str.index(of: key2) else { return nil }
		let rangeStr = String(str[startPoint..<endPoint])
		str = str.replacingOccurrences(of: key1, with: "")
		str = str.replacingOccurrences(of: key2, with: "")

		let range = (str as NSString).range(of: rangeStr)

		let mutableAttributedString = NSMutableAttributedString.init(string: str)
		mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: font, range: range)
		return mutableAttributedString
	}

}

extension StringProtocol {
	func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
		range(of: string, options: options)?.lowerBound
	}
	func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
		range(of: string, options: options)?.upperBound
	}
	func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
		ranges(of: string, options: options).map(\.lowerBound)
	}
	func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
		var result: [Range<Index>] = []
		var startIndex = self.startIndex
		while startIndex < endIndex,
			let range = self[startIndex...]
				.range(of: string, options: options) {
				result.append(range)
				startIndex = range.lowerBound < range.upperBound ? range.upperBound :
					index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
		}
		return result
	}
}

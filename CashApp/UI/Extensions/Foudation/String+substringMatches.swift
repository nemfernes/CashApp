//
//  String+substringMatches.swift
//  IOSScanner-UI
//
//  Created by Artie on 27.03.2023.
//

import Foundation
import UIKit

extension String {
    
    func setLastWordToCaps() -> String {
        let words = self.split(separator: " ")
        guard !words.isEmpty else {
            return self
        }
        let lastWord = words.last?.uppercased() ?? ""
        return self.replacingOccurrences(of: words.last!, with: lastWord)
    }
    
	func substringMatches(regex: String) throws -> [String] {
		let regex = try NSRegularExpression(pattern: regex, options: [])
		let range = NSMakeRange(0, (self as NSString).length)
		let matches = regex.matches(in: self, options: [], range: range)
		
		let string = self as NSString
		var substrings = [String]()
		for match in matches {
			substrings.append(string.substring(with: match.range) as String)
		}
		
		return substrings
	}
    
    public func getStrikethroughStyle() -> NSMutableAttributedString {
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .strikethroughStyle: NSUnderlineStyle.single.rawValue
        ]
        return NSMutableAttributedString(
            string: self,
            attributes: yourAttributes
        )
    }
    
    func capitalizingOnlyFirstWord() -> String {
        let components = self.split(separator: " ", omittingEmptySubsequences: true)
               guard let firstWord = components.first else { return "" }

               let rest = components.dropFirst().map { $0.lowercased() }
               return ([String(firstWord)] + rest).joined(separator: " ")
       }
}

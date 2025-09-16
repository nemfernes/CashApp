//
//  String+html2String.swift
//  IOSScanner-UI
//
//  Created by Artie on 27.03.2023.
//

import Foundation
import UIKit

public extension String {
	func getUnderline() -> NSMutableAttributedString {
		let yourAttributes: [NSAttributedString.Key: Any] = [
			.underlineStyle: NSUnderlineStyle.single.rawValue
		]
		return NSMutableAttributedString(
			string: self,
			attributes: yourAttributes
		)
	}

	var htmlToAttributedString: NSAttributedString? {
		guard
			let data = self.data(using: .utf8)
		else { return nil }
		do {
			return try NSAttributedString(data: data, options: [
				NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
				NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
			], documentAttributes: nil)
		} catch let error as NSError {
			print(error.localizedDescription)
			return  nil
		}
	}
	
	var htmlToString: String {
		return htmlToAttributedString?.string ?? ""
	}
}

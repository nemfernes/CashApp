//
//  UIImage+Init.swift
//  IOSScanner-UI
//
//  Created by Artie on 23.06.2023.
//

import UIKit

public extension UIImage {
	
	convenience init?(key: String, scale: CGFloat = 1.0) {
		let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
		let url = documentsDirectory.appendingPathComponent(key)
		
		do {
			let data = try Data(contentsOf: url)
			self.init(data: data, scale: scale)
		} catch {
			print("-- Error: \(error)")
			return nil
		}
	}
	
	convenience init?(size: CGSize = CGSize(width: 1, height: 1)) {
		let rect = CGRect(origin: .zero, size: size)
		UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
		UIColor.clear.setFill()
		UIRectFill(rect)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		guard let cgImage = image?.cgImage else { return nil }
		self.init(cgImage: cgImage)
	}
	
	convenience init(view: UIView) {
		UIGraphicsBeginImageContext(view.frame.size)
		view.layer.render(in:UIGraphicsGetCurrentContext()!)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		self.init(cgImage: image!.cgImage!)
	}
}

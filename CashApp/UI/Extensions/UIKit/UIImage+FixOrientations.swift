//
//  UIImage+FixOrientations.swift
//  IOSScanner-UI
//
//  Created by Artie on 05.07.2023.
//

import UIKit

extension UIImage {
	func fixedOrientation() -> UIImage {
		guard imageOrientation != .up else { return self }
		
		var transform = CGAffineTransform.identity
		
		switch imageOrientation {
			case .down, .downMirrored:
				transform = transform.translatedBy(x: size.width, y: size.height).rotated(by: .pi)
			case .left, .leftMirrored:
				transform = transform.translatedBy(x: size.width, y: 0).rotated(by: .pi / 2)
			case .right, .rightMirrored:
				transform = transform.translatedBy(x: 0, y: size.height).rotated(by: -.pi / 2)
			default:
				break
		}
		
		switch imageOrientation {
			case .upMirrored, .downMirrored:
				transform = transform.translatedBy(x: size.width, y: 0).scaledBy(x: -1, y: 1)
			case .leftMirrored, .rightMirrored:
				transform = transform.translatedBy(x: size.height, y: 0).scaledBy(x: -1, y: 1)
			default:
				break
		}
		
		guard let cgImage = self.cgImage, let colorSpace = cgImage.colorSpace,
			  let context = CGContext(
				data: nil,
				width: Int(size.width),
				height: Int(size.height),
				bitsPerComponent: cgImage.bitsPerComponent,
				bytesPerRow: 0,
				space: colorSpace,
				bitmapInfo: cgImage.bitmapInfo.rawValue
			  ) else {
			return self
		}
		
		context.concatenate(transform)
		
		let rect: CGRect
		switch imageOrientation {
			case .left, .leftMirrored, .right, .rightMirrored:
				rect = CGRect(x: 0, y: 0, width: size.height, height: size.width)
			default:
				rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		}
		
		context.draw(cgImage, in: rect)
		
		guard let newCGImage = context.makeImage() else { return self }
		return UIImage(cgImage: newCGImage)
	}
}

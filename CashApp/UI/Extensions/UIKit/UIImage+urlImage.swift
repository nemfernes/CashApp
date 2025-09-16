//
//  UIImage+urlImage.swift
//  IOSScanner-UI
//
//  Created by Artie on 05.07.2023.
//

import UIKit

public extension UIImageView {
	func imageFromUrl(urlString: String) {
		if let url = URL(string: urlString) {
			let task = URLSession.shared.dataTask(with: url) { data, response, error in
				guard let data = data, error == nil else { return }
				
				DispatchQueue.main.async { /// execute on main thread
				
					let img = UIImage(data: data)
					self.image = img
				}
			}
			task.resume()
		}
	}
}

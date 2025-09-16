//
//  UITableView+Dequeue.swift
//  IOSScanner-UI
//
//  Created by Artie on 27.03.2023.
//

import UIKit

public extension UITableView {
	func dequeue<T: UITableViewCell & Reusable>(with identifier: String = T.reuseIdentifier, for indexPath: IndexPath) -> T {
		return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
	}
	
	func dequeue<T: UITableViewHeaderFooterView & Reusable>(with identifier: String = T.reuseIdentifier) -> T {
		return dequeueReusableHeaderFooterView(withIdentifier: identifier) as! T
	}
}

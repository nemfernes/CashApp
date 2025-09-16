//
//  UITableView+Register.swift
//  IOSScanner-UI
//
//  Created by Artie on 27.03.2023.
//

import UIKit

public extension UITableView {
	func register<T: UITableViewCell & Reusable>(_ aClass: T.Type, for identifier: String = T.reuseIdentifier) {
		if let aClass = aClass as? NibRepresentable.Type {
			register(aClass.nib, forCellReuseIdentifier: identifier)
		} else {
			register(aClass, forCellReuseIdentifier: identifier)
		}
	}
	
	func register<T: UITableViewHeaderFooterView & Reusable>(_ aClass: T.Type, for identifier: String = T.reuseIdentifier) {
		if let aClass = aClass as? NibRepresentable.Type {
			register(aClass.nib, forHeaderFooterViewReuseIdentifier: identifier)
		} else {
			register(aClass, forHeaderFooterViewReuseIdentifier: identifier)
		}
	}
}

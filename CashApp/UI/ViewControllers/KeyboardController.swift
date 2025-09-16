//
//  KeyboardController.swift
//  TranslatorApp-UI
//
//  Created by Oleksandr Yakobshe on 23.04.2023.
//

import UIKit

public protocol KeyboardControllerDelegate: AnyObject {
	func keyboardDidShow(height: CGFloat)
	func keyboardDidHide()
}

open class KeyboardController: NSObject {
	// MARK: - Public properties
	
	open weak var delegate: KeyboardControllerDelegate?
	open weak var scrollView: UIScrollView? {
		didSet { defaultInset = scrollView?.contentInset ?? .zero }
	}
	
	// MARK: - Private properties
	
	private var defaultInset: UIEdgeInsets = .zero
	
	// MARK: - Inits
	
	public override init() {
		super.init()
		let sel = #selector(keyboardNotification(_:))
		let center = NotificationCenter.default
		center.addObserver(self, selector: sel, name: UIView.keyboardWillShowNotification, object: nil)
		center.addObserver(self, selector: sel, name: UIView.keyboardWillHideNotification, object: nil)
		center.addObserver(self, selector: sel, name: UIView.keyboardDidShowNotification, object: nil)
		center.addObserver(self, selector: sel, name: UIView.keyboardDidHideNotification, object: nil)
	}
	
//	required init?(coder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//	}
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
	
	// MARK: - Actions
	// MARK: - Actions
	func keyboardWillShow(_ userInfo: [AnyHashable : Any]) {
		if let keyboardFrame: NSValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
			let keyboardRectangle = keyboardFrame.cgRectValue
			let keyboardHeight = keyboardRectangle.height
			let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
			let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
			UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: curve), animations: {
				self.delegate?.keyboardDidShow(height: keyboardHeight)
			}, completion: nil)
		}
	}
	func keyboardWillHide(_ userInfo: [AnyHashable : Any]) {
		if let keyboardFrame: NSValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
			let keyboardRectangle = keyboardFrame.cgRectValue
			let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
			let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
			UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: curve), animations: {
				self.delegate?.keyboardDidHide()
			}, completion: nil)
		}
	}

	@objc private func keyboardNotification(_ notification: Notification) {
		guard let userInfo = notification.userInfo else { return }
		
		var inset = scrollView?.contentInset ?? .zero
		
		switch notification.name {
		case UIView.keyboardWillShowNotification:
			keyboardWillShow(userInfo)
			let frame = (userInfo[UIView.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
			let offset = (scrollView?.window?.frame.height ?? 0) - (scrollView?.frame.maxY ?? 0)
			inset.bottom = frame.height - offset
		case UIView.keyboardWillHideNotification:
			keyboardWillHide(userInfo)
			inset = defaultInset
		case UIView.keyboardDidShowNotification:
			keyboardWillShow(userInfo)
		case UIView.keyboardDidHideNotification:
			keyboardWillHide(userInfo)
		default:
			return
		}
		
		scrollView?.contentInset = inset
	}
}

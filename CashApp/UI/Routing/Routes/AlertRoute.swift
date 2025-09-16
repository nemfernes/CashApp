//
//  AlertRoute.swift
//  IOSScanner-UI
//
//  Created by Artie on 27.03.2023.
//

import Foundation
import UIKit

public protocol AlertRoute where Self: RouterProtocol {
//	func openDoneAlert(title: String?, message: String)
//	func openErrorAlert(completion: (() -> Void)?)
}

public extension AlertRoute {
//	func openDoneAlert(title: String? = nil, message: String) {
//				let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//				
//				let okAction = UIAlertAction(title: LS.Common.Strings.ok.localized, style: .default)
//				
//				alertController.addAction(okAction)
//				
//				viewController?.present(alertController, animated: true)
//	}
    
//	func openErrorAlert(completion: (() -> Void)?) {
//		let alertController = UIAlertController(title: LS.Common.Strings.oops.localized, message: LS.Common.Strings.somethingWentWrong.localized, preferredStyle: .alert)
//				
//		let okAction = UIAlertAction(title: LS.Common.Strings.ok.localized, style: .default, handler: { [weak self] _ in
//			guard let self else { return }
//			completion?()
//		})
//				
//				alertController.addAction(okAction)
//				
//				viewController?.present(alertController, animated: true)
//	}

	
}

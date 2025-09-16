//
//  SafariRoute.swift
//  IOSScanner-UI
//
//  Created by Artie on 27.03.2023.
//

import Foundation
import SafariServices

public protocol SafariRoute where Self: RouterProtocol {
	func openSafari(url: String)
}

public extension SafariRoute {
	func openSafari(url: String) {
		guard let url = URL(string: url) else { return }
		let safariController = SFSafariViewController(url: url)
		let transition = ModalTransition(fromViewController: viewController)
		transition.open(safariController, animated: true, completion: nil)
	}
}

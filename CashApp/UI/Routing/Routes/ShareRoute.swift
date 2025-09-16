//
//  ShareRoute.swift
//  IOSScanner-UI
//
//  Created by Artie on 20.06.2023.
//

import UIKit

public protocol ShareRoute where Self: RouterProtocol {
  func openShareText(_ text: String, completion: Transition.Completion?)
	func openShareLink(_ link: URL, completion: Transition.Completion?)

}

public extension ShareRoute {
  func openShareText(_ text: String, completion: Transition.Completion?) {
		let textShare = text
		let textToShare: [Any] = [text]
		let activityViewController = UIActivityViewController(activityItems: textToShare , applicationActivities: nil)
		activityViewController.popoverPresentationController?.sourceView = viewController?.view
		let transition = ModalTransition(fromViewController: viewController)
		transition.open(activityViewController, animated: true, completion: completion)
  }
	
	func openShareLink(_ link: URL, completion: Transition.Completion?) {
		  let textToShare: [Any] = [link]
		  let activityViewController = UIActivityViewController(activityItems: textToShare , applicationActivities: nil)
		  activityViewController.popoverPresentationController?.sourceView = viewController?.view
		  let transition = ModalTransition(fromViewController: viewController)
		  transition.open(activityViewController, animated: true, completion: completion)
	}
}

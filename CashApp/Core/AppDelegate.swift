//
//  AppDelegate.swift
//  AI Logo Generator
//
//  Created by Oleksii on 28.07.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	static var window: UIWindow?
	
	let rootRouter = RootRouter()

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
#if DEBUG
     //   UserDefaults.premium = false
#endif
		AdaptyService.shared.configure()
		SubscriptionService.shared.configure()
		let window = UIWindow(frame: UIScreen.main.bounds)
		window.rootViewController = UIStoryboard(name: "LaunchScreen", bundle: .main).instantiateInitialViewController()
		window.makeKeyAndVisible()
		AppDelegate.window = window
		rootRouter.configure(window: window)
		rootRouter.toSplash()

		return true
	}
}


//
//  RootRouter.swift
//  VideoToMp3
//
//  Created by Oleksii on 09.07.2025.
//


import UIKit

final class RootRouter: Router {
	
	public var rootTransition: TransitionProtocol?
	
	public func toSplash() {
		guard let rootTransition else { return }
		
		openSplash(transition: rootTransition, router: SplashRouter.self)
	}
	
	public func configure(window: UIWindow) {
		rootTransition = RootTransition(window: window)
	}
}

extension RootRouter: SplashRoute { }

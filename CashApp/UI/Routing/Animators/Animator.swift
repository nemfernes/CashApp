//
//  Animator.swift
//  IOSScanner-UI
//
//  Created by Artie on 27.03.2023.
//

import UIKit

public protocol Animator where Self: NSObject, Self: UIViewControllerAnimatedTransitioning {
	var isPresenting: Bool { get set }
}

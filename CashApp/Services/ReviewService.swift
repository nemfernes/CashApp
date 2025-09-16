//
//  ReviewService.swift
//  IOSScanner-Service
//
//  Created by Oleksii Yerko on 22.09.2023.
//


import StoreKit

public class ReviewService {
	
	public func requestReviewIfAppropriate() {
		if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
			DispatchQueue.main.async {
				SKStoreReviewController.requestReview(in: scene)
			}
		}
	  }

}

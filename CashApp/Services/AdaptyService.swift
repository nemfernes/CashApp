//
//  AdaptyService.swift
//  AI Logo Generator
//
//  Created by Oleksii on 29.07.2025.
//

import Foundation
import Adapty

public class AdaptyService {
	public static let shared = AdaptyService()
	
	private var paywalls: [AdaptyPlacement : AdaptyPaywall] = [:] {
		didSet {
			self.observer?()
		}
	}
	
	private var paywallsController: [AdaptyPlacement : AdaptyPaywall] = [:] {
		didSet {
			self.observer?()
		}
	}
	
	private var products: [AdaptyPlacement : [AdaptyPaywallProduct]] = [:]
	
	public var observer: (() -> Void)?

	public func configure() {
		Adapty.activate("public_live_UigB3VW8.glsAzBYc8retcyLgaSCB", observerMode: false, dispatchQueue: .main, { error in
			var cases = AdaptyPlacement.allCases
			cases.sort(by: { $0.priority < $1.priority })
			print(cases)
			for value in cases {
				Adapty.getPaywall(placementId: value.key, { result in
					switch result {
					case .success(let paywall):
						self.paywalls[value] = paywall
						self.fetchProductsForPaywall(placement: value)
					case .failure(_):
						break
					}
				})
			}
		})
	}
	
	public func setProfileValue(value: String, key: String) {
		do {
			var builder = try AdaptyProfileParameters.Builder()
				.with(customAttribute: value, forKey: key)
			Adapty.updateProfile(params: builder.build()) { [weak self] error in
				if error != nil {
					print("Error ADAPTYCLIENT.updateProfile \(key) \(value)")
				} else {
					print("OK ADAPTYCLIENT.updateProfile \(key) \(value)")
				}
			}
		} catch {
			print("Error ADAPTYCLIENT.setProfileValue \(key) \(value)")

		}

	}
	private func fetchProductsForPaywall(placement: AdaptyPlacement) {
		if let paywall = paywalls[placement] {
			Adapty.getPaywallProducts(paywall: paywall, { [weak self] result in
				guard let self else { return }
				switch result {
				case .success(let p):
					self.products[placement] = p
				case .failure(_):
					break
				}
			})
		}
	}
	
	public func hasPaywall(placement: AdaptyPlacement) -> Bool {
		return paywalls[placement] != nil
	}
	
	public func hasProductsForPaywall(placement: AdaptyPlacement, id: String) -> Bool {
		return products[placement]?.contains(where: {$0.vendorProductId == id}) ?? false
	}
	
	public func hasProductsForPaywall(placement: AdaptyPlacement) -> Bool {
		return products[placement]?.first != nil
	}
	public func getRemoteValue<Type>(placement: AdaptyPlacement, key: AdaptyRemoteKey) -> Type? {
			if let id = paywalls[placement]?.remoteConfig?[key.rawValue] as? Type {
				return id
			}
			return nil
		}

	public func getAbValue(placement: AdaptyPlacement) -> Int? {
		if let id = paywalls[placement]?.remoteConfig?["id"] as? Int {
			return id
		}
		return nil
	}
	public func getBoolValue(placement: AdaptyPlacement, key: String) -> Bool {
		if let id = paywalls[placement]?.remoteConfig?[key] as? Bool {
			return id
		}
		return false
	}

	public func logPaywallOpen(placement: AdaptyPlacement) {
		if let paywall = paywalls[placement] {
			Adapty.logShowPaywall(paywall)
		}
	}
	
	public func logOnboardingOpen(step: Int) {
		Adapty.logShowOnboarding(name: "onboarding_\(step)", screenName: nil, screenOrder: UInt(step))
	}

	public func updateAttribution(attribution: [AnyHashable: Any]) {
		Adapty.updateAttribution(attribution, source: .adjust)
	}
	public func buyProduct(placement: AdaptyPlacement, id: String, completion: ((SubscriptionResponse) -> Void)?) {
		if let product = products[placement]?.first(where: { $0.vendorProductId == id }) {
			Adapty.makePurchase(product: product) { result in
				switch result {
				case let .success(info):
                    UserDefaults.premium = true
					completion?(.success)
				case let .failure(error):
					print(error.localizedDescription, "Adapty error")
					switch error.adaptyErrorCode {
					case .paymentCancelled:
						completion?(.error(.purchaseCancelled))
					case .productRequestFailed, .serverError, .unknown, .productPurchaseFailed:
						completion?(.error(.needSwiftyStoreKit))
					default:
						completion?(.error(.failedToPurchase))
					}
					break
				}
			}
		} else {
			completion?(.error(.failedToPurchase))
		}
	}
	
	public func integrateFirebase(appInstanceId: String) {
		let builder = AdaptyProfileParameters.Builder()
			.with(firebaseAppInstanceId: appInstanceId)
		Adapty.updateProfile(params: builder.build()) { error in
			print("ERRORRR \(error)")
		}
	}
	
	public func integrateFacebook(id: String) {
		let builder = AdaptyProfileParameters.Builder()
			.with(facebookAnonymousId: id)
		
		Adapty.updateProfile(params: builder.build()) { error in
			print("ERRORRR ADAPTY FACEBOOK \(error)")
		}
	}
}

public enum AdaptyPlacement: CaseIterable {
	case main
	case onboarding
	
	var priority: Int {
		switch self {
		default:
			return 5
		}
	}
	var key: String {
		var isProd: Bool = Bundle.main.appStoreReceiptURL?.lastPathComponent != "sandboxReceipt"
#if DEBUG
		isProd = false
#endif
		if isProd {
			switch self {
			case .main:
				return "main"
			case .onboarding:
				return "onboarding"
			}
		} else {
			switch self {
			case .main:
				return "main"
			case .onboarding:
				return "onboarding"
			}
		}
	}
}


public enum AdaptyRemoteKey: String {
	case paywallName = "paywallName"
	case closeDelay = "closeDelay"
	case product = "product"

}

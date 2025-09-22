//
//  SubscriptionService.swift
//  AI Logo Generator
//
//  Created by Oleksii on 29.07.2025.
//


import Foundation
import SwiftyStoreKit
import StoreKit

public struct SubscriptionDiscount: Codable, Hashable {
	var price: Double
	public var localizedPrice: String
}

public struct MySubscription: Codable {
	public var id: String
	public var localizedPrice: String
	public var price: Double
	public var currency: String
	public var isTrial: Bool
	public var priceLocale: Locale
	public var duration: SubscriptionDuration
	public var trialPrice: String?
	
	public var priceForWeek: String {
		get {
			let price = (NSDecimalNumber(value: price) as Decimal) / Decimal(duration.getDays()) * 7
			let formatter = NumberFormatter()
			formatter.numberStyle = .currency
			formatter.locale = priceLocale
			return formatter.string(from: price as NSNumber) ?? "???$"
		}
	}
	
	public var priceForDay: String {
		get {
			let price = (NSDecimalNumber(value: price) as Decimal) / Decimal(duration.getDays())
			let formatter = NumberFormatter()
			formatter.numberStyle = .currency
			formatter.locale = priceLocale
			return formatter.string(from: price as NSNumber) ?? "???$"
		}
	}
	
	public var priceForYear: String {
		get {
			let price = (NSDecimalNumber(value: price) as Decimal) / Decimal(duration.getDays()) * 365
			let formatter = NumberFormatter()
			formatter.numberStyle = .currency
			formatter.locale = priceLocale
			return formatter.string(from: price as NSNumber) ?? "???$"
		}
	}
	
	public var priceForMonth: String {
		get {
			let price = (NSDecimalNumber(value: price) as Decimal) / Decimal(duration.getDays()) * 30
			let formatter = NumberFormatter()
			formatter.numberStyle = .currency
			formatter.locale = priceLocale
			return formatter.string(from: price as NSNumber) ?? "???$"
		}
	}
	
	public var priceForX2Price: String {
		get {
			let price = (NSDecimalNumber(value: price) as Decimal) * 2
			let formatter = NumberFormatter()
			formatter.numberStyle = .currency
			formatter.locale = priceLocale
			return formatter.string(from: price as NSNumber) ?? "???$"
		}
	}
	func fullPrice(for precentsOfDiscount: Double) -> String {
		let discountedPrice = price
		
		let discountValue = precentsOfDiscount
		let discountedPrecents = (100 - discountValue)
		let fullPrice = ((discountedPrice / discountedPrecents) * 100).rounded() - 0.01
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.locale = priceLocale
		return formatter.string(from: fullPrice as NSNumber) ?? "???$"
		
	}
	public enum SubscriptionDuration: Codable {
		case year, month, week, halfYear, twoMonths, threeMonths, unknown
		
		public func getDays() -> Int {
			return switch self {
			case .year:
				365
			case .month:
				30
			case .week:
				7
			case .halfYear:
				182
			case .twoMonths:
				60
			case .threeMonths:
				90
			case .unknown:
				1
			}
		}
		
		public func getDescriptionTitle() -> String {
			switch self {
			case .year:
				return "Year"
			case .month:
				return "Month"
			case .week:
				return "Week"
			case .halfYear:
				return "6 months"
			case .twoMonths:
				return "2 months"
			case .threeMonths:
				return "3 months"
			case .unknown:
				return "unknown"
			}
		}
		
		static func from(subscriptionPeriod: SKProductSubscriptionPeriod?) -> SubscriptionDuration {
			guard let subscriptionPeriod else { return .unknown }
			switch (subscriptionPeriod.unit, subscriptionPeriod.numberOfUnits) {
			case (.week, 1), (.day, 7):
				return .week
			case (.month, 1):
				return .month
			case (.month, 2):
				return .twoMonths
			case (.month, 3):
				return .threeMonths
			case (.month, 6):
				return .halfYear
			case (.year, 1):
				return .year
			default:
				return .unknown
			}
		}
	}
}


public enum AppProduct: String, Codable, CaseIterable {
	
	case yearSub = "e_year_sub"
	case trialMonthSub = "e_trial_month_sub"

	static var allCaseRaws: [RawValue] {
		return Self.allCases.map({ $0.rawValue })
	}
}

public enum SubscriptionResponse {
	case success
	case error(SubscriptionError)
}

public enum SubscriptionError: Error {
	case nothingToRestore
	case failedToRestore
	case failedToPurchase
	case purchaseCancelled
	case failedToGetProductInfo
	case validateError
	case validateAnyActive
	case validateCustomerInfoNil
	case needSwiftyStoreKit
}

public class SubscriptionService: NSObject {
	public static let shared = SubscriptionService()
	
	
	
	private var products: [AppProduct : MySubscription] = {
		let data = UserDefaults.standard.data(forKey: "productsSaveKey")
		let value = data.flatMap { try? JSONDecoder().decode([AppProduct : MySubscription].self, from: $0) }
		return value ?? [:]
		
	}() {
		didSet {
			let data = try? JSONEncoder().encode(products)
			UserDefaults.standard.set(data, forKey: "productsSaveKey")
			UserDefaults.standard.synchronize()
		}
	}
	
	private let sharedSecret = "978c6b2748354ac6b0e4e5021d25a623"
	
	private override init() {
		super.init()
	}
	
	public func hasTrial(product: AppProduct) -> Bool {
		if let sub = getStoreProduct(from: product) {
			return sub.isTrial
		} else {
			return false
		}
	}
	public func configure() {
		SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
			for purchase in purchases {
				switch purchase.transaction.transactionState {
				case .purchased, .restored:
					self.changePremium(state: true)
					if purchase.needsFinishTransaction {
						SwiftyStoreKit.finishTransaction(purchase.transaction)
					}
				case .failed, .purchasing, .deferred:
					break
				@unknown default:
					break
				}
			}
			
			self.getAllProducts()
		}
	}
	
	private func getAllProducts() {
		AppProduct.allCases.forEach { appProduct in
			self.retrieveProductInfo(appProduct: appProduct, completion: nil)
		}
	}
	
	public func validatePurchases() {
		
		var canceled:Bool = false
		
		let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: sharedSecret)
		SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
			switch result {
			case .success(let receipt):
				
				let subs: [String] = AppProduct.allCases.map({$0.rawValue})
				for sub in subs {
					switch SwiftyStoreKit.verifySubscription(
						ofType: .autoRenewable,
						productId: sub,
						inReceipt: receipt) {
					case .purchased(_, _):
						self.changePremium(state: true)
						return
					case .expired(_, _):
						canceled = true
					case .notPurchased:
						canceled = true
					}
				}
				
			case .error(let error):
				print("Receipt verification failed: \(error)")
			}
			
			if canceled == true {
				self.changePremium(state: false)
			}
		}
	}
	
	private func changePremium(state: Bool) {
        UserDefaults.premium = state
	}
	
	public func restorePurchase(completion: @escaping (SubscriptionResponse) -> Void) {
		SwiftyStoreKit.restorePurchases(atomically: true) { results in
			if results.restoreFailedPurchases.count > 0 {
				completion(.error(.failedToRestore))
			} else if results.restoredPurchases.count > 0 {
				completion(.success)
			} else {
				completion(.error(.nothingToRestore))
			}
		}
	}
	public func purchaseProduct(product: AppProduct, placement: AdaptyPlacement? = nil, completion: @escaping (SubscriptionResponse) -> Void) {
#if DEBUG
        UserDefaults.premium = true
		completion(.success)
		return
#endif
		//
		if let placement {
			if AdaptyService.shared.hasProductsForPaywall(placement: placement, id: product.rawValue) {
				AdaptyService.shared.buyProduct(placement: placement, id: product.rawValue, completion: { result in
					switch result {
					case .success:
                        UserDefaults.premium = true
						AdaptyService.shared.setProfileValue(value: placement.key, key: "purchasePlace")
						completion(result)
					case .error(let error):
						switch error {
						case .needSwiftyStoreKit:
							self.purchaseSwiftyStore(product: product, placement: placement, completion: completion)
						default:
							completion(result)
						}
					}
				})
				return
			}
		} else {
			purchaseSwiftyStore(product: product, placement: placement, completion: completion)
		}
		
	}
	private func purchaseSwiftyStore(product: AppProduct, placement: AdaptyPlacement? = nil, completion: @escaping (SubscriptionResponse) -> Void) {
		SwiftyStoreKit.purchaseProduct("\(product.rawValue)", quantity: 1, atomically: true) { result in
			switch result {
			case .success(_):
				AdaptyService.shared.setProfileValue(value: placement?.key ?? "noData", key: "purchasePlace")
                UserDefaults.premium = true
				completion(.success)
			case .error(let error):
				switch error.code {
				case .paymentCancelled, .overlayCancelled:
					completion(.error(.purchaseCancelled))
				default:
					completion(.error(.failedToPurchase))
				}
			case .deferred(purchase: let purchase):
				break
			}
		}
		
	}
	public func retrieveProductInfo(appProduct: AppProduct, completion: ((MySubscription) -> Void)?) {
		
		if let completion {
			if let storeProduct = getStoreProduct(from: appProduct) {
				completion(storeProduct)
				return
			}
		}
		
		SwiftyStoreKit.retrieveProductsInfo([appProduct.rawValue]) { result in
			print("RETRIEV", result.error?.localizedDescription)
			if let product = result.retrievedProducts.first {
				let storeProduct: MySubscription = .init(id: product.productIdentifier,
																 localizedPrice: (product.localizedPrice ?? "???$").replacingOccurrences(of: "USD", with: "$"),
																 price: product.price.doubleValue,
																 currency: product.priceLocale.currencyCode ?? "",
																 isTrial: product.introductoryPrice != nil,
																 priceLocale: product.priceLocale,
																 duration: MySubscription.SubscriptionDuration.from(subscriptionPeriod: product.subscriptionPeriod),
																 trialPrice: product.introductoryPrice?.localizedPrice
				)
				self.setStoreProduct(storeProduct, for: appProduct)
				completion?(storeProduct)
				
			}
		}
	}
	
	public func retrieveProductInfo(appProduct: AppProduct) async -> MySubscription {
		return await withCheckedContinuation { continuation in
			retrieveProductInfo(appProduct: appProduct, completion: { [weak self] sub in
				guard let self else { return }
				continuation.resume(returning: sub)
			})
		}
	}
	
	private func setStoreProduct(_ product: MySubscription, for appProduct: AppProduct) {
		self.products[appProduct] = product
	}
	
	
	private func getStoreProduct(from appProduct: AppProduct) -> MySubscription? {
		return products[appProduct]
	}
}

//
//  CommonPremiumViewController.swift
//  AI Logo Generator
//
//  Created by Oleksii on 29.07.2025.
//

import UIKit

public enum PremiumButtonType {
    case month, year
}

final class CommonPremiumViewController<Router: CommonPremiumRouter>: ViewController<CommonPremiumView, Router> {
	
	// MARK: - Properties
	private weak var delegate: PremiumControllerDelegate?
	private let adaptyPlacement: AdaptyPlacement
	private var isMain = true
	private let monthProduct: AppProduct
	private let yearProduct: AppProduct
	
	// MARK: - Life cycle
	init(delegate: PremiumControllerDelegate?, adaptyPlacement: AdaptyPlacement) {
		self.delegate = delegate
		self.adaptyPlacement = adaptyPlacement
        monthProduct = .trialMonthSub
        yearProduct = .yearSub
		super.init()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		setupActions()
		fetchPrices()
	}

	// MARK: - Private methods
	private func setupView() {
	//	mainView.setSelectedProduct(isMain: isMain)
	}

	private func setupActions() {
		mainView.closeAction = { [weak self] in
			guard let self else { return }
			delegate?.closePremium()
		}
		
		mainView.continueAction = { [weak self] in
			guard let self else { return }
			purchaseProduct()
		}
		
		mainView.mainProductAction = { [weak self] in
			guard let self else { return }
			isMain = true
			//mainView.setSelectedProduct(isMain: isMain)
		}

		mainView.subProductAction = { [weak self] in
			guard let self else { return }
			isMain = false
			//mainView.setSelectedProduct(isMain: isMain)
		}
	}
	
	private func fetchPrices() {
        SubscriptionService.shared.retrieveProductInfo(appProduct: yearProduct, completion: { [weak self] subscription in
			guard let self else { return }
			//self.mainView.setPrice(product: subscription)
		})
		
        SubscriptionService.shared.retrieveProductInfo(appProduct: monthProduct, completion: { [weak self] subscription in
			guard let self else { return }
			//self.mainView.setPrice(product: subscription)
		})
	}
	
    private func purchaseProduct(product: AppProduct) {
		addLoadingView()
		SubscriptionService.shared.purchaseProduct(product: product, placement: adaptyPlacement, completion: { [weak self] result in
			guard let self else { return }
			removeLoadingView()
			switch result {
			case .success:
				delegate?.closePremium()
			case .error(let subscriptionError):
				switch subscriptionError {
				case .purchaseCancelled:
					break
				default:
                    break
					//router.openErrorAlert(completion: nil)
				}
			}
		})
		
	}
}

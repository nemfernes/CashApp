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
    private var selectedProduct: AppProduct
	
	// MARK: - Life cycle
	init(delegate: PremiumControllerDelegate?, adaptyPlacement: AdaptyPlacement) {
		self.delegate = delegate
		self.adaptyPlacement = adaptyPlacement
        monthProduct = .trialMonthSub
        yearProduct = .yearSub
        selectedProduct = .trialMonthSub
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
        mainView.setupUI(product: .month)
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
		
        mainView.productAction = { [weak self] product in
			guard let self else { return }
            switch product {
            case .month:
                self.selectedProduct = .trialMonthSub
            case .year:
                self.selectedProduct = .yearSub
            }
		}
	}
	
	private func fetchPrices() {
        SubscriptionService.shared.retrieveProductInfo(appProduct: yearProduct, completion: { [weak self] subscription in
			guard let self else { return }
            self.mainView.setPrice(product: .year, sub: subscription)
		})
		
        SubscriptionService.shared.retrieveProductInfo(appProduct: monthProduct, completion: { [weak self] subscription in
			guard let self else { return }
            self.mainView.setPrice(product: .month, sub: subscription)
		})
	}
	
    private func purchaseProduct() {
		addLoadingView()
        SubscriptionService.shared.purchaseProduct(product: selectedProduct, placement: adaptyPlacement, completion: { [weak self] result in
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
                    router.openErrorAlert(completion: nil)
				}
			}
		})
		
	}
}

//
//  CommonPremiumView.swift
//  AI Logo Generator
//
//  Created by Oleksii on 29.07.2025.
//

import UIKit

final class CommonPremiumView: UIView {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var benefit2Label: UILabel!
    @IBOutlet weak var benefit1Label: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    // MARK: - Actions
	public var closeAction: (() -> Void)?
	public var continueAction: (() -> Void)?
	public var mainProductAction: (() -> Void)?
	public var subProductAction: (() -> Void)?

	// MARK: - Public methods
	
	
	public func showCloseButton() {
//		self.closeButton.isHidden = false
//		UIView.animate(withDuration: 0.2, animations: {
//			self.closeButton.alpha = 1
//		})
	}
	@objc private func mainProductTapped() {
		mainProductAction?()
	}
	
	@objc private func subProductTapped() {
		subProductAction?()
	}
	
    func setupUI(product: PremiumButtonType) {
        switch product {
        case .month:
            statusLabel.text = LS.Common.Strings.noPaymnet.localized
            monthTrialView.backgroundColor = UIColor.asset(.color_71B94D)
            monthContainerView.layer.borderColor = UIColor.asset(.color_71B94D).cgColor
            monthContainerView.layer.borderWidth = 1
            monthCheckboxImageView.image = UIImage.asset(.checkboxFilledIcon)
            
            yearlyContainerView.layer.borderWidth = 0
            yearlyCheckboxImageView.image = UIImage.asset(.checkboxEmptyIcon)
        case .year:
            statusLabel.text = LS.Common.Strings.cancelAnytime.localized
            yearlyContainerView.layer.borderWidth = 1
            yearlyContainerView.layer.borderColor = UIColor.asset(.color_71B94D).cgColor
            yearlyCheckboxImageView.image = UIImage.asset(.checkboxFilledIcon)
            
            monthTrialView.backgroundColor = UIColor.asset(.color_1E1E1E)
            monthContainerView.layer.borderWidth = 0
            monthCheckboxImageView.image = UIImage.asset(.checkboxEmptyIcon)
        }
    }
    
    func setPrice(product: PremiumButtonType, sub: MySubscription) {
        switch product {
        case .month:
            monthSubtitleLabel.text = String(format: LS.Common.Strings.thenPerWeek.localized, sub.localizedPrice)
        case .year:
            yearlySubtitleLabel.text = sub.localizedPrice
        }
    }
    
    private func setupPrice() {
        Task { [weak self] in
            guard let self else { return }
            do {
                let monthResult = try await SubscriptionService.shared.retrieveProductInfo(appProduct: monthSubscription)
                self.setPrice(product: .month, sub: monthResult)

                let yearResult = try await SubscriptionService.shared.retrieveProductInfo(appProduct: yearSubscription)
                self.setPrice(product: .year, sub: yearResult)
            } catch {
                print("❌ setupPrice error:", error)
            }
        }
    }

}

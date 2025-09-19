//
//  SelectCurrencyView.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 18.09.2025.
//

import UIKit

final class SelectCurrencyView: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.setTitle(LS.Common.Strings.save.localized, for: .normal)
            saveButton.setTitleColor(.white, for: .normal)
            saveButton.titleLabel?.font = .urbanistSemiBold16
            saveButton.backgroundColor = .color2B6CF0
            saveButton.layer.cornerRadius = 28
            saveButton.addTarget(self, action: #selector(saveDidTapped), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!  {
        didSet {
            titleLabel.setup(text: LS.Common.Strings.currency.localized, textColor: .white, font: .urbanistSemiBold20, textAlignment: .center, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 14
            containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            containerView.clipsToBounds = true
            containerView.backgroundColor = .color151718
        }
    }
    
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var eurLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var cnyLabel: UILabel!
    
    @IBOutlet weak var usdStatus: UIImageView!
    @IBOutlet weak var eurStatus: UIImageView!
    @IBOutlet weak var jpyStatus: UIImageView!
    @IBOutlet weak var gbpStatus: UIImageView!
    @IBOutlet weak var cnyStatus: UIImageView!
    
    @IBOutlet weak var usdButton: UIButton!
    @IBOutlet weak var eurButton: UIButton!
    @IBOutlet weak var jpyButton: UIButton!
    @IBOutlet weak var gbpButton: UIButton!
    @IBOutlet weak var cnyButton: UIButton!
    
    
    // MARK: - Actions
    public var selectAction: ((_ currency: String) -> Void)?
    public var saveAction: (() -> Void)?
    
    // MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
    }
    
    // MARK: - Objc methods
    @objc private func currencyTapped(_ sender: UIButton) {
        updateSelection(selectedTag: sender.tag)
    }
    
    private func updateSelection(selectedTag: Int) {
        var selectedCurrency = ""
        let allStatus = [usdStatus, eurStatus, jpyStatus, gbpStatus, cnyStatus]
        let allCurrencies = ["USD", "EUR", "JPY", "GBP", "CNY"]
        
        for (index, imageView) in allStatus.enumerated() {
            if index == selectedTag {
                imageView?.image = .radioOnIc
                selectedCurrency = allCurrencies[index]
            } else {
                imageView?.image = .radioOffIc
            }
        }
        
        selectAction?(selectedCurrency)
    }
    
    @objc private func saveDidTapped() {
        saveAction?()
    }
    
    func viewDidload() {
        usdLabel.text = "USD"
        eurLabel.text = "EUR"
        jpyLabel.text = "JPY"
        gbpLabel.text = "GBP"
        cnyLabel.text = "CNY"
        
        usdButton.tag = 0
        eurButton.tag = 1
        jpyButton.tag = 2
        gbpButton.tag = 3
        cnyButton.tag = 4
        [usdButton, eurButton, jpyButton, gbpButton, cnyButton].forEach { button in
            button?.addTarget(self, action: #selector(currencyTapped(_:)), for: .touchUpInside)
        }
        let allStatus = [usdStatus, eurStatus, jpyStatus, gbpStatus, cnyStatus]
        allStatus.forEach { $0?.image = .radioOffIc }
    }
    
}

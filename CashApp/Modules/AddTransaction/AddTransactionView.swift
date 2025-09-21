//
//  AddTransactionView.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 21.09.2025.
//

import UIKit

final class AddTransactionView: UIView, UITextFieldDelegate {
	
    @IBOutlet weak var addButton: UIButton!  {
        didSet {
            addButton.setTitle(LS.Common.Strings.addSavings.localized, for: .normal)
            addButton.setTitleColor(.white, for: .normal)
            addButton.titleLabel?.font = .urbanistSemiBold16
            addButton.backgroundColor = .color2B6CF0
            addButton.layer.cornerRadius = 28
            addButton.addTarget(self, action: #selector(addDidTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var dateValueLabel: UILabel!  {
        didSet {
            dateValueLabel.setup(text: LS.Common.Strings.december.localized, textColor: .color99989B, font: .urbanistMedium16, textAlignment: .left, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var dateContainerView: UIView! {
        didSet {
            dateContainerView.backgroundColor = .color1F1F21
            dateContainerView.layer.cornerRadius = 12
        }
    }
    @IBOutlet weak var dateButton: UIButton!   {
        didSet {
            dateButton.addTarget(self, action: #selector(dateDidTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var dateLabel: UILabel!  {
        didSet {
            dateLabel.setup(text: LS.Common.Strings.date.localized, textColor: .white, font: .urbanistMedium14, textAlignment: .left, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var amountTextField: UITextField!  {
        didSet {
            amountTextField.setup(placeholder: "10 000", textAlignment: .left, textColor: .white, placeholderColor: .color99989B, font: .urbanistMedium16)
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
            amountTextField.leftView = paddingView
            amountTextField.leftViewMode = .always
            amountTextField.backgroundColor = .color1F1F21
            amountTextField.keyboardType = .numberPad
            amountTextField.layer.borderWidth = 0
            amountTextField.layer.borderColor = UIColor.asset(.color_2B6CF0).cgColor
            amountTextField.layer.cornerRadius = 16
            amountTextField.delegate = self
        }
    }
    @IBOutlet weak var amountLabel: UILabel!   {
        didSet {
            amountLabel.setup(text: LS.Common.Strings.goalAmount.localized, textColor: .white, font: .urbanistMedium14, textAlignment: .left, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var titleLabel: UILabel!  {
        didSet {
            titleLabel.setup(text: LS.Common.Strings.addSavings.localized, textColor: .white, font: .urbanistSemiBold20, textAlignment: .center, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var containerView: UIView!
    // MARK: - Outlets
	
	
	// MARK: - Actions
	public var addAction: (() -> Void)?
    public var dateAction: (() -> Void)?
	
	// MARK: - Life cycle
	override func layoutSubviews() {
		super.layoutSubviews()
        self.backgroundColor = .clear
	}
	
	// MARK: - Private methods
	
	// MARK: - Objc methods
	@objc private func addDidTapped() {
        addAction?()
	}
    
    @objc private func dateDidTapped() {
        dateAction?()
    }
    
    func updateDate(date: String) {
        self.dateValueLabel.text = date
        self.dateValueLabel.textColor = .white
    }
    
    func setupUI(type: TransactionType) {
        switch type {
        case .income:
            self.titleLabel.text = LS.Common.Strings.addSavings.localized
            self.addButton.setTitle(LS.Common.Strings.addSavings.localized, for: .normal)
        case .withdraw:
            self.titleLabel.text = LS.Common.Strings.withdraw.localized
            self.addButton.setTitle(LS.Common.Strings.withdraw.localized, for: .normal)
        }
    }

   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
       return true
   }
}

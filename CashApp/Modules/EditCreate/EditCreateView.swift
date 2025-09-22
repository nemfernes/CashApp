//
//  EditCreateView.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 17.09.2025.
//

import UIKit

final class EditCreateView: UIView, UITextFieldDelegate {
    
    @IBOutlet weak var currencyLabel: UILabel! {
        didSet {
            currencyLabel.setup(text: LS.Common.Strings.currency.localized, textColor: .white, font: .urbanistMedium14, textAlignment: .left, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var saveButton: UIButton!  {
        didSet {
            saveButton.setTitle(LS.Common.Strings.save.localized, for: .normal)
            saveButton.setTitleColor(.white, for: .normal)
            saveButton.titleLabel?.font = .urbanistSemiBold16
            saveButton.backgroundColor = .color2B6CF0
            saveButton.layer.cornerRadius = 28
            saveButton.addTarget(self, action: #selector(saveDidTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var dateButton: UIButton!   {
        didSet {
            dateButton.addTarget(self, action: #selector(dateDidTapped), for: .touchUpInside)
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
    @IBOutlet weak var dateLabel: UILabel!  {
        didSet {
            dateLabel.setup(text: LS.Common.Strings.dedline.localized, textColor: .white, font: .urbanistMedium14, textAlignment: .left, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var currencyButton: UIButton!  {
        didSet {
            currencyButton.addTarget(self, action: #selector(currencyDidTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var currencyValueLabel: UILabel!  {
        didSet {
            currencyValueLabel.setup(text: "USD", textColor: .color99989B, font: .urbanistMedium16, textAlignment: .left, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var currencyContainerView: UIView!  {
        didSet {
            currencyContainerView.backgroundColor = .color1F1F21
            currencyContainerView.layer.cornerRadius = 12
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
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.setup(placeholder: LS.Common.Strings.vacatin.localized, textAlignment: .left, textColor: .white, placeholderColor: .color99989B, font: .urbanistMedium16)
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
            nameTextField.leftView = paddingView
            nameTextField.leftViewMode = .always
            nameTextField.backgroundColor = .color1F1F21
            nameTextField.layer.borderWidth = 0
            nameTextField.layer.borderColor = UIColor.asset(.color_2B6CF0).cgColor
            nameTextField.layer.cornerRadius = 16
            nameTextField.delegate = self
        }
    }
    @IBOutlet weak var goalNameLabel: UILabel!  {
        didSet {
            goalNameLabel.setup(text: LS.Common.Strings.goalName.localized, textColor: .white, font: .urbanistMedium14, textAlignment: .left, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var emojiCollectionView: UICollectionView!
    @IBOutlet weak var emojiLabel: UILabel!  {
        didSet {
            emojiLabel.setup(text: LS.Common.Strings.addEmoji.localized, textColor: .white, font: .urbanistMedium14, textAlignment: .left, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var titleLabel: UILabel!  {
        didSet {
            titleLabel.setup(text: LS.Common.Strings.newGoal.localized, textColor: .white, font: .urbanistSemiBold20, textAlignment: .center, adjustWidth: true, numberOfLines: 2)
        }
    }
    @IBOutlet weak var backButton: UIButton!  {
        didSet {
            backButton.setImage(.backIc, for: .normal)
            backButton.addTarget(self, action: #selector(backDidTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var navigationView: UIView!  {
        didSet {
            navigationView.backgroundColor = UIColor.color1F1F21
        }
    }
    
    // MARK: - Outlets
    
    
    // MARK: - Actions
    public var backAction: (() -> Void)?
    public var saveAction: (() -> Void)?
    public var currencyAction: (() -> Void)?
    public var dateAction: (() -> Void)?
    
    // MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .color151718
    }
    
    // MARK: - Private methods
    
    // MARK: - Objc methods
    @objc private func backDidTapped() {
        backAction?()
    }
    
    @objc private func saveDidTapped() {
        saveAction?()
    }
    
    @objc private func currencyDidTapped() {
        currencyAction?()
    }
    
    @objc private func dateDidTapped() {
        dateAction?()
    }
    
    private func updateBorder(for view: UIView, isActive: Bool) {
        view.layer.borderWidth = isActive ? 1.5 : 0
        view.layer.borderColor = isActive ? UIColor.asset(.color_2B6CF0).cgColor : UIColor.clear.cgColor
    }
    
    func updateCurrency(currency: String) {
        self.currencyValueLabel.text = currency
        self.currencyValueLabel.textColor = .white
        updateBorder(for: currencyContainerView, isActive: true)
    }

    func updateDate(date: String) {
        self.dateValueLabel.text = date
        self.dateValueLabel.textColor = .white
        updateBorder(for: dateContainerView, isActive: true)
    }
    
    func fill(with goal: Goal) {
           
            nameTextField.text = goal.name
            updateBorder(for: nameTextField, isActive: !goal.name.isEmpty)
            
            // Сумма
            if goal.amount > 0 {
                amountTextField.text = "\(goal.amount)"
                updateBorder(for: amountTextField, isActive: true)
            }
            
            // Валюта
            if !goal.currency.isEmpty {
                currencyValueLabel.text = goal.currency
                currencyValueLabel.textColor = .white
                updateBorder(for: currencyContainerView, isActive: true)
            }
            
            // Дата
            if !goal.date.isEmpty {
                dateValueLabel.text = goal.date
                dateValueLabel.textColor = .white
                updateBorder(for: dateContainerView, isActive: true)
            }
            
        }
    
     func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameTextField {
            updateBorder(for: nameTextField, isActive: !(textField.text?.isEmpty ?? true))
        } else if textField == amountTextField {
            updateBorder(for: amountTextField, isActive: !(textField.text?.isEmpty ?? true))
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateBorder(for: textField, isActive: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


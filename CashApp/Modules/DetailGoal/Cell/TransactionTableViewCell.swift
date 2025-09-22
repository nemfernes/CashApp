//
//  StepTableViewCell.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 04.09.2025.
//

import UIKit

class TransactionTableViewCell: UITableViewCell, UITextViewDelegate {
    
    static let reuseId = "TransactionTableViewCell"
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 16
            containerView.backgroundColor = .color1F1F21
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var moreButton: UIButton!  {
        didSet {
            moreButton.setImage(.moreIc, for: .normal)
            moreButton.addTarget(self, action: #selector(optionDidTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var optionAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setupUI(transaction: Transaction) {
        titleLabel.text = transaction.formattedDate
        amountLabel.text = transaction.formattedAmount
        amountLabel.textColor = transaction.amountColor
        typeLabel.text = transaction.typeText
    }
    
    @objc private func optionDidTapped() {
        optionAction?()
    }
}

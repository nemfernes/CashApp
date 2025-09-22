//
//  FilterView.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 22.09.2025.
//

import UIKit

final class FilterView: UIView {
	
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
            titleLabel.setup(text: LS.Common.Strings.Filter.localized, textColor: .white, font: .urbanistSemiBold20, textAlignment: .center, adjustWidth: true, numberOfLines: 1)
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
    
    @IBOutlet weak var savingsLabel: UILabel!
    @IBOutlet weak var withdrawLabel: UILabel!
    @IBOutlet weak var newestLabel: UILabel!
    @IBOutlet weak var oldestLabel: UILabel!
    
    @IBOutlet weak var savingsStatus: UIImageView!
    @IBOutlet weak var withdrawStatus: UIImageView!
    @IBOutlet weak var newestStatus: UIImageView!
    @IBOutlet weak var oldestStatus: UIImageView!
    
    @IBOutlet weak var savingsButton: UIButton!
    @IBOutlet weak var withdrawButton: UIButton!
    @IBOutlet weak var newestButton: UIButton!
    @IBOutlet weak var oldestButton: UIButton!
    
    
    // MARK: - Actions
    public var saveAction: ((_ selectedType: String, _ selectedOrder: String) -> Void)?
       
       private var selectedType: String = LS.Common.Strings.savings.localized
       private var selectedOrder: String = LS.Common.Strings.newest.localized
    
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
        let group1 = [savingsStatus, withdrawStatus]
        let group2 = [newestStatus, oldestStatus]
        
        switch selectedTag {
        case 0, 1:
            for (index, imageView) in group1.enumerated() {
                imageView?.image = (index == selectedTag) ? .radioOnIc : .radioOffIc
            }
            selectedType = (selectedTag == 0) ? LS.Common.Strings.savings.localized : LS.Common.Strings.withdraw.localized
            
        case 2, 3:
            for (index, imageView) in group2.enumerated() {
                imageView?.image = (index + 2 == selectedTag) ? .radioOnIc : .radioOffIc
            }
            selectedOrder = (selectedTag == 2) ? LS.Common.Strings.newest.localized : LS.Common.Strings.oldest.localized
            
        default:
            break
        }
        
    }


    
    @objc private func saveDidTapped() {
        saveAction?(selectedType, selectedOrder)
    }
    
    func viewDidload() {
        savingsLabel.text = LS.Common.Strings.savings.localized
        withdrawLabel.text = LS.Common.Strings.withdraw.localized
        newestLabel.text = LS.Common.Strings.newest.localized
        oldestLabel.text = LS.Common.Strings.oldest.localized
        
        savingsButton.tag = 0
        withdrawButton.tag = 1
        newestButton.tag = 2
        oldestButton.tag = 3
        [savingsButton, withdrawButton, newestButton, oldestButton].forEach { button in
            button?.addTarget(self, action: #selector(currencyTapped(_:)), for: .touchUpInside)
        }
        let allStatus = [savingsStatus, withdrawStatus, newestStatus, oldestStatus]
        allStatus.forEach { $0?.image = .radioOffIc }
    }
    
}

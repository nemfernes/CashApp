//
//  DetailGoalView.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 20.09.2025.
//

import UIKit

final class DetailGoalView: UIView {
	
	// MARK: - Outlets
	
    
    @IBOutlet weak var titleLabel: UILabel!   {
        didSet {
            titleLabel.setup(text:"", textColor: .white, font: .urbanistSemiBold20, textAlignment: .center, adjustWidth: true, numberOfLines: 2)
        }
    }
    @IBOutlet weak var optionButton: UIButton!  {
        didSet {
            optionButton.setImage(.optionIc, for: .normal)
            optionButton.addTarget(self, action: #selector(optionDidTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var backButton: UIButton!  {
        didSet {
            backButton.setImage(.backIc, for: .normal)
            backButton.addTarget(self, action: #selector(backDidTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var navbarView: UIView!  {
        didSet {
            navbarView.backgroundColor = UIColor.color1F1F21
        }
    }
    @IBOutlet weak var totalPercentLabel: UILabel! {
        didSet {
            totalPercentLabel.setup(text:"", textColor: .white, font: .urbanistSemiBold44, textAlignment: .right, adjustWidth: true, numberOfLines: 2)
        }
    }
    @IBOutlet weak var totalAmountLabel: UILabel! {
        didSet {
            totalAmountLabel.setup(text:"", textColor: .color99989B, font: .urbanistMedium16, textAlignment: .left, adjustWidth: true, numberOfLines: 2)
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.setup(text:"", textColor: .white, font: .urbanistSemiBold24, textAlignment: .left, adjustWidth: true, numberOfLines: 2)
        }
    }
    @IBOutlet weak var emojiLabel: UILabel! {
        didSet {
            emojiLabel.font = .systemFont(ofSize: 70)
        }
    }
    @IBOutlet weak var circleProgressView: CircleProgressView!
    @IBOutlet weak var addSavingButton: UIButton!  {
        didSet {
            addSavingButton.setTitle(LS.Common.Strings.addSavings.localized, for: .normal)
            addSavingButton.setTitleColor(.white, for: .normal)
            addSavingButton.titleLabel?.font = .urbanistSemiBold14
            addSavingButton.backgroundColor = .color2B6CF0
            addSavingButton.layer.cornerRadius = 25
            addSavingButton.addTarget(self, action: #selector(addSavingDidTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var withdrawButton: UIButton! {
        didSet {
            withdrawButton.setTitle(LS.Common.Strings.withdraw.localized, for: .normal)
            withdrawButton.setTitleColor(.white, for: .normal)
            withdrawButton.titleLabel?.font = .urbanistSemiBold14
            withdrawButton.backgroundColor = .color2B2D2E
            withdrawButton.layer.cornerRadius = 25
            withdrawButton.addTarget(self, action: #selector(withdrawDidTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var historyTableView: UITableView! {
        didSet {
            historyTableView.isHidden = true
        }
    }
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var segmentControlView: SegmentedControlView! {
        didSet {
            segmentControlView.items = ["Goal", "History"]
            segmentControlView.onSelect = { [weak self] index in
                guard let self else {return}
                print("Выбран сегмент:", index)
                switch index {
                case 0:
                    self.scrollView.isHidden = false
                    self.historyTableView.isHidden = true
                case 1:
                    self.scrollView.isHidden = true
                    self.historyTableView.isHidden = false
                default:
                    break
                }
            }
        }
    }
    
	// MARK: - Actions
	public var addSavingAction: (() -> Void)?
    public var withdrawAction: (() -> Void)?
    public var backAction: (() -> Void)?
    public var optionAction: (() -> Void)?
	
	// MARK: - Life cycle
	override func layoutSubviews() {
		super.layoutSubviews()
	}
	
	// MARK: - Private methods
	private func defaultMethod() {
		
	}
	
	// MARK: - Objc methods
	@objc private func addSavingDidTapped() {
        addSavingAction?()
	}
    @objc private func withdrawDidTapped() {
        withdrawAction?()
    }
    @objc private func backDidTapped() {
        backAction?()
    }
    @objc private func optionDidTapped() {
        optionAction?()
    }
    
    func setupUI(goal: Goal) {
        circleProgressView.progress = goal.progress
        emojiLabel.text = goal.emoji
        titleLabel.text = goal.name
        totalPercentLabel.text = "\(Int(goal.progress * 100))%"
        nameLabel.text = goal.name
        totalAmountLabel.text = "\(goal.currencySymbol)\(goal.amount)"
    }
}

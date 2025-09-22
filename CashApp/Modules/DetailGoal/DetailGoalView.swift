//
//  DetailGoalView.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 20.09.2025.
//

import UIKit

final class DetailGoalView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var historyContainerView: UIView! {
        didSet {
            historyContainerView.isHidden = true
        }
    }
    
    @IBOutlet weak var filterButton: UIButton!  {
        didSet {
            filterButton.addTarget(self, action: #selector(filterDidTapped), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var timelineContainerView: UIView! {
        didSet {
            timelineContainerView.layer.cornerRadius = 16
            timelineContainerView.backgroundColor = .color1F1F21
        }
    }
    @IBOutlet weak var progressTimeValueLabel: UILabel! {
        didSet {
            progressTimeValueLabel.setup(text: "", textColor: .white, font: .urbanistMedium16, textAlignment: .right, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var progressTimeLabel: UILabel! {
        didSet {
            progressTimeLabel.setup(text: LS.Common.Strings.progressOver.localized, textColor: .color99989B, font: .urbanistMedium16, textAlignment: .left, adjustWidth: true, numberOfLines: 1)
        }
    }
    
    @IBOutlet weak var timeRemainingValueLabel: UILabel!  {
        didSet {
            timeRemainingValueLabel.setup(text: "", textColor: .white, font: .urbanistMedium16, textAlignment: .right, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var timeRemainingLabel: UILabel! {
        didSet {
            timeRemainingLabel.setup(text: LS.Common.Strings.timeRemaining.localized, textColor: .color99989B, font: .urbanistMedium16, textAlignment: .left, adjustWidth: true, numberOfLines: 1)
        }
    }
    
    @IBOutlet weak var goalCompletionValueLabel: UILabel! {
        didSet {
            goalCompletionValueLabel.setup(text: "", textColor: .white, font: .urbanistMedium16, textAlignment: .right, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var goalCompletionLabel: UILabel! {
        didSet {
            goalCompletionLabel.setup(text: LS.Common.Strings.goalCompletion.localized, textColor: .color99989B, font: .urbanistMedium16, textAlignment: .left, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var timelineLabel: UILabel! {
        didSet {
            timelineLabel.setup(text: LS.Common.Strings.timeline.localized, textColor: .white, font: .urbanistMedium16, textAlignment: .left, adjustWidth: true, numberOfLines: 1)
        }
    }
    
    @IBOutlet weak var perMonthValueLabel: UILabel! {
        didSet {
            perMonthValueLabel.setup(text: "", textColor: .white, font: .urbanistMedium16, textAlignment: .right, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var perWeekValueLabel: UILabel! {
        didSet {
            perWeekValueLabel.setup(text: "", textColor: .white, font: .urbanistMedium16, textAlignment: .right, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var perDayValueLabel: UILabel! {
        didSet {
            perDayValueLabel.setup(text: "", textColor: .white, font: .urbanistMedium16, textAlignment: .right, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var perMonthLabel: UILabel!  {
        didSet {
            perMonthLabel.setup(text: LS.Common.Strings.perMonth.localized, textColor: .color99989B, font: .urbanistMedium16, textAlignment: .left, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var perWeekLabel: UILabel! {
        didSet {
            perWeekLabel.setup(text: LS.Common.Strings.perWeek.localized, textColor: .color99989B, font: .urbanistMedium16, textAlignment: .left, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var perDayLabel: UILabel! {
        didSet {
            perDayLabel.setup(text: LS.Common.Strings.perDay.localized, textColor: .color99989B, font: .urbanistMedium16, textAlignment: .left, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var savingPlanContainerView: UIView!{
        didSet {
            savingPlanContainerView.layer.cornerRadius = 16
            savingPlanContainerView.backgroundColor = .color1F1F21
        }
    }
    @IBOutlet weak var savingPlanLabel: UILabel! {
        didSet {
            savingPlanLabel.setup(text: LS.Common.Strings.savingPlan.localized, textColor: .white, font: .urbanistMedium16, textAlignment: .left, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var remainTitleLabel: UILabel! {
        didSet {
            remainTitleLabel.setup(text: LS.Common.Strings.remaining.localized, textColor: .color99989B, font: .urbanistRegular12, textAlignment: .left, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var remainContainerView: UIView! {
        didSet {
            remainContainerView.layer.cornerRadius = 16
            remainContainerView.backgroundColor = .color1F1F21
        }
    }
    @IBOutlet weak var remainPercentLabel: UILabel!  {
        didSet {
            remainPercentLabel.setup(text: "", textColor: .colorDB841D, font: .urbanistRegular12, textAlignment: .left, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var remainTotalLabel: UILabel! {
        didSet {
            remainTotalLabel.setup(text: "", textColor: .white, font: .urbanistSemiBold20, textAlignment: .left, adjustWidth: true, numberOfLines: 1)
        }
    }
    
    @IBOutlet weak var moneyboxContainerView: UIView! {
        didSet {
            moneyboxContainerView.layer.cornerRadius = 16
            moneyboxContainerView.backgroundColor = .color1F1F21
        }
    }
    @IBOutlet weak var moneyboxMonthValueLabel: UILabel! {
        didSet {
            moneyboxMonthValueLabel.setup(text: "", textColor: .color1BC04D, font: .urbanistRegular12, textAlignment: .left, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var moneyboxTotalLabel: UILabel! {
        didSet {
            moneyboxTotalLabel.setup(text: "", textColor: .white, font: .urbanistSemiBold20, textAlignment: .left, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var moneyboxTitleLabel: UILabel! {
        didSet {
            moneyboxTitleLabel.setup(text: LS.Common.Strings.accumulated.localized, textColor: .color99989B, font: .urbanistRegular12, textAlignment: .left, adjustWidth: true, numberOfLines: 1)
        }
    }
    
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
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var segmentControlView: SegmentedControlView! {
        didSet {
            segmentControlView.items = [LS.Common.Strings.goal.localized, LS.Common.Strings.history.localized]
            segmentControlView.onSelect = { [weak self] index in
                guard let self else {return}
                switch index {
                case 0:
                    self.scrollView.isHidden = false
                    self.historyContainerView.isHidden = true
                case 1:
                    self.scrollView.isHidden = true
                    self.historyContainerView.isHidden = false
                    self.reloadTableView()
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
    public var filterAction: (() -> Void)?
    
    // MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Private methods
    public func reloadTableView() {
        self.historyTableView.reloadData()
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
    
    @objc private func filterDidTapped() {
        filterAction?()
    }
    
    func setupUI(goal: Goal) {
        circleProgressView.progress = goal.progress
        circleProgressView.progressColor = goal.uiColor
        emojiLabel.text = goal.emoji
        titleLabel.text = goal.name
        totalPercentLabel.text = "\(Int(goal.progress * 100))%"
        nameLabel.text = goal.name
        totalAmountLabel.text = "\(goal.currencySymbol)\(goal.amount)"
        moneyboxMonthValueLabel.text = "+\(goal.currencySymbol)\(goal.incomeThisMonth) " + LS.Common.Strings.perMonth.localized
        moneyboxTotalLabel.text = "\(goal.currencySymbol)\(goal.accumulated)"
        remainPercentLabel.text = "\(goal.remainingPercent)% " + LS.Common.Strings.ofTheGoal.localized
        remainTotalLabel.text = "\(goal.currencySymbol)\(goal.remaining)"
        perDayValueLabel.text = "\(goal.currencySymbol)\(goal.perDayPlan)"
        perWeekValueLabel.text = "\(goal.currencySymbol)\(goal.perWeekPlan)"
        perMonthValueLabel.text = "\(goal.currencySymbol)\(goal.perMonthPlan)"
        goalCompletionValueLabel.text = goal.targetDateText
        timeRemainingValueLabel.text = "\(goal.timeRemainingMonths) \(LS.Common.Strings.month.localized)"
        progressTimeValueLabel.text = goal.progressOverTimeString
        
    }
}


//
//  SelectDateView.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 18.09.2025.
//

import UIKit

final class SelectDateView: UIView {
    
    // MARK: - Outlets
    
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
    @IBOutlet weak var datePicker: UIDatePicker! {
        didSet {
            datePicker.datePickerMode = .date
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -2, to: Date())
            datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 50, to: Date())
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.setup(text: LS.Common.Strings.dedline.localized, textColor: .white, font: .urbanistSemiBold20, textAlignment: .center, adjustWidth: true, numberOfLines: 1)
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
    
    private let months = Calendar.current.shortMonthSymbols
    private let days = Array(1...31).map { "\($0)" }
    private let years: [String] = {
    let currentYear = Calendar.current.component(.year, from: Date())
    let startYear = currentYear - 2
    let endYear = currentYear + 50
    return Array(startYear...endYear).map { "\($0)" }
    }()
    private var selectedMonth: String?
    private var selectedDay: String?
    private var selectedYear: String?
    // MARK: - Actions
    public var saveAction: ((_ date: String) -> Void)?
    
    // MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
    }
    
    // MARK: - Private methods
    
    // MARK: - Objc methods
    @objc private func saveDidTapped() {
        let selectedDate = datePicker.date
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale.current
        
        let formattedDate = formatter.string(from: selectedDate)
        
        saveAction?(formattedDate)
    }

   
}

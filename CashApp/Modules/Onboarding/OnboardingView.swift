//
//  OnboardingView.swift
//  AI Logo Generator
//
//  Created by Oleksii on 28.07.2025.
//

import UIKit

final class OnboardingView: UIView {
    
    @IBOutlet weak var welcomeView: InteractiveWelcomeView!
    
    @IBOutlet weak var continueButton: UIButton! {
        didSet {
            continueButton.setTitle(LS.Common.Strings.continue.localized, for: .normal)
            continueButton.setTitleColor(.white, for: .normal)
            continueButton.titleLabel?.font = .urbanistSemiBold16
            continueButton.backgroundColor = UIColor.asset(.color_2B6CF0)
            continueButton.layer.cornerRadius = 28
            continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        }
    }
    
    // MARK: - Actions
    public var continueAction: ((_ step: IntroPage) -> Void)?
    
    // MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @objc private func continueTapped(_ sender: UIButton) {
        continueAction?(welcomeView.currentStep)
    }
    
    func updateView(step: IntroPage) {
        switch step {
        case .first:
            welcomeView.setup(step: .first)
        case .second:
            welcomeView.setup(step: .second)
        case .third:
            welcomeView.setup(step: .third)
        }
    }
}

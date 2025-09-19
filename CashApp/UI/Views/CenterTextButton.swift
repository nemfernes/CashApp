//
//  CenterTextButton.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 17.09.2025.
//

import Foundation
import UIKit

public enum SetupType: Int {
    case common
    case small
}

public enum IconPosition {
    case left
    case right
}

public class CenterTextButton: UIButton {
    private let iconImageView = UIImageView()
    private let label = UILabel()
    private let hStack = UIStackView()

    private var iconPosition: IconPosition = .left // default

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 28).isActive = true

        
        iconImageView.isUserInteractionEnabled = false
        label.isUserInteractionEnabled = false

        hStack.axis = .horizontal
        hStack.spacing = 8
        hStack.alignment = .center
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.isUserInteractionEnabled = false

        addSubview(hStack)
        NSLayoutConstraint.activate([
            hStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            hStack.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    public func configure(title: String, image: UIImage?, showImage: Bool = true, iconPosition: IconPosition = .left, titleColor: UIColor = .white, font: UIFont = .urbanistBold14) {
        self.iconPosition = iconPosition

        label.text = title
        label.textColor = titleColor
        label.font = font
        iconImageView.image = image
        iconImageView.isHidden = !showImage

        // Clear existing arranged subviews
        hStack.arrangedSubviews.forEach { hStack.removeArrangedSubview($0); $0.removeFromSuperview() }

        // Re-add in correct order
        switch iconPosition {
        case .left:
            hStack.addArrangedSubview(iconImageView)
            hStack.addArrangedSubview(label)
        case .right:
            hStack.addArrangedSubview(label)
            hStack.addArrangedSubview(iconImageView)
        }
    }
    
    public func setIconHidden(_ hidden: Bool) {
        iconImageView.isHidden = hidden
    }
}

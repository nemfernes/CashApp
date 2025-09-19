//
//  SelectEmojiView.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 17.09.2025.
//

import UIKit

final class SelectEmojiView: UIView {
	
	// MARK: - Outlets
	
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 14
            containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            containerView.clipsToBounds = true
            containerView.backgroundColor = .color151718
        }
    }
    @IBOutlet weak var emojisCollectionView: UICollectionView!
    @IBOutlet weak var typeCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!  {
        didSet {
            titleLabel.setup(text: LS.Common.Strings.addEmoji.localized, textColor: .white, font: .urbanistSemiBold20, textAlignment: .center, adjustWidth: true, numberOfLines: 1)
        }
    }
    
	// MARK: - Actions
	public var defaultAction: (() -> Void)?
	
	// MARK: - Life cycle
	override func layoutSubviews() {
		super.layoutSubviews()
        self.backgroundColor = .clear
	}
	
	// MARK: - Private methods
	private func defaultMethod() {
		
	}
	
	// MARK: - Objc methods
	@objc private func defaultDidTapped() {
		defaultAction?()
	}
	
}

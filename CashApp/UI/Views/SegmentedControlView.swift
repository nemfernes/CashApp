//
//  SegmentedControlView.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 20.09.2025.
//

import Foundation
import UIKit
import SnapKit

final class SegmentedControlView: UIView {
    
    private let stackView = UIStackView()
    private let selectionView = UIView()
    private var buttons: [UIButton] = []
    
    var items: [String] = [] {
        didSet { configureButtons() }
    }
    
    var selectedIndex: Int = 0 {
        didSet { updateSelection(animated: true) }
    }
    
    var onSelect: ((Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = UIColor(white: 0.08, alpha: 1)
        layer.cornerRadius = 24
        
        selectionView.backgroundColor = UIColor(white: 0.2, alpha: 1)
        selectionView.layer.cornerRadius = 20
        addSubview(selectionView)
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }
    }
    
    private func configureButtons() {
        buttons.forEach { $0.removeFromSuperview() }
        buttons = []
        
        for (index, title) in items.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.urbanistMedium14
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
            buttons.append(button)
        }
        
        setNeedsLayout() // обновить layout
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        selectedIndex = sender.tag
        onSelect?(selectedIndex)
    }
    
    private func updateSelection(animated: Bool) {
        guard selectedIndex < buttons.count else { return }
        let button = buttons[selectedIndex]
        let targetFrame = button.convert(button.bounds, to: self)
        
        if animated {
            UIView.animate(withDuration: 0.25) {
                self.selectionView.frame = targetFrame
            }
        } else {
            selectionView.frame = targetFrame
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateSelection(animated: false)
    }
}

//
//  OptionMenu.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 22.09.2025.
//

import UIKit
import SnapKit

final class OptionMenuView: UIView {
    
    var editAction: (() -> Void)?
    var deleteAction: (() -> Void)?
    
    private let stack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .color25252
        layer.cornerRadius = 12
        layer.masksToBounds = true
        
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        
        let editView = OptionMenuItemView(
            title: LS.Common.Strings.edit.localized,
            titleColor: .white,
            icon: .editIc,
            iconTint: .white
        )
        editView.action = { [weak self] in self?.editAction?() }
        
        let deleteView = OptionMenuItemView(
            title: LS.Common.Strings.delete.localized,
            titleColor: .systemRed,
            icon: .deleteIc,
            iconTint: .systemRed
        )
        deleteView.action = { [weak self] in self?.deleteAction?() }
        
        stack.addArrangedSubview(editView)
        stack.addArrangedSubview(deleteView)
        
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}


final class OptionMenuItemView: UIView {
    
    private let titleLabel = UILabel()
    private let iconView = UIImageView()
    private let button = UIButton()
    
    var action: (() -> Void)?
    
    init(title: String, titleColor: UIColor, icon: UIImage?, iconTint: UIColor) {
        super.init(frame: .zero)
        setupUI(title: title, titleColor: titleColor, icon: icon, iconTint: iconTint)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(title: String, titleColor: UIColor, icon: UIImage?, iconTint: UIColor) {
        titleLabel.text = title
        titleLabel.textColor = titleColor
        titleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        
        iconView.image = icon
        iconView.tintColor = iconTint
        iconView.contentMode = .scaleAspectFit
        
        addSubview(titleLabel)
        addSubview(iconView)
        addSubview(button) // кнопка перекрывает всё
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        iconView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview() // перекрывает всю вью
        }
        
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
    
    @objc private func tapped() {
        action?()
    }
}

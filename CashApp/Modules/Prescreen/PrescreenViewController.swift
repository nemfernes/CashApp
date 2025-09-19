//
//  PrescreenViewController.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 17.09.2025.
//

import UIKit

final class PrescreenViewController<Router: PrescreenRouter>: ViewController<PrescreenView, Router> {
	
	// MARK: - Properties
	
	// MARK: - Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		setupActions()
	}
	
	// MARK: - Private methods
	private func setupView() {

	}

	private func setupActions() {
        mainView.addAction = { [weak self] in
            guard let self else { return }
            self.router.toEditCreate()
        }
        mainView.settingAction = { [weak self] in
            guard let self else { return }
          
        }
        mainView.premAction = { [weak self] in
            guard let self else { return }
          
        }
        
	}
}

//
//  SelectDateViewController.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 18.09.2025.
//

import UIKit

final class SelectDateViewController<Router: SelectDateRouter>: ViewController<SelectDateView, Router> {
	
	// MARK: - Properties
    private var dateCompletion: ((String) -> Void)?
    
    init(dateCompletion: ((String) -> Void)?) {
        self.dateCompletion = dateCompletion
        super.init()
    }
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
        mainView.saveAction = { [weak self] date in
			guard let self else { return }
            self.dateCompletion?(date)
            self.router.close()
		}
	}
}

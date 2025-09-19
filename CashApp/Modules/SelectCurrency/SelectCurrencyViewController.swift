//
//  SelectCurrencyViewController.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 18.09.2025.
//

import UIKit

final class SelectCurrencyViewController<Router: SelectCurrencyRouter>: ViewController<SelectCurrencyView, Router> {
	
	// MARK: - Properties
    private var selectedCurrency: String?
    private var currencyCompletion: ((String) -> Void)?
    
    init(currencyCompletion: ((String) -> Void)?) {
        self.currencyCompletion = currencyCompletion
        super.init()
    }
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		setupActions()
        mainView.viewDidload()
	}
	
	// MARK: - Private methods
	private func setupView() {

	}

	private func setupActions() {
		mainView.selectAction = { [weak self] currency in
			guard let self else { return }
            self.selectedCurrency = currency
		}
        
        mainView.saveAction = { [weak self]  in
            guard let self else { return }
            guard let selectedCurrency else {
                self.router.openErrorAlert(completion: nil)
                return }
            currencyCompletion?(selectedCurrency)
            self.router.close()
        }
	}
}

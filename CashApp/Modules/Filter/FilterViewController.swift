//
//  FilterViewController.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 22.09.2025.
//

import UIKit

final class FilterViewController<Router: FilterRouter>: ViewController<FilterView, Router> {
    
    // MARK: - Properties
    private var filterCompletion: ((_ selectedType: String, _ selectedOrder: String) -> Void)?
    // MARK: - Life cycle
    
    init(filterCompletion: ((_ selectedType: String, _ selectedOrder: String) -> Void)?) {
        self.filterCompletion = filterCompletion
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActions()
    }
    
    // MARK: - Private methods
    private func setupView() {
        mainView.viewDidload()
    }
    
    private func setupActions() {
        mainView.saveAction = { [weak self] selectedType, selectedOrder in
            guard let self else { return }
            self.filterCompletion?(selectedType, selectedOrder)
            self.router.close()
        }
    }
}

//
//  DetailGoalViewController.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 20.09.2025.
//

import UIKit

final class DetailGoalViewController<Router: DetailGoalRouter>: ViewController<DetailGoalView, Router> {
	
    private var goal: Goal
	// MARK: - Properties
    init(goal: Goal) {
        self.goal = goal
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
        mainView.setupUI(goal: self.goal)
	}

	private func setupActions() {
        mainView.addSavingAction = { [weak self] in
			guard let self else { return }
            self.router.toTransaction(transactionCompletion: {
                self.mainView.setupUI(goal: self.goal)
            }, transactionType: .income, goal: self.goal)
		}
        
        mainView.withdrawAction = { [weak self] in
            guard let self else { return }
            self.router.toTransaction(transactionCompletion: {
                self.mainView.setupUI(goal: self.goal)
            }, transactionType: .withdraw, goal: self.goal)
        }
        
        mainView.backAction = { [weak self] in
            guard let self else { return }
            self.router.close()
        }
        
        mainView.optionAction = { [weak self] in
            guard let self else { return }
           
        }
	}
}

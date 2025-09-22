//
//  DetailGoalViewController.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 20.09.2025.
//

import UIKit

final class DetailGoalViewController<Router: DetailGoalRouter>: ViewController<DetailGoalView, Router>, UITableViewDataSource, UITableViewDelegate {
    
    private var goal: Goal
    private var filteredTransactions: [Transaction] = []
    private var currentType: String = ""
       private var currentOrder: String = ""
       private var isFilterApplied: Bool = false
    private weak var optionMenu: OptionMenuView?
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
        setupTableView()
        filteredTransactions = Array(goal.transactions)
    }
    
    private func setupActions() {
        mainView.addSavingAction = { [weak self] in
            guard let self else { return }
            self.router.toTransaction(transactionCompletion: {
                self.mainView.setupUI(goal: self.goal)
                self.refreshTransactions()
            }, transactionType: .income, goal: self.goal)
        }
        
        mainView.withdrawAction = { [weak self] in
            guard let self else { return }
            self.router.toTransaction(transactionCompletion: {
                self.mainView.setupUI(goal: self.goal)
                self.refreshTransactions()
            }, transactionType: .withdraw, goal: self.goal)
        }
        
        mainView.backAction = { [weak self] in
            guard let self else { return }
            self.router.close()
        }
        
        mainView.optionAction = { [weak self] in
                    guard let self else { return }
                    

                    if let menu = self.optionMenu {
                        menu.removeFromSuperview()
                        self.optionMenu = nil
                        return
                    }
                    
                    let menu = OptionMenuView()
                    menu.editAction = {
                        self.router.toEditCreate(goal: self.goal, closeCompletion: {
                            self.mainView.setupUI(goal: self.goal)
                        })
                        menu.removeFromSuperview()
                        self.optionMenu = nil
                    }
                    menu.deleteAction = {
                        DatabaseManager.shared.delete(self.goal)
                        menu.removeFromSuperview()
                        self.optionMenu = nil
                        self.router.close()
                    }
                    
                    self.view.addSubview(menu)
                    self.optionMenu = menu
                    
                    menu.snp.makeConstraints { make in
                        make.top.equalTo(self.mainView.optionButton.snp.bottom).offset(10)
                        make.trailing.equalTo(self.mainView.optionButton.snp.trailing)
                        make.width.equalTo(160)
                    }
                }
        mainView.filterAction = { [weak self] in
            guard let self else { return }
            self.router.toFilter { selectedType, selectedOrder in
                self.applyFilter(type: selectedType, order: selectedOrder)
            }
        }
    }
    
    private func setupTableView() {
        mainView.historyTableView.dataSource = self
        mainView.historyTableView.delegate = self
        mainView.historyTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        mainView.historyTableView.rowHeight = UITableView.automaticDimension
        mainView.historyTableView.estimatedRowHeight = 70
        mainView.historyTableView.register(
            UINib(nibName: "TransactionTableViewCell", bundle: nil),
            forCellReuseIdentifier: TransactionTableViewCell.reuseId
        )
    }
    
    private func applyFilter(type: String, order: String) {
          currentType = type
          currentOrder = order
          isFilterApplied = true
          
          var transactions = Array(goal.transactions)
          
          if type == LS.Common.Strings.savings.localized {
              transactions = transactions.filter { $0.type == .income }
          } else if type == LS.Common.Strings.withdraw.localized {
              transactions = transactions.filter { $0.type == .withdraw }
          }
          
          if order == LS.Common.Strings.newest.localized {
              transactions = transactions.sorted { $0.date > $1.date }
          } else if order == LS.Common.Strings.oldest.localized {
              transactions = transactions.sorted { $0.date < $1.date }
          }
          
          filteredTransactions = transactions
          mainView.reloadTableView()
      }
    
    
    private func applyCurrentFilter() {
        applyFilter(type: currentType, order: currentOrder)
    }
    
    private func refreshTransactions() {
            if isFilterApplied {
                applyFilter(type: currentType, order: currentOrder)
            } else {
                filteredTransactions = Array(goal.transactions)
                mainView.reloadTableView()
            }
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTransactions.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TransactionTableViewCell.reuseId,
            for: indexPath
        ) as? TransactionTableViewCell else {
            return UITableViewCell()
        }
        let transaction = filteredTransactions[indexPath.row]
        cell.setupUI(transaction: transaction)
        cell.optionAction = { [weak self] in
            guard let self else { return }
            self.view.subviews
                .compactMap { $0 as? OptionMenuView }
                .forEach { $0.removeFromSuperview() }
            
            let menu = OptionMenuView()
            menu.editAction = {
                self.router.toTransaction(
                    transactionCompletion: {
                        self.mainView.setupUI(goal: self.goal)
                        self.refreshTransactions()
                    },
                    transactionType: transaction.type,
                    goal: self.goal,
                    editingTransaction: transaction
                )
                menu.removeFromSuperview()
            }
            menu.deleteAction = {
                DatabaseManager.shared.update(self.goal) {
                    if let index = self.goal.transactions.firstIndex(of: transaction) {
                        self.goal.transactions.remove(at: index)
                    }
                }
                self.refreshTransactions() 
                menu.removeFromSuperview()
            }
            
            self.view.addSubview(menu)
            
            menu.snp.makeConstraints { make in
                make.top.equalTo(cell.snp.bottom).inset(35)
                make.trailing.equalTo(cell.snp.trailing)
                make.width.equalTo(160)
            }
            
        }
        return cell
    }
}



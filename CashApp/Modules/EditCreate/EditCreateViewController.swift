//
//  EditCreateViewController.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 17.09.2025.
//

import UIKit

final class EditCreateViewController<Router: EditCreateRouter>: ViewController<EditCreateView, Router>, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    private var currentGoal: Goal
    private var selectedEmoji: String?
    private var isNew: Bool
    private var emojis = ["🚗","🏖️","🎉","💻","💍"]
    // MARK: - Life cycle
    
    init(goal: Goal?) {
        if let goal {
            self.isNew = false
            self.currentGoal = goal
        } else {
            self.isNew = true
            self.currentGoal = Goal()
        }
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActions()
        setupCollectionView()
    }
    
    // MARK: - Private methods
    private func setupView() {
        
    }
    
    private func setupActions() {
        mainView.backAction = { [weak self] in
            guard let self else { return }
            self.router.close()
        }
        mainView.saveAction = { [weak self] in
            guard let self else { return }
            validateAndSave()
        }
        mainView.currencyAction = { [weak self] in
            guard let self else { return }
            self.router.toCurrency { currency in
                self.mainView.updateCurrency(currency: currency)
            }
        }
        mainView.dateAction = { [weak self] in
            guard let self else { return }
            self.router.toDatePick { date in
                self.mainView.updateDate(date: date)
            }
        }
    }
    
    func setupCollectionView() {
        guard let flowLayout = mainView.emojiCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        mainView.emojiCollectionView.allowsMultipleSelection = false
        mainView.emojiCollectionView.backgroundColor = .clear
        mainView.emojiCollectionView.dataSource = self
        mainView.emojiCollectionView.delegate = self
        mainView.emojiCollectionView.register(
            UINib(nibName: "CategoryCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseId
        )
        mainView.emojiCollectionView.register(
            UINib(nibName: "AddCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: AddCollectionViewCell.reuseId
        )
    }
    
    private func validateAndSave() {
        let name = mainView.nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let amount = mainView.amountTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let currency = mainView.currencyValueLabel.text ?? ""
        let date = mainView.dateValueLabel.text ?? ""
        
        if name.isEmpty {
            self.router.openWarningAlert(title: LS.Common.Strings.warning.localized , text: LS.Common.Strings.notAll.localized )
            return
        }
        
        if amount.isEmpty {
            self.router.openWarningAlert(title: LS.Common.Strings.warning.localized , text: LS.Common.Strings.notAll.localized )
            return
        }
        
        if currency.isEmpty || (currency == "USD" && mainView.currencyValueLabel.textColor == .color99989B) {
            self.router.openWarningAlert(title: LS.Common.Strings.warning.localized , text: LS.Common.Strings.notAll.localized )
            return
        }
        
        if date.isEmpty || date == LS.Common.Strings.december.localized {
            self.router.openWarningAlert(title: LS.Common.Strings.warning.localized , text: LS.Common.Strings.notAll.localized )
            return
        }
        
        if selectedEmoji == nil {
            self.router.openWarningAlert(title: LS.Common.Strings.warning.localized , text: LS.Common.Strings.notAll.localized )
            return
        }
        if isNew {
            currentGoal.name = name
            currentGoal.amount = Int(amount) ?? 0
            currentGoal.currency = currency
            currentGoal.date = date
            currentGoal.emoji = self.selectedEmoji ?? ""
            
            DatabaseManager.shared.add(currentGoal)
        } else {
            DatabaseManager.shared.update(currentGoal) {
                self.currentGoal.name = name
                self.currentGoal.amount = Int(amount) ?? 0
                self.currentGoal.currency = currency
                self.currentGoal.date = date
                self.currentGoal.emoji = self.selectedEmoji ?? ""
            }
        }
        
        print(DatabaseManager.shared
            .getAll(Goal.self))
        router.close()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojis.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item < emojis.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseId, for: indexPath) as! CategoryCollectionViewCell
            cell.setup(data: emojis[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddCollectionViewCell.reuseId, for: indexPath) as! AddCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item < emojis.count {
            selectedEmoji = emojis[indexPath.item]
        } else {
            collectionView.deselectItem(at: indexPath, animated: false)
            self.router.toEmoji(emojiCompletion: { emoji in
                if !self.emojis.isEmpty {
                    self.emojis[0] = emoji
                    self.selectedEmoji = emoji
                } else {
                    self.emojis.append(emoji)
                }
                DispatchQueue.main.async {
                    let firstIndexPath = IndexPath(item: 0, section: 0)
                    self.mainView.emojiCollectionView.selectItem(
                        at: firstIndexPath,
                        animated: false,
                        scrollPosition: []
                    )
                    self.collectionView(self.mainView.emojiCollectionView, didSelectItemAt: firstIndexPath)
                }
                self.mainView.emojiCollectionView.reloadData()
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 48, height: 48)
    }
}


//
//  PrescreenViewController.swift
//  CashApp
//
//  Created by Dmitry Kirpichev on 17.09.2025.
//

import UIKit
import RealmSwift

final class PrescreenViewController<Router: PrescreenRouter>: ViewController<PrescreenView, Router>, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	// MARK: - Properties
    private var goals: Results<Goal>? {
        didSet {
            mainView.reloadCollection()
        }
    }
	// MARK: - Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupActions()
        setupGoalsCollectionView()
	}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadGoals()
    }
	
	// MARK: - Private methods

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
    
    private func loadGoals() {
        goals = DatabaseManager.shared
            .getAll(Goal.self)
        
    }
    
    func setupGoalsCollectionView() {
        guard let flowLayout = mainView.goalsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 16
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        mainView.goalsCollectionView.allowsMultipleSelection = false
        mainView.goalsCollectionView.backgroundColor = .clear
        mainView.goalsCollectionView.dataSource = self
        mainView.goalsCollectionView.delegate = self
        mainView.goalsCollectionView.register(
            UINib(nibName: "GoalCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: GoalCollectionViewCell.reuseId
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goals?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoalCollectionViewCell.reuseId, for: indexPath) as! GoalCollectionViewCell
        guard let goal = goals?[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.setup(data: goal)
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let goal = goals?[indexPath.row] else {
            return
        }
        self.router.toDetail(goal: goal)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing: CGFloat = 16
        let inset: CGFloat = 16
        let totalSpacing = spacing + inset * 2
        
        let availableWidth = collectionView.bounds.width - totalSpacing
        let cellWidth = availableWidth / 2
        let cellHeight = cellWidth * 1.2
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}


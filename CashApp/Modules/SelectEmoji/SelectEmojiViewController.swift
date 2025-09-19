

import UIKit

final class SelectEmojiViewController<Router: SelectEmojiRouter>: ViewController<SelectEmojiView, Router>, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    private var emojiCompletion: ((String) -> Void)?
    private let data = EmojiData()
    private var categories: [EmojiModel] = []
    private var currentEmojis: [String] = [] {
        didSet {
            self.mainView.typeCollectionView.reloadData()
        }
    }
    
    init(emojiCompletion: ((String) -> Void)?) {
        self.emojiCompletion = emojiCompletion
        super.init()
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActions()
        setupTypeCollectionView()
        setupEmojiCollectionView()
    }
    
    // MARK: - Private methods
    private func setupView() {
        categories = data.orderedCategories
        if let first = categories.first(where: { $0.isSelected }) {
            currentEmojis = data.emojis(for: first)
        }
    }
    
    func setupTypeCollectionView() {
        guard let flowLayout = mainView.typeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        mainView.typeCollectionView.allowsMultipleSelection = false
        mainView.typeCollectionView.backgroundColor = .clear
        mainView.typeCollectionView.dataSource = self
        mainView.typeCollectionView.delegate = self
        mainView.typeCollectionView.register(
            UINib(nibName: "TypeEmojiCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: TypeEmojiCollectionViewCell.reuseId
        )
        DispatchQueue.main.async {
            let firstIndexPath = IndexPath(item: 0, section: 0)
            self.mainView.typeCollectionView.selectItem(
                at: firstIndexPath,
                animated: false,
                scrollPosition: []
            )
            self.collectionView(self.mainView.typeCollectionView, didSelectItemAt: firstIndexPath)
        }
    }
    
    func setupEmojiCollectionView() {
        guard let flowLayout = mainView.emojisCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 16
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        mainView.emojisCollectionView.allowsMultipleSelection = false
        mainView.emojisCollectionView.backgroundColor = .clear
        mainView.emojisCollectionView.dataSource = self
        mainView.emojisCollectionView.delegate = self
        mainView.emojisCollectionView.register(
            UINib(nibName: "EmojiCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: EmojiCollectionViewCell.reuseId
        )
    }
    
    private func setupActions() {
        mainView.defaultAction = { [weak self] in
            guard let self else { return }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainView.typeCollectionView {
            return categories.count
        } else {
            return currentEmojis.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainView.typeCollectionView {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TypeEmojiCollectionViewCell.reuseId,
                for: indexPath
            ) as! TypeEmojiCollectionViewCell
            let category = categories[indexPath.item]
            cell.setup(data: category)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: EmojiCollectionViewCell.reuseId,
                for: indexPath
            ) as! EmojiCollectionViewCell
            cell.setup(data: currentEmojis[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == mainView.typeCollectionView {
            for i in categories.indices {
                categories[i].isSelected = (i == indexPath.item)
            }
            
            let selected = categories[indexPath.item]
            currentEmojis = data.emojis(for: selected)
            mainView.emojisCollectionView.reloadData()
        } else {
            let selectedEmoji = currentEmojis[indexPath.item]
            emojiCompletion?(selectedEmoji)
            router.close()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 33, height: 33)
    }
}

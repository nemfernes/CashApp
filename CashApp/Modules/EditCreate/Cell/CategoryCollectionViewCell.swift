
import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 24
            containerView.layer.borderColor = UIColor.color2B6CF0.cgColor
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    static let reuseId = "CategoryCollectionViewCell"
    
    override var isSelected: Bool {
        didSet {
            containerView.layer.borderWidth = isSelected ? 2 : 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.backgroundColor = .color1F1F21
    }
    
    func setup(data: String) {
        self.titleLabel.text = data
    }
    
}

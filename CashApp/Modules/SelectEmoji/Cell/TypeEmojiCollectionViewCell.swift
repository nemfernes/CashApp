
import UIKit

class TypeEmojiCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!  {
        didSet {
            titleLabel.textColor = .white
            titleLabel.font = .urbanistSemiBold14
        }
    }
    @IBOutlet weak var titleImageView: UIImageView!
    static let reuseId = "TypeEmojiCollectionViewCell"
    
    override var isSelected: Bool {
        didSet {
            containerView.backgroundColor = isSelected ? .color2B6CF0 : .color1F1F21
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 12
        containerView.backgroundColor = .color1F1F21
    }

    
    func setup(data: EmojiModel) {
        titleLabel.text = data.title
        containerView.backgroundColor = data.isSelected ? .color2B6CF0 : .color1F1F21
    }
    
}

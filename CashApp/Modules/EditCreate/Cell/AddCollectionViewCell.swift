
import UIKit

class AddCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.image  = .addIcon
        }
    }
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 24
            containerView.layer.borderWidth = 2
            containerView.layer.borderColor = UIColor.color3A3A3A.cgColor
        }
    }
    static let reuseId = "AddCollectionViewCell"
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.backgroundColor = .color1F1F21
    }
    
}

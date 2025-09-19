
import UIKit

class EmojiCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    static let reuseId = "EmojiCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    
    func setup(data: String) {
        self.titleLabel.text = data
    }
    
}

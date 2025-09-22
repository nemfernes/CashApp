
import UIKit

class GoalCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var emojiLabel: UILabel! {
        didSet {
            emojiLabel.font = .systemFont(ofSize: 40)
        }
    }
    @IBOutlet weak var bannerView: CircleProgressView!
    @IBOutlet weak var remainedCounterLabel: UILabel!  {
        didSet {
            remainedCounterLabel.setup(text: LS.Common.Strings.december.localized, textColor: .color99989B, font: .urbanistMedium12, textAlignment: .center, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var savedCounterLabel: UILabel!  {
        didSet {
            savedCounterLabel.setup(text: LS.Common.Strings.december.localized, textColor: .color99989B, font: .urbanistMedium12, textAlignment: .center, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var totalPriceLabel: UILabel!   {
        didSet {
            totalPriceLabel.setup(text: LS.Common.Strings.december.localized, textColor: .color99989B, font: .urbanistMedium14, textAlignment: .center, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var titleLabel: UILabel!  {
        didSet {
            titleLabel.setup(text: "", textColor: .white, font: .urbanistMedium20, textAlignment: .center, adjustWidth: true, numberOfLines: 1)
        }
    }
    static let reuseId = "GoalCollectionViewCell"

    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 12
        containerView.backgroundColor = .color1F1F21
        
       
        bannerView.backgroundColor = .clear
               bannerView.lineWidth = 12
               bannerView.progressColor = .systemBlue
               bannerView.trackColor = UIColor(white: 0.2, alpha: 1)
    }
        
    func setup(data: Goal) {
        titleLabel.text = data.name
        totalPriceLabel.text = "$\(data.amount)"
        remainedCounterLabel.text =  "$\(data.remaining)"
        savedCounterLabel.text =  "$\(data.accumulated)"
        bannerView.progress = data.progress
        bannerView.progressColor = data.uiColor
        emojiLabel.text = data.emoji
    }

    
}

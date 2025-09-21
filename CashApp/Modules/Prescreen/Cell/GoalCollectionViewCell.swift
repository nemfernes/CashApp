
import UIKit

class GoalCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var bannerView: CircleProgressView!
    @IBOutlet weak var remainedCounterLabel: UILabel!
    @IBOutlet weak var savedCounterLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
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
        
        let saved = 100
        let total = 150
        let remained = max(total - saved, 0)
        
        savedCounterLabel.text = "$\(Int(saved))"
        remainedCounterLabel.text = "$\(Int(remained))"
        
        bannerView.progress = 0.3
        if total > 0 {
                bannerView.progress = CGFloat(saved) / CGFloat(total)
            }
    }

    
}

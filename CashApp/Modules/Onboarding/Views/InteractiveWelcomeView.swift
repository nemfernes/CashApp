import UIKit

enum IntroPage {
    case first
    case second
    case third
}


class InteractiveWelcomeView: NibView {
    
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.textColor = .color99989B
            subtitleLabel.font = .urbanistMedium16
            subtitleLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = .white
            titleLabel.font = .urbanistBold24
            titleLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var containerView: UIView!
    
    let data = OnboardingData.data
    public var currentStep: IntroPage = .first
    
    func setup(step: IntroPage) {
        self.backgroundColor = .color151718
        currentStep = step
        let index: Int
        switch step {
        case .first: index = 0
        case .second: index = 1
        case .third: index = 2
        }
        
        let item = data[index]
        UIView.transition(with: titleImageView, duration: 0.3, options: .transitionCrossDissolve) {
            self.titleImageView.image = item.image
        }
        
        UIView.transition(with: titleLabel, duration: 0.3, options: .transitionCrossDissolve) {
            self.titleLabel.text = item.title
        }
        
        UIView.transition(with: subtitleLabel, duration: 0.3, options: .transitionCrossDissolve) {
            self.subtitleLabel.text = item.subtitle
        }
    }
}

import UIKit

final class PrescreenView: UIView {
	
	// MARK: - Outlets
	
    @IBOutlet weak var goalsCollectionView: UICollectionView!
    @IBOutlet weak var addMoreButton: UIButton!  {
        didSet {
            addMoreButton.addTarget(self, action: #selector(addDidTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var defaultSubtitleLabel: UILabel!  {
        didSet {
            defaultSubtitleLabel.setup(text: LS.Common.Strings.setUr.localized, textColor: .white, font: .urbanistMedium16, textAlignment: .center, adjustWidth: true, numberOfLines: 2)
        }
    }
    @IBOutlet weak var defaultTitleLabel: UILabel!   {
        didSet {
            defaultTitleLabel.setup(text: LS.Common.Strings.beginBuilding.localized, textColor: .white, font: .urbanistBold24, textAlignment: .center, adjustWidth: true, numberOfLines: 2)
        }
    }
    @IBOutlet weak var setGoalButton: CenterTextButton! {
        didSet {
            
            setGoalButton.addTarget(self, action: #selector(addDidTapped), for: .touchUpInside)
            setGoalButton.clipsToBounds = true
            setGoalButton.layer.cornerRadius = 16
            setGoalButton.backgroundColor = .color2B6CF0
            setGoalButton.setTitleColor(.white, for: .normal)
            setGoalButton.titleLabel?.font = .urbanistSemiBold16
            setGoalButton.titleLabel?.adjustsFontSizeToFitWidth = true
            setGoalButton.titleLabel?.minimumScaleFactor = 0.3
            setGoalButton.configure(title: LS.Common.Strings.setUrButton.localized, image: .addIcon)
        }
    }
    
    @IBOutlet weak var defaultImageView: UIImageView! {
        didSet {
            defaultImageView.image = .goal
        }
    }
    
    @IBOutlet weak var defaultView: UIView!
    @IBOutlet weak var settingsButton: UIButton! {
        didSet {
            settingsButton.setImage(.settingIc, for: .normal)
            settingsButton.addTarget(self, action: #selector(settingDidTapped), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!  {
        didSet {
            titleLabel.setup(text: LS.Common.Strings.savingsTracker.localized, textColor: .white, font: .urbanistSemiBold20, textAlignment: .center, adjustWidth: true, numberOfLines: 2)
        }
    }
    @IBOutlet weak var premButton: UIButton! {
        didSet {
            premButton.setImage(.premiumIc, for: .normal)
            premButton.addTarget(self, action: #selector(premDidTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var navigationView: UIView! {
        didSet {
            navigationView.backgroundColor = UIColor.color1F1F21
        }
    }
    
	// MARK: - Actions
	public var addAction: (() -> Void)?
    public var premAction: (() -> Void)?
    public var settingAction: (() -> Void)?
	
	// MARK: - Life cycle
	override func layoutSubviews() {
		super.layoutSubviews()
        self.backgroundColor = .color151718
	}
	
	// MARK: - Private methods
	
	// MARK: - Objc methods
	@objc private func addDidTapped() {
        addAction?()
	}
    
    @objc private func premDidTapped() {
        premAction?()
    }
	
    @objc private func settingDidTapped() {
        settingAction?()
    }
    
    public func reloadCollection(with goalsCount: Int) {
        goalsCollectionView.reloadData()
        defaultView.isHidden = goalsCount > 0
        addMoreButton.isHidden = goalsCount == 0
        goalsCollectionView.isHidden = goalsCount == 0
    }
    
    public func updatePremium() {
        premButton.isHidden = UserDefaults.premium
    }
}


import UIKit

final class CommonPremiumView: UIView {

    @IBOutlet weak var yearButton: UIButton!  {
        didSet {
            yearButton.addTarget(self, action: #selector(yearTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var monthButton: UIButton!   {
        didSet {
            monthButton.addTarget(self, action: #selector(monthTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var yearSubtitleLabel: UILabel!  {
        didSet {
            yearSubtitleLabel.setup(text: LS.Common.Strings.bestPrice.localized, textColor: .color99989B, font: .urbanistRegular14, textAlignment: .left, adjustWidth: true, numberOfLines: 2)
        }
    }
    @IBOutlet weak var yearTitleLabel: UILabel! {
        didSet {
            yearTitleLabel.setup(text: LS.Common.Strings.yearly.localized, textColor: .white, font: .urbanistMedium20, textAlignment: .left, adjustWidth: true, numberOfLines: 2)
        }
    }
    @IBOutlet weak var yearPriceLabel: UILabel! {
        didSet {
            yearPriceLabel.setup(text: "", textColor: .white, font: .urbanistMedium20, textAlignment: .right, adjustWidth: true, numberOfLines: 2)
        }
    }
    @IBOutlet weak var yearView: UIView!  {
        didSet {
            yearView.layer.cornerRadius = 16
        }
    }
    @IBOutlet weak var monthSubtitleLabel: UILabel!  {
        didSet {
            monthSubtitleLabel.setup(text: LS.Common.Strings.noPayments.localized, textColor: .color99989B, font: .urbanistRegular14, textAlignment: .left, adjustWidth: true, numberOfLines: 2)
        }
    }
    @IBOutlet weak var monthTitleLabel: UILabel!  {
        didSet {
            monthTitleLabel.setup(text: LS.Common.Strings.days3.localized, textColor: .white, font: .urbanistMedium20, textAlignment: .left, adjustWidth: true, numberOfLines: 2)
        }
    }
    @IBOutlet weak var monthPriceLabel: UILabel!  {
        didSet {
            monthPriceLabel.setup(text: "", textColor: .white, font: .urbanistMedium20, textAlignment: .right, adjustWidth: true, numberOfLines: 2)
        }
    }
    @IBOutlet weak var monthView: UIView!  {
        didSet {
            monthView.layer.cornerRadius = 16
        }
    }
    @IBOutlet weak var backgroundImageView: UIImageView! {
        didSet {
            backgroundImageView.image = .premiumBackground
        }
    }
    @IBOutlet weak var titleLabel: UILabel!  {
        didSet {
            titleLabel.setup(text: LS.Common.Strings.goPremium.localized, textColor: .white, font: .urbanistBold24, textAlignment: .center, adjustWidth: true, numberOfLines: 2)
        }
    }
    
    @IBOutlet weak var benefit3Label: UILabel! {
        didSet {
            benefit3Label.setup(text: LS.Common.Strings.fullHistory.localized, textColor: .white, font: .urbanistMedium16, textAlignment: .left, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var benefit2Label: UILabel! {
        didSet {
            benefit2Label.setup(text: LS.Common.Strings.advancedStatistics.localized, textColor: .white, font: .urbanistMedium16, textAlignment: .left, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var benefit1Label: UILabel!  {
        didSet {
            benefit1Label.setup(text: LS.Common.Strings.unlimitedSaving.localized, textColor: .white, font: .urbanistMedium16, textAlignment: .left, adjustWidth: true, numberOfLines: 1)
        }
    }
    @IBOutlet weak var closeButton: UIButton!    {
        didSet {
            closeButton.setImage(.closeIc, for: .normal)
            closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var continueButton: UIButton!  {
        didSet {
            continueButton.setTitle(LS.Common.Strings.continue.localized.uppercased(), for: .normal)
            continueButton.setTitleColor(.white, for: .normal)
            continueButton.titleLabel?.font = .urbanistSemiBold16
            continueButton.backgroundColor = .color2B6CF0
            continueButton.layer.cornerRadius = 28
            continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        }
    }
    public var closeAction: (() -> Void)?
    public var continueAction: (() -> Void)?
	public var productAction: ((_ product: PremiumButtonType) -> Void)?

	// MARK: - Public methods
	
	
	@objc private func yearTapped() {
        productAction?(.year)
        setupUI(product: .year)
	}
    
    @objc private func continueTapped() {
        continueAction?()
    }
	
	@objc private func monthTapped() {
        productAction?(.month)
        setupUI(product: .month)
	}
    
    @objc private func closeTapped() {
        closeAction?()
    }
	
    func setupUI(product: PremiumButtonType) {
        switch product {
        case .month:
            monthView.layer.borderColor = UIColor.asset(.color_2B6CF0).cgColor
            monthView.layer.borderWidth = 1
            monthView.backgroundColor = UIColor.asset(.color_2B6CF0).withAlphaComponent(0.1)
            
            yearView.layer.borderWidth = 0
            yearView.backgroundColor = .color1F1F21
            
            continueButton.setTitle(LS.Common.Strings.continueFree.localized, for: .normal)
        case .year:
            yearView.layer.borderColor = UIColor.asset(.color_2B6CF0).cgColor
            yearView.layer.borderWidth = 1
            yearView.backgroundColor = UIColor.asset(.color_2B6CF0).withAlphaComponent(0.1)
            
            monthView.layer.borderWidth = 0
            monthView.backgroundColor = .color1F1F21
            
            continueButton.setTitle(LS.Common.Strings.continue.localized, for: .normal)
        }
    }
    
    func setPrice(product: PremiumButtonType, sub: MySubscription) {
        switch product {
        case .month:
            monthPriceLabel.text = String(format: LS.Common.Strings.slashMonth.localized, sub.localizedPrice)
        case .year:
            yearPriceLabel.text = String(format: LS.Common.Strings.slashYear.localized, sub.localizedPrice)
        }
    }
}

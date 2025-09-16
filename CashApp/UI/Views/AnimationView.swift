
import UIKit
import Lottie

public enum AnimationType {
	case splash, generate
	
	var name: String {
		switch self {
		case .splash:
			return "splashAnimation"
		case .generate:
			return "generateAnimation"
		}
	}
	
}

final public class MyAnimationView: UIView {
	private let animationView = LottieAnimationView()
			
	public func configAnimation(with type: AnimationType, loopMode: LottieLoopMode = .autoReverse, speed: CGFloat = 1, padding: CGFloat = 0) {
		animationView.animation = LottieAnimation.named(type.name)
		animationView.animationSpeed = speed
		animationView.loopMode = loopMode
		
		self.backgroundColor = .clear
		self.addSubview(animationView)
		
		animationView.translatesAutoresizingMaskIntoConstraints = false
		animationView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding).isActive = true
		animationView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding).isActive = true
		animationView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding).isActive = true
		animationView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding).isActive = true
		animationView.play()
	}
	
	public func stop() {
		animationView.stop()
	}
	
	public func start() {
		animationView.play()
	}

}

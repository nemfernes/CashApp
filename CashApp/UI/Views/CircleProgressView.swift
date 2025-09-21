import UIKit

final class CircleProgressView: UIView {
    
    private let backgroundLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    
    /// Текущее значение (0...1)
    var progress: CGFloat = 0 {
        didSet {
            setProgress(progress, animated: true)
        }
    }
    
    /// Толщина линии
    var lineWidth: CGFloat = 12 {
        didSet { updatePath() }
    }
    
    /// Цвет прогресса
    var progressColor: UIColor = .systemBlue {
        didSet { progressLayer.strokeColor = progressColor.cgColor }
    }
    
    /// Цвет заднего фона
    var trackColor: UIColor = UIColor(white: 0.2, alpha: 1) {
        didSet { backgroundLayer.strokeColor = trackColor.cgColor }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    private func setupLayers() {
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(progressLayer)
        
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.strokeColor = trackColor.cgColor
        backgroundLayer.lineCap = .round
        backgroundLayer.lineWidth = lineWidth
        
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = lineWidth
        progressLayer.strokeEnd = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePath()
    }
    
    private func updatePath() {
        let centerPoint = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - lineWidth / 2
        
        // ✅ дуга сверху, снизу пусто (как на картинке)
        let startAngle = CGFloat.pi * 0.75    // 135° (слева-снизу)
        let endAngle = CGFloat.pi * 2.25      // 405° (справа-снизу)
        
        let circularPath = UIBezierPath(arcCenter: centerPoint,
                                        radius: radius,
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: true)
        
        backgroundLayer.path = circularPath.cgPath
        backgroundLayer.lineWidth = lineWidth
        
        progressLayer.path = circularPath.cgPath
        progressLayer.lineWidth = lineWidth
    }

    
    private func setProgress(_ progress: CGFloat, animated: Bool) {
        let clamped = max(0, min(progress, 1))
        if animated {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = progressLayer.strokeEnd
            animation.toValue = clamped
            animation.duration = 0.25
            progressLayer.strokeEnd = clamped
            progressLayer.add(animation, forKey: "progress")
        } else {
            progressLayer.strokeEnd = clamped
        }
    }
}

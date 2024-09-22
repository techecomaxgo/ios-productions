//
//  ExtensionUI.swift
//  Olive
//
//  Created by india on 03/11/23.
//

import UIKit

extension CALayer {
    func applyCornerRadiusShadow(
        color: UIColor = .lightGray,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0,
        cornerRadiusValue: CGFloat = 9)
    {
        cornerRadius = cornerRadiusValue
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    func applyCornerRadiusShadowGreen(
        color: UIColor = UIColor(hexString: "9FC438"),
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 7,
        spread: CGFloat = 0,
        cornerRadiusValue: CGFloat = 9)
    {
        cornerRadius = cornerRadiusValue
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

extension UIColor {
    convenience init(hexString: String) {
            let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int = UInt64()
            Scanner(string: hex).scanHexInt64(&int)
            let a, r, g, b: UInt64
            switch hex.count {
            case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (255, 0, 0, 0)
            }
            self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
        }
    }
extension String {
    func chopPrefix(_ count: Int = 1) -> String {
        return substring(from: index(startIndex, offsetBy: count))
    }

    func chopSuffix(_ count: Int = 1) -> String {
        return substring(to: index(endIndex, offsetBy: -count))
    }
}
extension UIImageView {
  func setImageColors(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
@IBDesignable
class ShadowedView: UIView {

    @IBInspectable var shadowColor: UIColor = .black {
        didSet { layer.shadowColor = shadowColor.cgColor }
    }

    @IBInspectable var shadowOpacity: Float = 0.5 {
        didSet { layer.shadowOpacity = shadowOpacity }
    }

    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 5) {
        didSet { layer.shadowOffset = shadowOffset }
    }

    @IBInspectable var shadowRadius: CGFloat = 5 {
        didSet { layer.shadowRadius = shadowRadius }
    }
    
    @IBInspectable override var borderWidth: CGFloat {
        didSet {
            self.layer.borderWidth = self.borderWidth
            // self.layer.masksToBounds = self.borderWidth > 0
        }
    }
    @IBInspectable override var cornerRadius: CGFloat {
        didSet{
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    @IBInspectable var borderCColor:UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1){
        didSet{
            self.layer.borderColor = self.borderColor?.cgColor
        }
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = false
    }
}
@IBDesignable
class CustomGradientSegmentedControl: UISegmentedControl {

    @IBInspectable var selectedGradientColors: [UIColor] = [UIColor.red, UIColor.blue] {
        didSet {
            updateSelectedSegmentColor()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateSelectedSegmentColor()
    }

    func updateSelectedSegmentColor() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = selectedGradientColors.map { $0.cgColor }
        gradientLayer.cornerRadius = 5 // Optional: Add corner radius if needed
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
    }
}

@IBDesignable
class ShadowedViewGreen: UIView {

    @IBInspectable var shadowColor: UIColor = .green {
        didSet { updateShadow() }
    }

    @IBInspectable var shadowOpacity: Float = 0.5 {
        didSet { updateShadow() }
    }

    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 5) {
        didSet { updateShadow() }
    }

    @IBInspectable var shadowRadius: CGFloat = 5 {
        didSet { updateShadow() }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateShadow()
    }

    private func updateShadow() {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
    }
}
extension UIView {

  // OUTPUT 1
  func dropShadowShow(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.green.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowOffset = CGSize(width: -1, height: 1)
    layer.shadowRadius = 1

    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }

  // OUTPUT 2
  func dropShadowShow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius
    layer.backgroundColor = UIColor.clear.cgColor
    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
    
    
    func dropLeaderShadow(scale: Bool = true) {
      layer.masksToBounds = false
      layer.shadowColor = UIColor.lightGray.cgColor
      layer.shadowOpacity = 0.5
      layer.shadowOffset = CGSize(width: 1, height: 2)
      layer.shadowRadius = 1


    }

    
}
enum VerticalLocation: String {
    case bottom
    case top
}

extension UIView {
    func addShadow(location: VerticalLocation, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        switch location {
        case .bottom:
             addShadow(offset: CGSize(width: 0, height: 5), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -5), color: color, opacity: opacity, radius: radius)
        }
    }

    func addShadow(offset: CGSize, color: UIColor = .lightGray, opacity: Float = 0.2, radius: CGFloat = 2.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }

    
    func roundCornersNew(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
//        self.addShadow(offset: CGSize(width: 0, height: 4), color: .grey, opacity: 0.5, radius: 4)
        
        self.layer.cornerRadius = radius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius)
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowPath = shadowPath.cgPath
        
        
    }
}


extension UIView {
    public func addViewBorder(borderColor:CGColor,borderWith:CGFloat,borderCornerRadius:CGFloat){
        self.layer.borderWidth = borderWith
        self.layer.borderColor = borderColor
        self.layer.cornerRadius = borderCornerRadius

    }
}


extension UIView {

    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

//@IBDesignable extension UIButton {
//    @IBInspectable var borderWidth: CGFloat {
//        set {
//            layer.borderWidth = newValue
//        }
//        get {
//            return layer.borderWidth
//        }
//    }
//    @IBInspectable var cornerRadius: CGFloat {
//        set {
//            layer.cornerRadius = newValue
//        }
//        get {
//            return layer.cornerRadius
//        }
//    }
//    @IBInspectable var borderColor: UIColor? {
//        set {
//            guard let uiColor = newValue else { return }
//            layer.borderColor = uiColor.cgColor
//        }
//        get {
//            guard let color = layer.borderColor else { return nil }
//            return UIColor(cgColor: color)
//        }
//    }
//}

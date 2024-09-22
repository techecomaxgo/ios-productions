import UIKit

@IBDesignable

class DesignableView: UIView {
    @IBInspectable var cornerRRadius: CGFloat = 0
    @IBInspectable var borderWWidth: CGFloat = 0
    @IBInspectable var borderCColor:UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1){
        didSet{
            self.layer.borderColor = self.borderCColor.cgColor
        }
    }
    
    @IBInspectable var addShadow:Bool = true{
        
        didSet(newValue) {
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.lightGray.cgColor
            self.layer.shadowOpacity = 0.5
            self.layer.shadowOffset = CGSize(width: 2, height: 3)
            self.layer.shadowRadius = 3
            
            self.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale =  UIScreen.main.scale
            print("trying to use shadow")
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        
    }
}


class DesignableButton: UIButton {
    @IBInspectable var cornerRRadius: CGFloat = 0
    @IBInspectable var borderWWidth: CGFloat = 0
    
    @IBInspectable var addShadow:Bool = true{
        
        didSet(newValue) {
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.lightGray.cgColor
            self.layer.shadowOpacity = 0.5
            self.layer.shadowOffset = CGSize(width: 2, height: 3)
            self.layer.shadowRadius = 3
            
            self.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale =  UIScreen.main.scale
            print("trying to use shadow")
        }
    }
    
    @IBInspectable var borderCColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        // layer.borderColor = borderColor
    }
}


class DesignableTextField: UITextField {
  @IBInspectable var cornerRRadius: CGFloat = 0
  @IBInspectable var borderWWidth: CGFloat = 0
    @IBInspectable var borderCColor: CGColor = UIColor(hexString: "9FC438").cgColor
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = cornerRRadius
    layer.borderWidth = borderWWidth
    layer.borderColor = borderCColor
  }
}
class TextFieldDesignable: UITextField {
  @IBInspectable var cornerRRadius: CGFloat = 0
  @IBInspectable var borderWWidth: CGFloat = 0
  @IBInspectable var borderCColor: CGColor = UIColor.black.cgColor
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = cornerRadius
    layer.borderWidth = borderWWidth
    layer.borderColor = borderCColor
  }
}

class DesignableImageView: UIImageView {
    @IBInspectable var cornerRRadius: CGFloat = 0
    @IBInspectable var borderWWidth: CGFloat = 0
    @IBInspectable var borderCColor: CGColor = UIColor.black.cgColor
    
    @IBInspectable var addShadow:Bool = true{
        
        didSet(newValue) {
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.lightGray.cgColor
            self.layer.shadowOpacity = 0.5
            self.layer.shadowOffset = CGSize(width: 2, height: 3)
            self.layer.shadowRadius = 3
            
            self.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale =  UIScreen.main.scale
            print("trying to use shadow")
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderCColor
    }
}
extension UIImageView {
  func setImageColorTint(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}

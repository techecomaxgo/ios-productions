//
//  CardView.swift
//  MaxPay
//
//  Created by Ios Developer on 10/01/24.
//

//import UIKit
//
// @IBDesignable private class CardView: UIView {
//    
//    @IBInspectable var cornerRadius: CGFloat = 2
//    
//    @IBInspectable var shadowOffsetWidth: Int = 0
//    @IBInspectable var shadowOffsetHeight: Int = 3
//    @IBInspectable var shadowColor: UIColor? = UIColor.black
//    @IBInspectable var shadowOpacity: Float = 0.5
//    
//    override func layoutSubviews() {
//        layer.cornerRadius = cornerRadius
//        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
//        
//        layer.masksToBounds = false
//        layer.shadowColor = shadowColor?.cgColor
//        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
//        layer.shadowOpacity = shadowOpacity
//        layer.shadowPath = shadowPath.cgPath
//    }
//}


import UIKit

@IBDesignable class CardView: UIView {
    
    @IBInspectable override var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.5
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
}

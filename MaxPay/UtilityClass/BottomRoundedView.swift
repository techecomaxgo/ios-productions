//
//  BottomRoundedView.swift
//  MaxPay
//
//  Created by Ios Developer on 11/01/24.
//

import UIKit

class BottomRoundedView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Add rounded corners to bottom two corners
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10.0, height: 10.0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
        
        // Add bottom shadow
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 4
    }
}

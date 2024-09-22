//
//  DonutChartView.swift
//  MaxPay
//
//  Created by Admin on 30/08/24.
//

import Foundation
import UIKit

class DonutChartView: UIView {
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius: CGFloat = min(bounds.width, bounds.height) / 2 - 10
        let lineWidth: CGFloat = 20
        let totalAmount: CGFloat = 27500
        let spentAmount: CGFloat = 25000
        let spentPercentage = spentAmount / totalAmount
        
        // Draw the full circle
        context.setLineWidth(lineWidth)
        context.setStrokeColor(UIColor.lightGray.cgColor)
        context.addArc(center: center, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: false)
        context.strokePath()
        
        // Draw the spent part
        let startAngle: CGFloat = -.pi / 2
        let endAngle: CGFloat = startAngle + .pi * 2 * spentPercentage
        context.setStrokeColor(UIColor.systemOrange.cgColor) // Choose your spent color
        context.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        context.strokePath()
    }
}

//
//  DonutChartViewss.swift
//  MaxPay
//
//  Created by Admin on 01/09/24.
//

import Foundation
import UIKit


class DonutChartViewss: UIView {

    private let segmentColors: [UIColor] = [
        UIColor(red: 0.93, green: 0.58, blue: 0.13, alpha: 1.00), // Orange
        UIColor(red: 0.74, green: 0.87, blue: 0.66, alpha: 1.00), // Light Green
        UIColor(red: 0.83, green: 0.73, blue: 0.87, alpha: 1.00), // Light Purple
        UIColor(red: 0.92, green: 0.59, blue: 0.57, alpha: 1.00), // Light Red
        UIColor(red: 0.78, green: 0.87, blue: 0.92, alpha: 1.00), // Light Blue
        UIColor(red: 0.93, green: 0.92, blue: 0.65, alpha: 1.00), // Light Yellow
    ]

    let segmentStartEndAngles: [(start: CGFloat, end: CGFloat)] = [
        (start: -.pi / 2, end: -.pi / 2 + 0.12 * 2 * .pi),  // Light Yellow (~12%)
        (start: -.pi / 2 + 0.12 * 2 * .pi, end: -.pi / 2 + 0.18 * 2 * .pi), // Orange (~6%)
        (start: -.pi / 2 + 0.18 * 2 * .pi, end: -.pi / 2 + 0.30 * 2 * .pi), // Light Green (~12%)
        (start: -.pi / 2 + 0.30 * 2 * .pi, end: -.pi / 2 + 0.40 * 2 * .pi), // Light Blue (~10%)
        (start: -.pi / 2 + 0.40 * 2 * .pi, end: -.pi / 2 + 0.70 * 2 * .pi), // Light Red (~30%)
        (start: -.pi / 2 + 0.70 * 2 * .pi, end: -.pi / 2 + 2.0 * .pi)       // Light Purple (~30%)
    ]

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .white
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius: CGFloat = min(bounds.width, bounds.height) / 2 - 20
        let lineWidth: CGFloat = 35

        for (index, color) in segmentColors.enumerated() {
            context.setStrokeColor(color.cgColor)
            context.setLineWidth(lineWidth)

            let startAngle = segmentStartEndAngles[index].start
            let endAngle = segmentStartEndAngles[index].end
            context.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            context.strokePath()
        }

        let innerCircleRadius = radius - lineWidth / 1.3 + 2.5
        let innerCirclePath = UIBezierPath(arcCenter: center, radius: innerCircleRadius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        UIColor.white.setFill()
        innerCirclePath.fill()

        let innerLabel = UILabel()
        innerLabel.numberOfLines = 2
        innerLabel.textAlignment = .center
        
        let attributedText = NSMutableAttributedString(string: "Total Limit\n", attributes: [
            .font: UIFont.systemFont(ofSize: 12, weight: .regular), // Reduced font size
            .foregroundColor: UIColor.darkGray
        ])
        
        attributedText.append(NSAttributedString(string: "₹27,500", attributes: [
            .font: UIFont.systemFont(ofSize: 16, weight: .bold), // Reduced font size
            .foregroundColor: UIColor.black
        ]))
        
        innerLabel.attributedText = attributedText

        innerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        innerLabel.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        innerLabel.layer.cornerRadius = innerCircleRadius * 0.9 // Reduced radius for less space
        innerLabel.layer.masksToBounds = true
        
        addSubview(innerLabel)

        NSLayoutConstraint.activate([
            innerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            innerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            innerLabel.widthAnchor.constraint(equalToConstant: innerCircleRadius * 2 * 0.9),
            innerLabel.heightAnchor.constraint(equalToConstant: innerCircleRadius * 2 * 0.9)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = min(self.bounds.width, self.bounds.height) / 2
        self.layer.masksToBounds = true
    }
}

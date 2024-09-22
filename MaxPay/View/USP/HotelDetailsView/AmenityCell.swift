//
//  AmenityCell.swift
//  MaxPay
//
//  Created by Admin on 04/06/24.
//


import UIKit

class AmenityCell: UICollectionViewCell {
    
    static let reuseIdentifier = "AmenityCell"

    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        contentView.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

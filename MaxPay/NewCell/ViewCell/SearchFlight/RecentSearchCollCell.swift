//
//  RecentSearchCollCell.swift
//  MaxPay
//
//  Created by india on 24/11/23.
//

import UIKit

class RecentSearchCollCell: UICollectionViewCell {
    
    @IBOutlet weak var vwBack: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        vwBack.layer.applyCornerRadiusShadowGreen()
        vwBack.layer.cornerRadius = 4
        vwBack.layer.borderColor = UIColor(hexString: "9FC438").cgColor
        vwBack.layer.borderWidth = 1
    }
    
}

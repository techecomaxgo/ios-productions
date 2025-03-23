//
//  CollBhimUPICell.swift
//  MaxPay
//
//  Created by india on 13/11/23.
//

import UIKit

class CollBhimUPICell: UICollectionViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgBhim: UIImageView!
    @IBOutlet weak var vwBack: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vwBack.layer.cornerRadius = 8
        vwBack.clipsToBounds = true
        vwBack.layer.applyCornerRadiusShadow()
        
    }
}

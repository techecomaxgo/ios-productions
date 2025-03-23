//
//  PayBillListCollCell.swift
//  MaxPay
//
//  Created by india on 20/11/23.
//

import UIKit

class PayBillListCollCell: UICollectionViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    func configure(with item: CategoryItem) {
        lblName.text = item.name
        img.image = UIImage(named: item.imageName) // Image from Assets
        }
    
}

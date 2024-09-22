//
//  BhimUPITrasactionCompletedListCell.swift
//  MaxPay
//
//  Created by india on 14/11/23.
//

import UIKit

class BhimUPITrasactionCompletedListCell: UITableViewCell {

    @IBOutlet weak var vwBack: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vwBack.layer.applyCornerRadiusShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

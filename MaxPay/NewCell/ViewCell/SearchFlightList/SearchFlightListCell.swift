//
//  SearchFlightListCell.swift
//  MaxPay
//
//  Created by india on 24/11/23.
//

import UIKit

class SearchFlightListCell: UITableViewCell {

    @IBOutlet weak var vwBack: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        vwBack.layer.applyCornerRadiusShadow()
        vwBack.layer.cornerRadius = 4
        vwBack.layer.borderColor = UIColor.gray.cgColor
        vwBack.layer.borderWidth = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

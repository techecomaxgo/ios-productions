//
//  MilesTableViewCell.swift
//  MaxPay
//
//  Created by Ios Developer on 28/05/24.
//

import UIKit

class MilesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblAmountpaid: UILabel!
    
    @IBOutlet weak var lblforpaid: UILabel!
    
    @IBOutlet weak var lblMiles: UILabel!
    
    
    @IBOutlet weak var btnEncash: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

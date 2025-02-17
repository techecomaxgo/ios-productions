//
//  BillsTableViewCell.swift
//  MaxPay
//
//  Created by Admin on 29/01/25.
//

import UIKit

class BillsTableViewCell: UITableViewCell {

   
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var btnFastTag: UIButton!
    @IBOutlet weak var btnDTH: UIButton!
    @IBOutlet weak var btnBroadband: UIButton!
    @IBOutlet weak var btnWeather: UIButton!
    @IBOutlet weak var btnGas: UIButton!
    @IBOutlet weak var btnCrreditCard: UIButton!
    @IBOutlet weak var btnElectaricity: UIButton!
    @IBOutlet weak var btnMobileRecharge: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

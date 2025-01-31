//
//  TravelTableViewCell.swift
//  MaxPay
//
//  Created by Admin on 29/01/25.
//

import UIKit

class TravelTableViewCell: UITableViewCell {

    @IBOutlet weak var btnBus: UIButton!
    @IBOutlet weak var btnFlight: UIButton!
    @IBOutlet weak var btnHotel: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

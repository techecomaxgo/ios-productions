//
//  HotelSearchCell.swift
//  MaxPay
//
//  Created by india on 14/12/23.
//

import UIKit

class HotelSearchCell: UITableViewCell {

    @IBOutlet weak var btnSearchHotel: UIButton!
    @IBOutlet weak var btnAddRoom: UIButton!
    @IBOutlet weak var btnCheckOut: UIButton!
    @IBOutlet weak var btnCheckIn: UIButton!
    @IBOutlet weak var lblCheckOutDate: UILabel!
    @IBOutlet weak var lblCheckInDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

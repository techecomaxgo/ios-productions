//
//  AddRoomCell.swift
//  MaxPay
//
//  Created by india on 14/12/23.
//

import UIKit

class AddRoomCell: UITableViewCell {

    @IBOutlet weak var lblRoom: UILabel!
    @IBOutlet weak var btnChildMinus: UIButton!
    @IBOutlet weak var btnAddChild: UIButton!
    @IBOutlet weak var btnAdultMinus: UIButton!
    @IBOutlet weak var btnAddAdult: UIButton!
    @IBOutlet weak var lblChild: UILabel!
    @IBOutlet weak var lblAdult: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

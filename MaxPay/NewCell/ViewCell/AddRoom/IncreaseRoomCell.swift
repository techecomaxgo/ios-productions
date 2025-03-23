//
//  IncreaseRoomCell.swift
//  MaxPay
//
//  Created by india on 14/12/23.
//

import UIKit

class IncreaseRoomCell: UITableViewCell {

    @IBOutlet weak var btnRemoveRoom: DesignableButton!
    @IBOutlet weak var btnDone: DesignableButton!
    @IBOutlet weak var btnAdd: DesignableButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

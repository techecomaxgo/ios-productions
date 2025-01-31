//
//  PayTableViewCell.swift
//  MaxPay
//
//  Created by Admin on 29/01/25.
//

import UIKit

class PayTableViewCell: UITableViewCell {

    @IBOutlet weak var lblUpiID: UILabel!
    @IBOutlet weak var lblUpiStatus: UILabel!
    @IBOutlet weak var btnPay: UIButton!
    @IBOutlet weak var btnRequest: UIButton!
    @IBOutlet weak var btnTransfer: UIButton!
    @IBOutlet weak var btnMyQr: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

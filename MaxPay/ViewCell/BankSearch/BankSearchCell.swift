//
//  BankSearchCell.swift
//  MaxPay
//
//  Created by india on 13/11/23.
//

import UIKit

class BankSearchCell: UITableViewCell {

    @IBOutlet weak var lblBankName: UILabel!
    @IBOutlet weak var imgBankIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

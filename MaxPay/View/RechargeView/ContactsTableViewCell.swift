//
//  ContactsTableViewCell.swift
//  MaxPay
//
//  Created by Ios Developer on 15/05/24.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblMobileOrUpi: UILabel!
    
    @IBOutlet weak var imgContact: DesignableImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

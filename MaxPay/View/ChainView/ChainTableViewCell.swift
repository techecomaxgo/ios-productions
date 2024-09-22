//
//  ChainTableViewCell.swift
//  MaxPay
//
//  Created by Admin on 30/05/24.
//

import UIKit

class ChainTableViewCell: UITableViewCell {

    @IBOutlet weak var imgUser: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblSpent: UILabel!
    
    @IBOutlet weak var lblgot: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

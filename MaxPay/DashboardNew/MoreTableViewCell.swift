//
//  MoreTableViewCell.swift
//  MaxPay
//
//  Created by Admin on 29/01/25.
//

import UIKit

class MoreTableViewCell: UITableViewCell {

    @IBOutlet weak var btnFavourit: UIButton!
    @IBOutlet weak var btnUPI: UIButton!
    @IBOutlet weak var btnPaybill: UIButton!
    @IBOutlet weak var btnShareIdea: UIButton!
    @IBOutlet weak var btnLoustAndFound: UIButton!
    @IBOutlet weak var btnRecharge: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

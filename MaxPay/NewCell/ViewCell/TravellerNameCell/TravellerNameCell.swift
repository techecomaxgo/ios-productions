//
//  TravellerNameCell.swift
//  MaxPay
//
//  Created by india on 12/12/23.
//

import UIKit

class TravellerNameCell: UITableViewCell {

    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtFirstaName: UITextField!
    @IBOutlet weak var lblAdultNo: UILabel!
    @IBOutlet weak var btnSegment: UISegmentedControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

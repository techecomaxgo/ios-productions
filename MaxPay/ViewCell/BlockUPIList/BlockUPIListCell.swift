//
//  BlockUPIListCell.swift
//  MaxPay
//
//  Created by india on 15/11/23.
//

import UIKit

class BlockUPIListCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblVpa: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(object: BlockListModel) {
        
        lblName.text = ""// object.
        lblVpa.text = object.vpa
        
    }

}

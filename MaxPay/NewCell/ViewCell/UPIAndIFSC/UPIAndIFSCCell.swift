//
//  UPIAndIFSCCell.swift
//  MaxPay
//
//  Created by india on 13/11/23.
//

import UIKit

class UPIAndIFSCCell: UITableViewCell {

    @IBOutlet weak var lblSenderName: UILabel!
    @IBOutlet weak var lblVpa: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

    public func setSentData(object: BeneficiaryListModel) {
        lblSenderName.text = object.name
        lblVpa.text = object.vpa
    }

}

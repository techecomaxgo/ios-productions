//
//  ReceivedCell.swift
//  MaxPay
//
//  Created by india on 15/11/23.
//

import UIKit

class ReceivedCell: UITableViewCell {
    
    @IBOutlet weak var lblReceiveerName: UILabel!
    @IBOutlet weak var lblReceiveerVpa: UILabel!
    @IBOutlet weak var lblReceivedDate: UILabel!
    @IBOutlet weak var lblReceivedAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setReceivedData(object: PendingNotificationsListModel) {
        lblReceiveerName.text = object.beneName
        lblReceiveerVpa.text = object.payeeVpa
        lblReceivedDate.text = object.expdate
        lblReceivedAmount.text = "₹\(object.amount ?? "0")"
    }

}

class SendCell: UITableViewCell {

    @IBOutlet weak var lblSenderName: UILabel!
    @IBOutlet weak var lblVpa: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func setSentData(object: BeneficiaryListModel) {
        lblSenderName.text = object.name
        lblVpa.text = object.vpa
    }
    
}

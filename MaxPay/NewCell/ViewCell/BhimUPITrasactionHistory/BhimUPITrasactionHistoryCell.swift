//
//  BhimUPITrasactionHistoryCell.swift
//  MaxPay
//
//  Created by india on 14/11/23.
//

import UIKit

enum Status {
    case Complete
    case Pending
    case Reject
    case Decline
    case Fail
    
    // Function to get status from single character
    static func getStatus(from char: String) -> String? {
        switch char {
        case "C":
            return "Complete"
        case "P":
            return "Pending"
        case "R":
            return "Rejected"
        case "D":
            return "Deemed"
        case "F":
            return "Failed"
        default:
            return nil
        }
    }
}


class BhimUPITrasactionHistoryCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblVpa: UILabel!
    @IBOutlet weak var lblTxnId: UILabel!
    @IBOutlet weak var lblTxnDate: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblAmount: UILabel!

    @IBOutlet weak var lblFromToLabel: UILabel!
    @IBOutlet weak var imgFromToStatusIc: UIImageView!
    @IBOutlet weak var imgSendReceiveIc: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTranHistoryData(data: TranHistoryModel, accountDetails: AccountDetailsOnIIN) {
                
        lblTxnId.text = data.tranid
        lblTxnDate.text = data.dateTime
        
        lblStatus.text = Status.getStatus(from: data.status ?? "")
        
        imgFromToStatusIc.image = data.status == "C" ? UIImage(systemName: "checkmark.circle.fill")?.withRenderingMode(.alwaysTemplate) : UIImage(systemName: "multiply.circle.fill")?.withRenderingMode(.alwaysTemplate)
        imgFromToStatusIc.tintColor = data.status == "C" ? UIColor.init(named: "primary-green") : data.status == "P" ? UIColor.orange : UIColor.init(named: "status-red-color")
        
        
        imgSendReceiveIc.image = data.type == "PAY" ? UIImage(named: "ic_arrow_up")?.withRenderingMode(.alwaysTemplate) : UIImage(named: "ic_arrow_down")?.withRenderingMode(.alwaysTemplate)
        
        imgSendReceiveIc.tintColor = data.status == "C" ? UIColor.init(named: "primary-green") : data.status == "P" ? UIColor.orange : UIColor.init(named: "status-red-color")
        
        lblAmount.text = "₹ " + (data.amount ?? "0")
        
        if data.type == "PAY" {
            if accountDetails.vpa == data.creditVpa {
                lblFromToLabel.text = "Received from"
                lblVpa.text = data.debitVpa
                lblName.text = data.remitterName == nil ? "No Name" : data.remitterName
            } else {
                lblFromToLabel.text = "Pay to"
                lblVpa.text = data.creditVpa
                lblName.text = data.beneficiaryName == nil ? "No Name" : data.beneficiaryName
            }
        } else if data.type == "COLLECT" {
            if accountDetails.vpa == data.creditVpa {
                lblFromToLabel.text = "Request to"
                lblVpa.text = data.debitVpa
                lblName.text = data.remitterName == nil ? "No Name" : data.remitterName
            } else {
                lblFromToLabel.text = "Request from"
                lblVpa.text = data.creditVpa
                lblName.text = data.beneficiaryName == nil ? "No Name" : data.beneficiaryName
            }
        }
        
    }

}

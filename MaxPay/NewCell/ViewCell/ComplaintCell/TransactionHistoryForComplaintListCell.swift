//
//  TransactionHistoryForComplaintListCell.swift
//  MaxPay
//
//  Created by Ios Developer on 01/02/24.
//

import UIKit

enum HISTORY_TRANSACTION_STATUS: String {
    case BILL_PAYMENT_SUCCESS
    case BILL_PAYMENT_FAILED
}

class TransactionHistoryForComplaintListCell: UITableViewCell {
    
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblFromWallet: UILabel!
    @IBOutlet weak var lblOnDateTime: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setHistoryData(object: ComplaintData) {
        
        
        lblTitle.text = "Paid to \(object.billerName ?? "")"
        lblFromWallet.text = "From UPI"
        lblOnDateTime.text = "on \(convertDateFormat(from: object.createdAt ?? "") ?? "")"

        if object.transactionStatus == "BILL_PAYMENT_SUCCESS" {
            if object.transType == "SENT" {
                lblAmount.textColor = UIColor.init(named: "status-red-color")
                lblAmount.text = "-₹\(object.totalTxnAmt ?? 0)"
            } else { // RECIVED
                lblAmount.textColor = UIColor.init(named: "primary-green")
                lblAmount.text = "+₹\(object.totalTxnAmt ?? 0)"
            }
            
        } else { // BILL_PAYMENT_FAILED
            lblAmount.textColor = UIColor.init(named: "status-red-color")
            
            if object.transType == "SENT" {
                lblAmount.text = "-₹\(object.totalTxnAmt ?? 0)"
            } else { // RECIVED
                lblAmount.text = "+₹\(object.totalTxnAmt ?? 0)"
            }
        }
        
    }
    
    func convertDateFormat(from dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        dateFormatter.dateFormat = "dd MMM, hh:mm a"
        let formattedString = dateFormatter.string(from: date)
        
        return formattedString
    }
    
}

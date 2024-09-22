//
//  MandateListTVC.swift
//  MaxPay
//
//  Created by Ios Developer on 07/03/24.
//

import UIKit

class MandateListTVC: UITableViewCell {
    
    
    @IBOutlet weak var vwLogo: UIView!
    
    @IBOutlet weak var imgMandate: UIImageView!
    
    @IBOutlet weak var viewStatusLine: UIView!
    
    
    @IBOutlet weak var lblMndateRequestFrom: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblVpa: UILabel!
    //@IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblOneTime: UILabel!
    @IBOutlet weak var stackButtons: UIStackView!
    
    @IBOutlet weak var btnDecline: UIButton!
    @IBOutlet weak var btnProceed: UIButton!
    
    @IBOutlet weak var lblstatusDate: UILabel!
    
    var priceStr = ""
    
    
    @IBOutlet weak var viewLineHeightConst: NSLayoutConstraint!
    

    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        // Initialization code
        
        vwLogo.layer.applyCornerRadiusShadow()

        
        
    }
    
    
    func setMandateData(object: MandateListModel) {
        
        
        
        lblMndateRequestFrom.text = object.beneName
        lblAmount.text = "Up to ₹ " + (object.amount ?? "0") + "/-"
        lblVpa.text = object.payeeVpa
       // lblDate.text = object.createdate
        lblOneTime.text = object.recurrencePattern
        
    }
    
    func setTransactionData(object: MandateTransactionModel) {
        
        if object.payeeStatus == "R" {
            
            lblstatusDate.text = "Autopay is Revoked"
            
        } else if object.payeeStatus == "F"{
            
            lblstatusDate.text = "Autopay is failed"

            
            
        } else if object.payeeStatus == "E"{
            
            lblstatusDate.text = "Autopay is Expired"

            
            
        }
        else if object.payeeStatus == "S"{
            
            lblstatusDate.text = "Autopay is Active"

            
            
        }
        
        else if object.payeeStatus == "U"{
            
            lblstatusDate.text = "Autopay is Active"

            
            
        }
        
        priceStr =  (object.amount ?? "0")
        
        // let decimalValue = Decimal(string: strValue) // 12
 
        lblMndateRequestFrom.text = object.payername
        lblAmount.text = "Up to ₹ " + (object.amount ?? "0") + "/-"
        lblVpa.text = object.payeeVpa
       // lblDate.text = object.createdDate
        lblOneTime.text = object.recurrencePattern
        
    }
    
    
    
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  PriceBreakup.swift
//  MaxPay
//
//  Created by india on 06/12/23.
//

import UIKit
import SwiftyJSON

class PriceBreakup: UIView {

    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var lblTitle: UILabel!

    @IBOutlet weak var lblPassengersNo: UILabel!
    @IBOutlet weak var lblTotalBaseFare: UILabel!
    @IBOutlet weak var lblGstOperatorFees: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblInsurence: UILabel!
    @IBOutlet weak var lblGrandTotal: UILabel!
    
    var strPassengersNo = ""
    var strTotalBaseFare = ""
    var strGstOperatorFees = ""
    var strDiscount = ""
    var strInsurence = ""
    var strGrandTotal = ""
    
    func setupUI(){
        if let first = Bundle.main.loadNibNamed("PriceBreakup", owner: self, options: nil)?.first as? UIView {
            vwMain = first
            
            vwMain.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
            addSubview(vwMain)
        }
        
        lblPassengersNo.text = strPassengersNo
        lblTotalBaseFare.text = "₹" + strTotalBaseFare
        lblGstOperatorFees.text = "₹" + strGstOperatorFees
        lblDiscount.text = strDiscount
        lblInsurence.text = strInsurence
        lblGrandTotal.text = strGrandTotal        
    }
    
    
    @IBAction func btnCloseAction(_ sender: Any) {
        self.removeFromSuperview()
    }
    
}

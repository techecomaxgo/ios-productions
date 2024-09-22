//
//  FlightReviewVC.swift
//  MaxPay
//
//  Created by india on 04/12/23.
//

import UIKit

class FlightReviewVC: BaseVC {

    @IBOutlet weak var txtVWtearms: UITextView!
    @IBOutlet weak var vwCondition: UIView!
    @IBOutlet weak var vwGST: UIView!
    @IBOutlet weak var vwMobileNumber: UIView!
    @IBOutlet weak var vwAddAdult: UIView!
    @IBOutlet weak var vwWay: UIView!
    @IBOutlet weak var vwContinueBooking: UIView!
    @IBOutlet weak var vwPayment: UIView!
    @IBOutlet weak var lblGrandTotal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblGrandTotal.text = "Grand Total\n5467"
        let firstTitleString = "I accept "
         let secondTitleString = "T&C and Privecy Policy."
         let finishTitleString = firstTitleString + secondTitleString
         let attributedString = NSMutableAttributedString(string: finishTitleString)
         attributedString.addAttribute(.link, value: "https://stackoverflow.com", range: NSRange(location: firstTitleString.count, length: secondTitleString.count))
         
        txtVWtearms.attributedText = attributedString
        txtVWtearms.textContainerInset = .zero
        txtVWtearms.linkTextAttributes = [
             .foregroundColor: UIColor(hexString: "32ADE6"),
             .underlineStyle: NSUnderlineStyle.single.isEmpty
         ]
        txtVWtearms.font = .systemFont(ofSize: 16)
        txtVWtearms.textColor = UIColor.black

        vwWay.layer.applyCornerRadiusShadow()
        vwWay.layer.cornerRadius = 4
        vwWay.layer.borderColor = UIColor.lightGray.cgColor
        vwWay.layer.borderWidth = 1
        
        vwCondition.layer.applyCornerRadiusShadow()
        vwCondition.layer.cornerRadius = 4
        vwCondition.layer.borderColor = UIColor.lightGray.cgColor
        vwCondition.layer.borderWidth = 1
        
        vwGST.layer.applyCornerRadiusShadow()
        vwGST.layer.cornerRadius = 4
        vwGST.layer.borderColor = UIColor.lightGray.cgColor
        vwGST.layer.borderWidth = 1
        
        vwMobileNumber.layer.applyCornerRadiusShadow()
        vwMobileNumber.layer.cornerRadius = 4
        vwMobileNumber.layer.borderColor = UIColor.lightGray.cgColor
        vwMobileNumber.layer.borderWidth = 1
        
        vwAddAdult.layer.applyCornerRadiusShadow()
        vwAddAdult.layer.cornerRadius = 4
        vwAddAdult.layer.borderColor = UIColor.lightGray.cgColor
        vwAddAdult.layer.borderWidth = 1
        
        vwPayment.layer.applyCornerRadiusShadow()
        vwPayment.layer.cornerRadius = 4
        vwPayment.layer.borderColor = UIColor.lightGray.cgColor
        vwPayment.layer.borderWidth = 1
        
        vwContinueBooking.clipsToBounds = true
        vwContinueBooking.layer.cornerRadius = 10
        vwContinueBooking.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnContinueBookingAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "USP", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PaymentListVC") as! PaymentListVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

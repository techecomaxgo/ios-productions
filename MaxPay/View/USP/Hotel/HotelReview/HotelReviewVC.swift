//
//  HotelReviewVC.swift
//  MaxPay
//
//  Created by india on 14/12/23.
//

import UIKit

class HotelReviewVC: BaseVC {
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnGST: UIButton!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var vwAdultBack: UIView!
    @IBOutlet weak var vwAdultBackHeight: NSLayoutConstraint!
    @IBOutlet weak var tblAdultList: UITableView!
    @IBOutlet weak var stackVW: UIStackView!
    @IBOutlet weak var txtVWtearms: UITextView!
    @IBOutlet weak var vwCondition: UIView!
    @IBOutlet weak var vwGST: UIView!
    @IBOutlet weak var vwMobileNumber: UIView!
    @IBOutlet weak var vwContinueBooking: UIView!
    @IBOutlet weak var vwPayment: UIView!
    @IBOutlet weak var lblGrandTotal: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        tblAdultList.register(
            UINib(nibName: "HotelAdultCell", bundle: nil),
            forCellReuseIdentifier: "HotelAdultCell")
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
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnContinueBookingAction(_ sender: Any) {
        
    }
    @IBAction func btnGSTNumberAction(_ sender: Any) {
        
    }
    @IBAction func btnAcceptAction(_ sender: Any) {
        
    }
}
extension HotelReviewVC:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "HotelAdultCell", for: indexPath) as! HotelAdultCell
        cell.selectionStyle = .none
        return cell
    }
    
}

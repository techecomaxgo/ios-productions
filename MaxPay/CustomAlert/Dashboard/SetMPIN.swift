//
//  SetMPIN.swift
//  MaxPay
//
//  Created by india on 23/11/23.
//

import UIKit
@objc protocol SetMPINDelegate: NSObjectProtocol {
    @objc optional func btnCheckBalance(_ sender: UIButton, lblBalance: UILabel)
    @objc optional func btnSetMpin(_ sender: UIButton)
//    @objc optional func btnChangeMpin(_ sender: UIButton)
    @objc optional func btnDeleteAccount(_ sender: UIButton)
    @objc optional func btnCheckBal(_ sender: UIButton)
    @objc optional func btnSetAsPrimary(_ sender: UIButton)
}

class SetMPIN: UIView {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet var mainView: UIView!
    @IBOutlet var lblBalance: UILabel!
    @IBOutlet weak var btnRefresh: UIButton!
    
    weak var delegate:SetMPINDelegate? = nil
    var selectedMenuInde = -1
    
    func setupUI(){
        if let first = Bundle.main.loadNibNamed("SetMPIN", owner: self, options: nil)?.first as? UIView {
            mainView = first
            mainView.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
            addSubview(mainView)
        }
    }
    
    @IBAction func btnCheckBalance(_ sender: UIButton) {
        
//        btnCheckBal
        
//        lblBalance.isHidden = false
//        btnRefresh.isHidden = false
        
    }
    
    
//    func fetchBalanceFromAPI(completion: @escaping (String) -> Void) {
//        // Simulate API response
//        let balance = 100.0
//        // Execute the completion handler with the balance
//        completion("\(balance)")
//        
//        self.lblBalance.isHidden = false
//        self.lblBalance.text = "₹ \(balance) / -"
//        
//    }
    
    func balanceReceived(_ balance: String) {
        // Handle the received balance here
        print("Received balance: \(balance)")
        DispatchQueue.main.async {
//            self.lblBalance.isHidden = false
//            self.lblBalance.text = "₹ \(balance) / -"
//            self.showErrorAlert("Account Balance: \(data as! String)")
        }
    }
    
    @IBAction func btnCheckBalanceAction(_ sender: UIButton) {
//        self.removeFromSuperview()
        if let del = delegate{
            sender.tag = selectedMenuInde //sender.tag
            del.btnCheckBalance?(sender, lblBalance: lblBalance)
//            self.lblBalance.isHidden = false
//            self.lblBalance.text = "₹ \(1234) / -"
            
            
//            fetchBalanceFromAPI { balance in
//                
//            }
        }
    }

    @IBAction func btnSetChangeMpinAction(_ sender: UIButton) {
        self.removeFromSuperview()
        if let del = delegate{
            sender.tag = selectedMenuInde
            del.btnSetMpin?(sender)
        }
    }

    @IBAction func btnSetMpinAction(_ sender: UIButton) {
        self.removeFromSuperview()
        if let del = delegate{
            sender.tag = selectedMenuInde
            del.btnSetMpin?(sender)
        }
    }
    
    @IBAction func btnChangeMpinAction(_ sender: UIButton) {
        self.removeFromSuperview()
        if let del = delegate{
            sender.tag = selectedMenuInde
            del.btnSetMpin?(sender)
        }
    }

    
    @IBAction func btnDeleteAccountAction(_ sender: UIButton) {
        self.removeFromSuperview()
        if let del = delegate{
            sender.tag = selectedMenuInde
            del.btnDeleteAccount?(sender)
        }
    }
    
    @IBAction func btnSetAsPrimaryAction(_ sender: UIButton) {
        self.removeFromSuperview()
        if let del = delegate{
            sender.tag = selectedMenuInde
            del.btnSetAsPrimary?(sender)
        }
    }
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.removeFromSuperview()
    }
    
}


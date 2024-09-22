//
//  PaymentListVC.swift
//  MaxPay
//
//  Created by india on 04/12/23.
//

import UIKit

class PaymentListVC: BaseVC {

    @IBOutlet weak var vwEMI: UIView!
    @IBOutlet weak var vwUPI: UIView!
    @IBOutlet weak var vwWallet: UIView!
    @IBOutlet weak var vwNetBanking: UIView!
    @IBOutlet weak var btnPayment: UIButton!
    @IBOutlet weak var txtCVV: TextFieldDesignable!
    @IBOutlet weak var txtYear: TextFieldDesignable!
    @IBOutlet weak var txtMonth: TextFieldDesignable!
    @IBOutlet weak var txtNameOnCard: TextFieldDesignable!
    @IBOutlet weak var txtCardNumber: TextFieldDesignable!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var vwPayments: UIView!
    @IBOutlet weak var vwDebitCardDetailsBack: UIView!
    @IBOutlet weak var vwLogin: UIView!
    @IBOutlet weak var vwWay: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUPUI()
    }
    func setUPUI(){
        vwWay.layer.applyCornerRadiusShadow()
        vwWay.layer.cornerRadius = 4
        vwWay.layer.borderColor = UIColor.lightGray.cgColor
        vwWay.layer.borderWidth = 1
        
        vwLogin.layer.applyCornerRadiusShadow()
        vwLogin.layer.cornerRadius = 4
        vwLogin.layer.borderColor = UIColor.lightGray.cgColor
        vwLogin.layer.borderWidth = 1
        
        vwEMI.layer.applyCornerRadiusShadow()
        vwEMI.layer.cornerRadius = 4
        vwEMI.layer.borderColor = UIColor.lightGray.cgColor
        vwEMI.layer.borderWidth = 1
        
        vwUPI.layer.applyCornerRadiusShadow()
        vwUPI.layer.cornerRadius = 4
        vwUPI.layer.borderColor = UIColor.lightGray.cgColor
        vwUPI.layer.borderWidth = 1
        
        vwWallet.layer.applyCornerRadiusShadow()
        vwWallet.layer.cornerRadius = 4
        vwWallet.layer.borderColor = UIColor.lightGray.cgColor
        vwWallet.layer.borderWidth = 1
        
        vwNetBanking.layer.applyCornerRadiusShadow()
        vwNetBanking.layer.cornerRadius = 4
        vwNetBanking.layer.borderColor = UIColor.lightGray.cgColor
        vwNetBanking.layer.borderWidth = 1
        
        vwPayments.layer.applyCornerRadiusShadow()
        vwPayments.layer.cornerRadius = 4
        vwPayments.layer.borderColor = UIColor.lightGray.cgColor
        vwPayments.layer.borderWidth = 1
        
        vwDebitCardDetailsBack.layer.applyCornerRadiusShadow()
        vwDebitCardDetailsBack.layer.cornerRadius = 4
        vwDebitCardDetailsBack.layer.borderColor = UIColor.lightGray.cgColor
        vwDebitCardDetailsBack.layer.borderWidth = 1
        
        vwDebitCardDetailsBack.layer.applyCornerRadiusShadow()
        vwDebitCardDetailsBack.layer.cornerRadius = 4
        vwDebitCardDetailsBack.layer.borderColor = UIColor.lightGray.cgColor
        vwDebitCardDetailsBack.layer.borderWidth = 1
        
        btnLogin.clipsToBounds = true
        btnLogin.layer.cornerRadius = 12.5
        
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnLoginAction(_ sender: Any) {
        
    }
    
}


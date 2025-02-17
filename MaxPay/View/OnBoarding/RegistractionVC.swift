//
//  RegistractionVC.swift
//  MaxPay
//
//  Created by india on 06/11/23.
//

import UIKit
import SwiftLoader

class RegistractionVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var btnSendOTP: UIButton!
    
    private var registractionVWMidel = RegistractionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSendOTP.layer.applyCornerRadiusShadow()
        txtPhoneNumber.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                           replacementString string: String) -> Bool {
        let maxLength = 10
        let currentString: NSString = txtPhoneNumber.text! as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString

        return newString.length <= maxLength
    }

    @IBAction func btnSendOTPAction(_ sender: Any) {
        let strPhoneNumber = txtPhoneNumber.text
        if strPhoneNumber!.count >= 10 && strPhoneNumber != "" && Common.shared.isValidPhone(phone: strPhoneNumber!) {

            configuration()
            
        }else{
            showErrorAlert("Please enter your phone number.")
        }
        
    }
    
    @IBAction func btnTermConditionAction(_ sender: Any) {
        openURL(termsConditions_PrivacyPolicy)
    }
    
    @IBAction func btnPrivacyPolicyAction(_ sender: Any) {
        openURL(termsConditions_PrivacyPolicy)
    }
    
    func isValidPhone(phone: String) -> Bool {
            let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return phoneTest.evaluate(with: phone)
    }
    func showErrorAlert(_ strMsg:String){
        let alert = UIAlertController(title: "MaxUPI", message: strMsg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // Check if the URL can be opened
        if UIApplication.shared.canOpenURL(url) {
            // Open the URL
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Cannot open URL")
        }
    }
    
}
extension RegistractionVC {
   //MARK: API Calling
    func configuration() {
        
        SwiftLoader.show(animated: true)
        initViewModel()
        observeEvent()
    }
    //MARK Network checking
    func initViewModel() {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            registractionVWMidel.registractionCall(txtPhoneNumber.text!)
        }else{
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internetconnection.")
            
        }
    }
    //MARK: Observing the data
    func observeEvent() {
        registractionVWMidel.eventHandler = { [weak self] event in
            guard self != nil else { return }

            switch event {
                
            case .loading:
                print("Loading...")
                
            case .stopLoading:
                print("stopLoading...")
                
            case .dataLoaded:
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                    if self?.registractionVWMidel.registractionModel?.status == "success" {
                        Common.shared.phoneNo = self?.txtPhoneNumber.text!
                       let storyboard = UIStoryboard(name: "Main", bundle: nil)
                       let vc = storyboard.instantiateViewController(withIdentifier: "OTPVerifyVC") as! OTPVerifyVC
                        vc.isFromForgotPin = true
                        vc.strPhoneNumber = self?.txtPhoneNumber.text! ?? ""
                       self?.navigationController?.pushViewController(vc,animated: true)
                    } else if self?.registractionVWMidel.registractionModel?.status == "redirect" {
                        Common.shared.phoneNo = self?.txtPhoneNumber.text!
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "LoginMPIN") as! LoginMPIN
                        self?.navigationController?.pushViewController(vc,animated: true)
                    } else{
                        self?.showErrorAlert(self?.registractionVWMidel.registractionModel?.message ?? "")
                    }
                }
                
            case .error(let error):
                print(error!)
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                }
            }
        }
    }

}

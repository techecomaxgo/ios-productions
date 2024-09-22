//
//  OTPVerifyVC.swift
//  MaxPay
//
//  Created by india on 06/11/23.
//

import UIKit
import SwiftLoader

class OTPVerifyVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var vwLineSix: UIView!
    @IBOutlet weak var vwLineFive: UIView!
    @IBOutlet weak var vwLineFour: UIView!
    @IBOutlet weak var vwLineThree: UIView!
    @IBOutlet weak var vwLineTwo: UIView!
    @IBOutlet weak var vwLineOne: UIView!
    @IBOutlet weak var txtPINSix: UITextField!
    @IBOutlet weak var txtPINFive: UITextField!
    @IBOutlet weak var txtPINFour: UITextField!
    @IBOutlet weak var txtPINThree: UITextField!
    @IBOutlet weak var txtPINTwo: UITextField!
    @IBOutlet weak var txtPINOne: UITextField!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var btnResendOTP: UIButton!
    @IBOutlet weak var btnOTPVerify: UIButton!
    @IBOutlet weak var lblMobileNumber: UILabel!
    
    var isFromForgotPin = false
    var resendCodeCounter = 60
    var resendCodeTimer = Timer()
    var otpSent = true
    var isVerifyActivity = true
    var strPhoneNumber = ""
    private var otpVerifyVWModel = OTPVerifyViewModel()
    var otpTextFields: [UITextField]!
    let networkManager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        btnOTPVerify.layer.applyCornerRadiusShadow()
        lblMobileNumber.text = "+91 \(strPhoneNumber)"
        lblTimer.text = ""
        
        btnResendOTP.isEnabled = false
        
        txtPINOne.delegate = self
        txtPINOne.tag = 1
        
        txtPINTwo.delegate = self
        txtPINTwo.tag = 2
        
        txtPINThree.delegate = self
        txtPINThree.tag = 3
        
        txtPINFour.delegate = self
        txtPINFour.tag = 4
        
        txtPINFive.delegate = self
        txtPINFive.tag = 5
        
        txtPINSix.delegate = self
        txtPINSix.tag = 6
        
        
        txtPINOne.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtPINTwo.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtPINThree.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtPINFour.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtPINFive.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtPINSix.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)

        otpTextFields = [txtPINOne,
                        txtPINTwo,
                        txtPINThree,
                        txtPINFour,
                        txtPINFive,
                        txtPINSix]
        
        // timer
        sendOTPCode()
        
        
        fetchOTP()
    }
    
    func fetchOTP() {
        networkManager.fetchOTP { [weak self] otp in
            self?.fillOTPFromMessage(otp: otp)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text ?? ""
        if text.count >= 1 {
            // Move to the next text field if available
            if let nextTextField = view.viewWithTag(textField.tag + 1) as? UITextField {
                nextTextField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
        }
    }
    
    // Function to auto-fill OTP from message
    func fillOTPFromMessage(otp: String) {
        DispatchQueue.main.async { [weak self] in
            for (index, digit) in otp.enumerated() {
                if index < (self?.otpTextFields.count)! {
                    self?.otpTextFields[index].text = String(digit)
                    // Move to the next text field if available
                    if let nextTextField = self?.view.viewWithTag((self?.otpTextFields[index].tag ?? 0) + 1) as? UITextField {
                        nextTextField.becomeFirstResponder()
                    }
                }
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Limit the input length to 1 character
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        return newText.count <= 1
    }
    
//    @objc func textFieldDidChange(textField: UITextField){
//
//        let text = textField.text
//
//        if (text?.utf16.count)! >= 1{
//            switch textField{
//            case txtPINOne:
//                txtPINTwo.becomeFirstResponder()
//                vwLineOne.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineTwo.backgroundColor = UIColor(hexString: "34C759")
//                vwLineThree.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineFour.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineFive.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineSix.backgroundColor = UIColor(hexString: "A9A9A9")
//            case txtPINTwo:
//                txtPINThree.becomeFirstResponder()
//                vwLineOne.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineTwo.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineThree.backgroundColor = UIColor(hexString: "34C759")
//                vwLineFour.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineFive.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineSix.backgroundColor = UIColor(hexString: "A9A9A9")
//            case txtPINThree:
//                txtPINFour.becomeFirstResponder()
//                vwLineOne.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineTwo.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineThree.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineFour.backgroundColor = UIColor(hexString: "34C759")
//                vwLineFive.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineSix.backgroundColor = UIColor(hexString: "A9A9A9")
//            case txtPINFour:
//                txtPINFive.becomeFirstResponder()
//                vwLineOne.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineTwo.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineThree.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineFour.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineFive.backgroundColor = UIColor(hexString: "34C759")
//                vwLineSix.backgroundColor = UIColor(hexString: "A9A9A9")
//            case txtPINFive:
//                txtPINSix.becomeFirstResponder()
//                vwLineOne.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineTwo.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineThree.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineFour.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineFive.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineSix.backgroundColor = UIColor(hexString: "34C759")
//            case txtPINSix:
//                txtPINSix.resignFirstResponder()
//            default:
//                break
//            }
//        }else{
//            switch textField{
//            case txtPINSix:
//                txtPINFive.becomeFirstResponder()
//                vwLineOne.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineTwo.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineThree.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineFour.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineFive.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineSix.backgroundColor = UIColor(hexString: "34C759")
//            case txtPINFive:
//                txtPINFour.becomeFirstResponder()
//                vwLineOne.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineTwo.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineThree.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineFour.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineFive.backgroundColor = UIColor(hexString: "34C759")
//                vwLineSix.backgroundColor = UIColor(hexString: "A9A9A9")
//            case txtPINFour:
//                txtPINThree.becomeFirstResponder()
//                vwLineOne.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineTwo.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineThree.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineFour.backgroundColor = UIColor(hexString: "34C759")
//                vwLineFive.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineSix.backgroundColor = UIColor(hexString: "A9A9A9")
//            case txtPINThree:
//                txtPINTwo.becomeFirstResponder()
//                vwLineOne.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineTwo.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineThree.backgroundColor = UIColor(hexString: "34C759")
//                vwLineFour.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineFive.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineSix.backgroundColor = UIColor(hexString: "A9A9A9")
//            case txtPINTwo:
//                txtPINOne.becomeFirstResponder()
//                vwLineOne.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineTwo.backgroundColor = UIColor(hexString: "34C759")
//                vwLineThree.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineFour.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineFive.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineSix.backgroundColor = UIColor(hexString: "A9A9A9")
//            case txtPINOne:
//                txtPINOne.resignFirstResponder()
//                vwLineOne.backgroundColor = UIColor(hexString: "34C759")
//                vwLineTwo.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineThree.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineFour.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineFive.backgroundColor = UIColor(hexString: "A9A9A9")
//                vwLineSix.backgroundColor = UIColor(hexString: "A9A9A9")
//            default:
//                break
//            }
//        }
//    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let text = textField.text
    }
    
    deinit {
        resendCodeTimer.invalidate()
      }
    @objc func updateTimerLabel() {
        resendCodeCounter = resendCodeCounter > 0 ? resendCodeCounter - 1 : 0
        lblTimer.text = "\(resendCodeCounter)"
        if resendCodeCounter == 0 {
            btnResendOTP.isEnabled = true
            btnResendOTP.setTitle("RESEND OTP", for: .normal)
            btnResendOTP.setTitleColor(UIColor(named: "primary-green"), for: .normal)
            lblTimer.text = ""
            resendCodeTimer.invalidate()
        }
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnResendOTPAction(_ sender: Any) {
        isVerifyActivity = false
        resendCodeCounter = 60
        btnResendOTP.setTitle("RESEND OTP in", for: .normal)
        btnResendOTP.setTitleColor(UIColor(named: "reload-grey-color"), for: .normal)
        btnResendOTP.isEnabled = false
        sendOTPCode()
        regenarateOTPCall()
        
    }
    func sendOTPCode() {
        //Whatever your api logic
        if otpSent {
            self.resendCodeTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimerLabel), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func btnVerifyOTPAction(_ sender: Any) {
        isVerifyActivity = true
        if txtPINOne.text != "" && txtPINTwo.text != "" && txtPINThree.text != "" && txtPINFour.text != "" && txtPINFive.text != "" && txtPINSix.text != "" {
            configuration()
        } else {
            showErrorAlert("Please enter your OTP code.")
        }
        
    }
    func showErrorAlert(_ strMsg:String){
        let alert = UIAlertController(title: "MaxUPI", message: strMsg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
extension OTPVerifyVC {
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
            otpVerifyVWModel.otpVerifyCall(strPhoneNumber, Int("\(txtPINOne.text!)\(txtPINTwo.text!)\(txtPINThree.text!)\(txtPINFour.text!)\(txtPINFive.text!)\(txtPINSix.text!)") ?? 0)
        }else{
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internetconnection.")
            
        }
    }
    //MARK: Observing the data
    func observeEvent() {
        otpVerifyVWModel.eventHandler = { [weak self] event in
            guard self != nil else { return }

            switch event {
            case .loading:
                
                print("loading....")
                
            case .stopLoading:
                
                print("Stop loading...")
                SwiftLoader.hide()
            case .dataLoaded:
                print("Data loaded...")
                DispatchQueue.main.async {
                    if self?.otpVerifyVWModel.otpVerifyModel?.status == "success" {
                        if self?.isVerifyActivity == true {
                            
                            if self?.isFromForgotPin == true {
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "SetPINVC") as! SetPINVC
                                vc.strPhoneNumber = self?.strPhoneNumber ?? ""
                                self?.navigationController?.pushViewController(vc,animated: true)

                            } else {
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "LoginMPIN") as! LoginMPIN
                                self?.navigationController?.pushViewController(vc,animated: true)
                            }
                                                        
                        } else {
                            self?.showErrorAlert(self?.otpVerifyVWModel.otpVerifyModel?.message ?? "")
                        }
                    }else{
                        self?.showErrorAlert(self?.otpVerifyVWModel.otpVerifyModel?.message ?? "")
                        SwiftLoader.hide()
                    }
                }
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
            }
        }
    }
    //MARK: API Calling
     func regenarateOTPCall() {
         let isConnected = ReachabilityClass.isConnectedToNetwork()
         
         if isConnected == true {
             otpVerifyVWModel.otpRegenarateCall(strPhoneNumber)
         }else{
             SwiftLoader.hide()
             self.showErrorAlert("Please check your internetconnection.")
             
         }
     }
     //MARK: Observing the data
     func observeEventRegenarate() {
         otpVerifyVWModel.eventHandler = { [weak self] event in
             guard self != nil else { return }

             switch event {
             case .loading:
                 
                 print("loading....")
                 
             case .stopLoading:
                 
                 print("Stop loading...")
                 SwiftLoader.hide()
             case .dataLoaded:
                 print("Data loaded...")
                 DispatchQueue.main.async {
                     if self?.otpVerifyVWModel.otpVerifyModel?.status == "success" {
                         self?.showErrorAlert(self?.otpVerifyVWModel.otpVerifyModel?.message ?? "")
                     }else{
                         self?.showErrorAlert(self?.otpVerifyVWModel.otpVerifyModel?.message ?? "")
                     }
                 }
             case .error(let error):
                 print(error!)
                 SwiftLoader.hide()
             }
         }
     }

}


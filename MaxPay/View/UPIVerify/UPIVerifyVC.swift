//
//  UPIVerifyVC.swift
//  MaxPay
//
//  Created by india on 17/11/23.
//

import UIKit
import Contacts
import OlivePayLibrary
import SwiftLoader
import MessageUI
import CoreLocation

class UPIVerifyVC: BaseVC {

    private var checksumViewModel = SIMSelectionViewModel()

    var accountDetails: AccountDetailsOnIIN?
    @IBOutlet weak var txtUPIID: UITextField!
    @IBOutlet weak var vwBack: UIView!
    
    var isFromRequestScreen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vwBack.layer.applyCornerRadiusShadow()
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnVerifyAction(_ sender: Any) {
        if txtUPIID.text != "" && validateUPIID1(txtUPIID.text!){
            checkvpa(vpa: txtUPIID.text!)
        }else{
            self.showErrorAlert("Please enter valid UPI ID.")
        }
    }
        
    func validateUPIID1(_ upiID: String) -> Bool {
        let validCharacterSet = CharacterSet(charactersIn: "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.-@")
        
        if upiID.isEmpty {
            self.showErrorAlert("Please Enter UPI ID")
            return false
        } else if upiID.count <= 3 || upiID.count > 99 || (upiID.rangeOfCharacter(from: validCharacterSet.inverted) != nil) || !upiID.contains(where: { $0 == "@" }) {
            self.showErrorAlert("Please Enter Valid UPI ID")
            return false
        } else if upiID.count >= 10 && isNumeric(upiID) {
            if upiID == Common.shared.phoneNo {
                self.showErrorAlert("You can't set vpa as  number")
                return false
            }
        }
        
        return true
    }
    
    
    func isNumeric(_ vpa: String) -> Bool {
        let numericCharacterSet = CharacterSet.decimalDigits
        return vpa.rangeOfCharacter(from: numericCharacterSet.inverted) == nil
    }
    
    func checkvpa(vpa: String) {
        let payerInfo = PayerInfo(accountnumber: accountDetails?.accRefNumber, mcc: MCC, name: accountDetails?.name, payervpa: accountDetails?.vpa)
        
        var jsonToString = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(payerInfo)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                jsonToString = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }

        DispatchQueue.global(qos: .background).async {
            
            // Working properly
            OliveUpiManager.checkvpa(vpa: vpa, payerInfo: jsonToString) { data, error in
                
                if let err = error {
                    if err.code == 102 { // Customer Accounts not found
                        DispatchQueue.main.async {
                            self.showErrorAlert(err.localizedDescription)
                        }
                    } else if err.code == 401 || err.code == 107 {
                        
                        self.configuration()
                        return
                    }
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                    }
                } else {
                    print(data)
                    
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        
                        
                        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                        
                        if self.isFromRequestScreen == true {
                            let vc = storyboard.instantiateViewController(withIdentifier: "PaymentUPIIDRequestVC") as! PaymentUPIIDRequestVC
                            vc.accountDetails = self.accountDetails
                            vc.beneVpa = vpa
                            vc.beneName = data as? String ?? ""
//                            vc.isFromRequestScreen = self.isFromRequestScreen
                            self.navigationController?.pushViewController(vc, animated: true)
                        } else {
                            
                            let vc = storyboard.instantiateViewController(withIdentifier: "PaymentUPIIDVC") as! PaymentUPIIDVC
                            vc.accountDetails = self.accountDetails
                            vc.beneVpa = vpa
                            vc.beneName = data as? String ?? ""
                            vc.isFromRequestScreen = self.isFromRequestScreen
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
            }
        }

    }
}

extension UPIVerifyVC: MFMessageComposeViewControllerDelegate {
    
    func configuration() {
        initViewModel()
        observeEvent()
    }
    
    //MARK Network checking
    func initViewModel() {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            checksumViewModel.loginChecksumCall(Common.shared.phoneNo ?? "", Common.shared.getDeviceID() ?? "")
        }else{
            DispatchQueue.main.async {
                SwiftLoader.hide()
                self.showErrorAlert("Please check your internet connection.")
            }
            
        }
    }
    
    //MARK: Observing the data
    func observeEvent() {
        checksumViewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }
            
            switch event {
            case .loading:
                
                print("loading....")
                
            case .stopLoading:
                
                print("Stop loading...")

            case .dataLoaded:
                print("Data loaded...")
                if self?.checksumViewModel.checksumModel?.status?.lowercased() == "success" {
                    Common.shared.merchantauthtoken = self?.checksumViewModel.checksumModel?.data?.data?.merchantauthtoken ?? ""
                    
                    self?.performMerchantHandshake()
                    
                }else{
                    DispatchQueue.main.async {
                        self?.showErrorAlert(self?.checksumViewModel.checksumModel?.message ?? "")
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
    
    func performMerchantHandshake(){
        
        let sdkHandShake = SDKHandshake(emailId: "", merchId: MerchantId, merchChanId: MerchantId, submerchantid: SubMerchantId, mcccode: MCC, unqCustId: "91\(Common.shared.phoneNo ?? "")", mobileNo: "91\(Common.shared.phoneNo ?? "")", deviceid: Common.shared.getDeviceID(), appid: appId, custname: "MAX", merchantauthtoken: Common.shared.merchantauthtoken ?? "", unqTxnId:SDKHandshake.shared.generateRandomDigits(12))
        
        let jsonString = sdkHandShake.jsonString(sdkHandShake)
        
        OliveUpiManager.initiateSDK(sdkHandshake: jsonString,view: self , delegate: self) { (data, err) in
            print("The data is:\(String(describing: data))")
            self.checkvpa(vpa: self.txtUPIID.text!)
        }
    }
    
    public func messageComposeViewController(_ controller: MFMessageComposeViewController,didFinishWith didFinishWithresult: MessageComposeResult) {
        controller.dismiss(animated: true, completion: {})
        switch didFinishWithresult {
        case .cancelled:
            print("Cancelled")
        case .sent:
            print("Message Sent")
            OliveUpiManager.sendMobileBindReqst(callback: { (data, err) in
                if let er = err{
                    print(er)
                    DispatchQueue.main.async {
                        self.showToast(message: "SMS Sent failed", font: .systemFont(ofSize: 12))
                        SwiftLoader.hide()
                    }
                }else{
                    self.checkvpa(vpa: self.txtUPIID.text!)
                    DispatchQueue.main.async {
                        self.showToast(message: "SMS Delivered", font: .systemFont(ofSize: 12))
                    }
                }
            })
            break
        default:
            break
        }
    }
}

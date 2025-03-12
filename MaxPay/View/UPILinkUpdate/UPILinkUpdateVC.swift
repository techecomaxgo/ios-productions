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

class UPILinkUpdateVC: BaseVC, MFMessageComposeViewControllerDelegate {
    
    private var checksumViewModel = SIMSelectionViewModel()
    @IBOutlet weak var txtUPIID: UITextField!
    @IBOutlet weak var vwBack: UIView!
    var accountDetails: AccountDetailsOnIIN?
    private var notificationViewModel = NotificationViewModel()
    
    var jsonStringJson = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        //Common.shared.getDeviceID(),
        
        vwBack.layer.applyCornerRadiusShadow()

        NotificationCenter.default.addObserver(self, selector: #selector(poptoDashboard), name: Notification.Name("NotificationPoptoDashboard2"), object: nil)

    }
    
    @objc func poptoDashboard() {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: DashboardVC.self) {
                SwiftLoader.hide()
                self.navigationController!.popToViewController(controller, animated: true)
                // Create the alert controller
                        let alert = UIAlertController(title: "Alert!", message: "Screen toggling not allowed while onboarding", preferredStyle: .alert)

                        // Add an action (button) to the alert
                        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                            print("OK button tapped")
                        }

                        // Add the action to the alert controller
                        alert.addAction(okAction)

                        // Present the alert
                        self.present(alert, animated: true, completion: nil)
                break
            }
        }
    }

    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnVerifyAction(_ sender: Any) {
        if validateUPIID((txtUPIID.text!)) {
            // API Calling
            self.updateVPA()
        }
    }
    
    func validateUPIID(_ upiID: String) -> Bool {
        let validCharacterSet = CharacterSet(charactersIn: "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.-")
        
        if upiID.isEmpty {
            showErrorAlert("Please Enter UPI ID")
            return false
        } else if upiID.count <= 3 || upiID.count > 99 || (upiID.rangeOfCharacter(from: validCharacterSet.inverted) != nil) {
            showErrorAlert("Please Enter Valid UPI ID")
            return false
        } else if upiID.count >= 10 && isNumeric(upiID) {
            if upiID == Common.shared.phoneNo {
                showErrorAlert("You can't set vpa as number")
                return false
            }
        }
        
        return true
    }
    
    func isNumeric(_ vpa: String) -> Bool {
        let numericCharacterSet = CharacterSet.decimalDigits
        return vpa.rangeOfCharacter(from: numericCharacterSet.inverted) == nil
    }
    
    func updateVPA() {
        
        let accountDetails = AccountDetails(name: accountDetails?.name ?? "", aeba: accountDetails?.aeba ?? "", mbeba: accountDetails?.mbeba ?? "", accRefNumber: accountDetails?.accRefNumber ?? "", ifsc: accountDetails?.ifsc ?? "", maskedAccnumber: accountDetails?.maskedAccnumber ?? "", status: accountDetails?.status ?? "", type: accountDetails?.type ?? "", vpa: accountDetails?.vpa ?? "", dLength: accountDetails?.dLength ?? "", dType: accountDetails?.dType ?? "", balance: accountDetails?.balance ?? "", balTime: accountDetails?.balTime ?? "", atmpinFormat: accountDetails?.atmpinFormat ?? "", atmpinLength: accountDetails?.atmpinLength ?? "", iin: accountDetails?.iin ?? "", internationlActive: "N", otpFormat: accountDetails?.otpFormat ?? "")
        
        //var jsonStringJson = ""
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(accountDetails)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                self.jsonStringJson = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
       // let uipId = txtUPIID.text! + "@maxaxis"
        let uipId = (Common.shared.phoneNo ?? "") + "@maxaxis"
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        DispatchQueue.global(qos: .background).async {
            
            // working properly
            OliveUpiManager.updateVPA(vpa: uipId, account: self.jsonStringJson) { data, error in
                
                if let err = error {
                    if err.code == 102 { // VPA not allowed for this customer
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
                    
                    Common.shared.isDeregistered = false
                    
                    self.accountDetails?.vpa = uipId
                    
                    // store new card's vpa locally
                    self.retriveAndStoreAccount()
                    
                    self.configurationNotification(token: Common.shared.fcmToken ?? "", vpa_address: uipId, acc_num: self.accountDetails?.maskedAccnumber ?? "", ifsc_code: self.accountDetails?.ifsc ?? "")

//                    DispatchQueue.main.async {
//                        SwiftLoader.hide()
//                        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
//                        let vc = storyboard.instantiateViewController(withIdentifier: "UPISetUPIPinVC") as! UPISetUPIPinVC
//                        vc.accountDetails = self.accountDetails
//                        self.navigationController?.pushViewController(vc, animated: true)
//                    }
                }
            }
        }
    }
    
    
    func retriveAndStoreAccount() {
        
        var accountDetailsArr:[AccountDetailsOnIIN] = []
        if let decoded = Common.shared.myCards {
            do {
                let cardList: [AccountDetailsOnIIN] = try JSONDecoder().decode([AccountDetailsOnIIN].self, from: decoded)
                for card in cardList {
                    // retrive existing cards from user defaults
                    accountDetailsArr.append(card)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        // add new selected, check if not exist in array then only add otherwise not
        let results = accountDetailsArr.filter { $0.maskedAccnumber == accountDetails?.maskedAccnumber }
        if results.isEmpty == true {
            accountDetailsArr.append(accountDetails!)
        }
        
        do {
            // Convert Arr of cards to Data
            let placesData = try JSONEncoder().encode(accountDetailsArr)
            // Stored data of array to user defaults
            Common.shared.myCards = placesData
            
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension UPILinkUpdateVC {
    
    func configurationNotification(token: String, vpa_address: String, acc_num: String, ifsc_code: String) {
        initNotificationViewModel(token: token, vpa_address: vpa_address, acc_num: acc_num, ifsc_code: ifsc_code)
        observeNotificationEvent()
    }
    //MARK Network checking
    
    func initNotificationViewModel(token: String, vpa_address: String, acc_num: String, ifsc_code: String) {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            notificationViewModel.addNotificationTokenCall(token: token, vpa_address: vpa_address, acc_num: acc_num, ifsc_code: ifsc_code)
        }else{
            self.showErrorAlert("Please check your internet connection.")
        }
    }
    
    //MARK: Observing the data
    func observeNotificationEvent() {
        
        notificationViewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }
            
            switch event {
            case .loading:
                
                print("loading....")
                
            case .stopLoading:
                
                print("Stop loading...")
                
            case .dataLoaded:
                print("Data loaded...")
                
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                    let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "UPISetUPIPinVC") as! UPISetUPIPinVC
                    vc.accountDetails = self?.accountDetails
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                
                
            case .error(let error):
                print(error!)

            }
        }
    }
}


extension UPILinkUpdateVC {
    
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
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                }
                
            case .dataLoaded:
                print("Data loaded...")
                if self?.checksumViewModel.checksumModel?.data?.result?.lowercased() == "success" {
                    Common.shared.merchantauthtoken = self?.checksumViewModel.checksumModel?.data?.data?.merchantauthtoken ?? ""
                    self?.performMerchantHandshake()
                } else {
                    DispatchQueue.main.async {
                        self?.showErrorAlert(self?.checksumViewModel.checksumModel?.data?.result ?? "")
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
            self.updateVPA()
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
                    
                    self.updateVPA()
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

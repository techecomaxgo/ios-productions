//
//  PaymentUPIIDNewConfirmationVC.swift
//  MaxPay
//
//  Created by india on 13/11/23.
//

import UIKit
import Foundation
import OlivePayLibrary
import SwiftLoader
import MessageUI
import CoreLocation

class PaymentUPIIDNewConfirmationVC: BaseVC, CLLocationManagerDelegate, bankSelectedDelegate {
    
    var tranTypeStr = "P2P"
    var mccCodeStr = "0000"
    var remrkStr = ""
    
    private var limitCheckViewModel =  LimitCheckViewModel()
    var locationManager: CLLocationManager!
    
    var contactData: ContactDetail?
    var accountDetails: AccountDetailsOnIIN?
    var beneVpa = ""
    var beneName = ""
    var apiCallOption = ""
    var transId = ""
    private var checksumViewModel = SIMSelectionViewModel()
    var isFromRequestScreen = false
    var isFromQrScan = false
    var amtDecimal = ""
    var btnAddBeneficiaryTag: Int!
    var remark = ""
    var nickName = ""
    var  isFromPayNow = false
    
    @IBOutlet weak var viewRemarkBg: UIView!
    @IBOutlet weak var viewTextNameBg: UIView!
    @IBOutlet weak var imgContact: UIImageView!
    @IBOutlet weak var lblUpiId: UILabel!
    @IBOutlet weak var lblCheckBalance: UILabel!
    
    @IBOutlet weak var lblFromName: UILabel!
    @IBOutlet weak var lblAccountType: UILabel!
    @IBOutlet weak var lblUpiId21: UILabel!
    @IBOutlet weak var lblRegisteredName: UILabel!
    @IBOutlet weak var lblAmountWords: UILabel!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtRemark: UITextField!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configuration()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        lblUpiId.text = accountDetails?.vpa ?? ""
        lblUpiId21.text = beneVpa
        
        txtName.text = nickName
        
        let trimmedBeneName = beneName.components(separatedBy: "%20").joined(separator: " ")
        lblRegisteredName.text = trimmedBeneName
        
        txtAmount.text = amtDecimal
        lblAccountType.text = accountDetails?.type
        
        viewTextNameBg.isHidden = isFromQrScan
        viewRemarkBg.isHidden = remark == ""
        txtRemark.text = remark
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .spellOut
        lblAmountWords.text = numberFormatter.string(from: (Double(amtDecimal) ?? 0.00) as NSNumber)?.capitalizingFirstLetter()
        
        //constraintViewHeight.constant = isFromQrScan ? constraintViewHeight.constant - 50 : constraintViewHeight.constant
        
        lblFromName.text = accountDetails?.name
        
        if let imageData = contactData?.thumbnailImageData {
            imgContact.image = UIImage(data: imageData)
        } else {
            // Set a placeholder image if no contact image is available
            imgContact.image = UIImage(named: "me_profile")
        }
        
        
    }
    
    
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
   
    func popBankSelected(cardInfo: AccountDetailsOnIIN, isFromPayNow:Bool) {
        
        print("MB card info: \(cardInfo)")
        print(isFromPayNow)
//         self.ApiCallForPay()
        
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
            // Prepare the account details
            let account = AccountPay(
                
                name: cardInfo.name ?? "",
                mmid: cardInfo.mmid ?? "",
                aeba: cardInfo.aeba ?? "",
                mbeba: cardInfo.mbeba ?? "",
                accRefNumber: cardInfo.accRefNumber ?? "",
                ifsc: cardInfo.ifsc ?? "",
                maskedAccnumber: cardInfo.maskedAccnumber ?? "",
                status: cardInfo.status ?? "",
                type: cardInfo.type ?? "",
                vpa: cardInfo.vpa ?? "",
                dLength: cardInfo.dLength ?? "",
                dType: cardInfo.dType ?? "",
                balance: cardInfo.balance ?? "",
                balTime: cardInfo.balTime ?? "",
                accountIfsc: cardInfo.ifsc ?? "",
                iin:cardInfo.iin ?? ""
                
            )
            
            let strAccountDetails = encodeToJSON(account)
            
            
            print(strAccountDetails)
            
            self.apiCallOption = "pay"
            
            let nickName = self.txtName.text ?? ""
            
            
            
            let beneVpa = BeneVpa(name: self.beneName, vpa: self.beneVpa, nickName: nickName)
            let strBeneVpa = encodeToJSON(beneVpa)
            
            
            let x = Double(self.txtAmount.text ?? "0") ?? 0
            self.amtDecimal = String(format: "%.2f", Double(round(100 * x) / 100))
            
            remrkStr = self.txtRemark.text ?? ""
            
            if remrkStr == "" {
                
                remrkStr = "UPI"
            }
            
            if mccCodeStr == "0000"{
                
                
                tranTypeStr = "P2P"
                
            }else{
                
                tranTypeStr = "P2M"
                
            }
            
            let paymentInput = PaymentInput(
                amount: "\(self.amtDecimal)",
                merchantVpa: MerchantVpa,
                merchantId: MerchantId,
                submerchantid: SubMerchantId,
                merchantChannelId: MerchChanId,
                tranType: tranTypeStr,
                mcc: mccCodeStr,
                remarks: remrkStr,
                initMode: "00",
                purpose: "00",
                refCategory: "00"
            )
        
            let strPaymentInput = encodeToJSON(paymentInput)
        
            //        let operationQueue = OperationQueue()
            //        let backgroundOperation = BlockOperation {
            
            print("strAccountDetails: \(strAccountDetails)")
            print("strBeneVpa: \(strBeneVpa)")
            print("strPaymentInput: \(strPaymentInput)")
            
            
            //     DispatchQueue.global(qos: .background).async { [weak self] in
            
            //            guard let strongSelf = self else {
            //                print("Self was deallocated before the operation completed.")
            //                return
            //            }
        

        // Perform API call in the background
        DispatchQueue.global(qos: .background).async {
                            
            OliveUpiManager.initiatePay(account: strAccountDetails, benevpa: strBeneVpa, paymentInput: strPaymentInput, viewController: self) { (result, error) in
                 
                    // Ensure UI updates are on the main thread
                
                                    DispatchQueue.main.async {
                                        if let err = error {
                                            if err.code == 102 || err.code == 108 {
                                                self.showErrorAlert(err.localizedDescription)
                                            } else if err.code == 401 || err.code == 107 {
                                                SwiftLoader.hide()
                                                self.configuration()
                                            }
                                            SwiftLoader.hide()
                                        } else {
                                            if let result = result {
                                                SwiftLoader.hide()
                                                self.transId = result as! String
                    
                                                if self.btnAddBeneficiaryTag == 1 {
                                                    self.saveBeneficary(dataResp: self.transId)
                                                }
                    
                                                self.isFromPayNow = false
                                                let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                                                if let vc = storyboard.instantiateViewController(withIdentifier: "PaymentSuccessfulVC") as? PaymentSuccessfulVC {
                                                    vc.accountDetails = self.accountDetails
                                                    vc.beneVpa = self.beneVpa
                                                    vc.beneName = self.beneName
                                                    vc.transId = self.transId
                                                    vc.amount = "\(self.amtDecimal)"
                                                    vc.fromScreenOption = "pay"
                                                    vc.paymentStatus = "00"
                                                    self.navigationController?.pushViewController(vc, animated: true)
                                                }
                                            } else {
                                                print("Data nil")
                                            }
                                        }
                                    }
                       }
               }
            
        
        }
     
    
   
    // Helper function to encode an object to JSON
    func encodeToJSON<T: Encodable>(_ object: T) -> String {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(object)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
            return ""
        }
        return ""
    }

//
//    func jsonString(_ sdkHandShake:SDKHandshake) ->String{
//         do {
//             let jsonEncoder = JSONEncoder()
//             jsonEncoder.outputFormatting = .prettyPrinted // Optional: Makes the JSON readable
//             let jsonData = try jsonEncoder.encode(sdkHandShake)
//             if let jsonString = String(data: jsonData, encoding: .utf8) {
//                 print(jsonString)
//                 // Now jsonString contains the JSON representation of sdkHandShake
//                 return jsonString
//             }
//         } catch {
//             print("Error: \(error.localizedDescription)")
//             return ""
//         }
//         return ""
//     }

    
    
    
    
    @IBAction func btnContinuePayAction(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            let popOverVC = self.storyboard?.instantiateViewController(withIdentifier: "AccountSelectionPopVc")  as! AccountSelectionPopVc
            
            popOverVC.delegatePopupBankSelected = self
            
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            self.addChild(popOverVC)
        }
        
        
        
        
        //checkLocationAuthorizationStatus()
        
        //self.ApiCallForPay()
        
        // limitCheckViewModel.limitCheckCall(action: "p2p_pay")
        
        //observeLimitCheckApi()
        
        
    }
    
    func checkLocationAuthorizationStatus() {
        if #available(iOS 14.0, *) {
            let status = locationManager.authorizationStatus
            switch status {
            case .notDetermined:
                // Request when-in-use authorization
                //locationManager.requestWhenInUseAuthorization()
                if isFromPayNow{
                    ApiCallForPay()
                }
                
            case .restricted, .denied:
                
                // Handle the lack of authorization (e.g., show an alert)
                showAlertWithSettings()
                
                
                
            case .authorizedWhenInUse, .authorizedAlways:
                // Authorization granted, proceed with your function
                if isFromPayNow{
                    ApiCallForPay()
                }
                
            @unknown default:
                // Handle other potential future cases
                fatalError("Unknown authorization status")
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        print("Authorization status changed to: \(status.rawValue)")
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            if isFromPayNow{
                ApiCallForPay()
            }
        case .denied, .restricted:
            print("Location access denied or restricted")
            showAlertWithSettings()
        case .notDetermined:
            print("Location access not determined")
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            print("Unknown authorization status")
        }
        
    }
    
    
    func showAlertWithSettings() {
        let alertController = UIAlertController(title: "Location Access Denied",
                                                message: "Please enable location services in Settings",
                                                preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    // Handle if necessary
                })
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    func ApiCallForPay() {
        // Ensure UI is updated on the main thread
        // Show loader on the main thread
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            SwiftLoader.show(animated: true)
        }
        
        guard let accountDetails = self.accountDetails else {
            // Handle the case where accountDetails is nil
            return
        }
        
        // Prepare the account details
        let account = AccountPay(
            
            name: accountDetails.name ?? "",
            mmid: accountDetails.mmid ?? "",
            aeba: accountDetails.aeba ?? "",
            mbeba: accountDetails.mbeba ?? "",
            accRefNumber: accountDetails.accRefNumber ?? "",
            ifsc: accountDetails.ifsc ?? "",
            maskedAccnumber: accountDetails.maskedAccnumber ?? "",
            status: accountDetails.status ?? "",
            type: accountDetails.type ?? "",
            vpa: accountDetails.vpa ?? "",
            dLength: accountDetails.dLength ?? "",
            dType: accountDetails.dType ?? "",
            balance: accountDetails.balance ?? "",
            balTime: accountDetails.balTime ?? "",
            accountIfsc: accountDetails.ifsc ?? "",
            iin:accountDetails.iin ?? ""
            
        )
        
        var strAccountDetails = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(account)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strAccountDetails = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        print(strAccountDetails)
        
        self.apiCallOption = "pay"
        
        let nickName = self.txtName.text ?? ""
        let beneVpa = BeneVpa(name: self.beneName, vpa: self.beneVpa, nickName: nickName)
        var strBeneVpa = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(beneVpa)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strBeneVpa = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        let x = Double(self.txtAmount.text ?? "0") ?? 0
        self.amtDecimal = String(format: "%.2f", Double(round(100 * x) / 100))
        
        remrkStr = self.txtRemark.text ?? ""
        
        if remrkStr == "" {
            
            remrkStr = "UPI"
        }
        
        if mccCodeStr == "0000"{
            
            
            tranTypeStr = "P2P"
            
        }else{
            
            tranTypeStr = "P2M"
            
        }
        
        
        let paymentInput = PaymentInput(
            amount: "\(self.amtDecimal)",
            merchantVpa: MerchantVpa,
            merchantId: MerchantId,
            submerchantid: SubMerchantId,
            merchantChannelId: MerchChanId,
            tranType: tranTypeStr,
            mcc: mccCodeStr,
            remarks: remrkStr,
            initMode: "00",
            purpose: "00",
            refCategory: "00"
        )
        var strPaymentInput = ""
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(paymentInput)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strPaymentInput = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        // Perform API call in the background
        DispatchQueue.global(qos: .background).async { [weak self] in
            
            guard let strongSelf = self else { return }
            //
            //            OliveUpiManager.initiatePay(account: strAccountDetails, benevpa: strBeneVpa, paymentInput: strPaymentInput, viewController: strongSelf) { data, error in
            
            
            OliveUpiManager.initiatePay(account: strAccountDetails, benevpa: strBeneVpa, paymentInput: strPaymentInput, viewController: self!) { (result, error) in
                
                
                // Switch to main thread to update UI
                DispatchQueue.main.async {
                    
                    if let err = error {
                        
                        if err.code == 102 || err.code == 108 {
                            
                            strongSelf.showErrorAlert(err.localizedDescription)
                            
                        } else if err.code == 401 || err.code == 107 {
                            
                            SwiftLoader.hide()
                            strongSelf.configuration()
                            //return
                        }
                        
                        SwiftLoader.hide()
                        
                    }
                    else {
                        
                        
                        if result != nil {
                            
                            SwiftLoader.hide()
                            strongSelf.transId = result as! String
                            
                            if strongSelf.btnAddBeneficiaryTag == 1 {
                                
                                strongSelf.saveBeneficary(dataResp: strongSelf.transId)
                                //return
                            }
                            
                            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                            
                            if let vc = storyboard.instantiateViewController(withIdentifier: "PaymentSuccessfulVC") as? PaymentSuccessfulVC {
                                vc.accountDetails = strongSelf.accountDetails
                                vc.beneVpa = strongSelf.beneVpa
                                vc.beneName = strongSelf.beneName
                                vc.transId = strongSelf.transId
                                vc.amount = "\(strongSelf.amtDecimal)"
                                vc.fromScreenOption = "pay"
                                vc.paymentStatus = "00"
                                
                                strongSelf.navigationController?.pushViewController(vc, animated: true)
                                
                            }
                        }else {
                            
                            print("Data nil")
                            
                        }
                        
                        print("Data nil2ww")
                        
                    }
                    
                    print("Data nil2")
                }
                
                print("Data nil3")
                
            }
            
            
        }
        
        
    }
    
    
    
    
    
    func navigateToPaymentSuccessfulVC() {
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "PaymentSuccessfulVC") as? PaymentSuccessfulVC {
            vc.accountDetails = self.accountDetails
            vc.beneVpa = self.beneVpa
            vc.beneName = self.beneName
            vc.transId = self.transId
            vc.amount = "\(self.amtDecimal)"
            vc.fromScreenOption = "pay"
            vc.paymentStatus = "00"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    
    
    
    
    
    
    
    //MARK: Observing the data
    func observeLimitCheckApi() {
        
        limitCheckViewModel.eventHandler = { [weak self] event in
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
                    
                    // print( self?.limitCheckViewModel.limitCheckModel)
                    
                    SwiftLoader.hide()
                    
                    
                    if self?.limitCheckViewModel.limitCheckModel?.status ?? "" != "failed" {
                        
                        print(self?.limitCheckViewModel.limitCheckModel?.data?.bindAttemptLimit ?? 0)
                        
                        if self?.limitCheckViewModel.limitCheckModel?.data?.bindAttemptLimit ?? 0 <= 20
                        {
                            
                            
                            self?.ApiCallForPay()
                            
                        }
                        
                    }else{
                        
                        self?.showErrorAlert(self?.limitCheckViewModel.limitCheckModel?.message ?? "")
                        
                    }
                    
                    
                }
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
            }
        }
    }
    
    
    
    
    
    
    @IBAction func btnCheckBalanceAction(_ sender: UIButton) {
        Task {
            CheckBalance()
        }
        
//        func performFirstTask() async {
//             await CheckBalance()
//        }
//        
//        let semaphore = DispatchSemaphore(value: 0)
//        
//        Task {
//            await CheckBalance()
//            semaphore.signal()
//        }
//        
//        semaphore.wait()
    }
    
    func CheckBalance(){
        
        Task { @MainActor in
            
            DispatchQueue.main.async {
                SwiftLoader.show(animated: true)
            }
            
            apiCallOption = "chkbal"
            
            let accountDetails = AccountCheckBalance(name: accountDetails?.name ?? "", mmid: accountDetails?.mmid ?? "", aeba: accountDetails?.aeba ?? "", mbeba: accountDetails?.mbeba ?? "", accRefNumber: accountDetails?.accRefNumber ?? "", ifsc: accountDetails?.ifsc ?? "", maskedAccnumber: accountDetails?.maskedAccnumber ?? "", status: accountDetails?.status ?? "", type: accountDetails?.type ?? "", vpa: accountDetails?.vpa ?? "", dLength: accountDetails?.dLength ?? "", dType: accountDetails?.dType ?? "", balance: accountDetails?.balance ?? "", balTime: accountDetails?.balTime ?? "")
            
            var jsonObjectString = ""
            
            do {
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
                let jsonData = try encoder.encode(accountDetails)
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                    jsonObjectString = jsonString
                }
            } catch {
                print("Error encoding JSON: \(error)")
            }
            
            if self.accountDetails?.status == "A" { // Account active
                
                if self.accountDetails?.vpa != "" {
                    
                    //DispatchQueue.global(qos: .background).async {
                        DispatchQueue.global(qos: .userInitiated).async {
                    
                    print("MB test jsonobject for check balance\(jsonObjectString)")
                    // Working Properly
                     OliveUpiManager.checkBalance(account: jsonObjectString, viewController: self) { data, error in
                        
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
                            
                            // print(data ?? "")
                            DispatchQueue.main.async {
                                SwiftLoader.hide()
                                self.lblCheckBalance.text = "₹ \(data as! String) / -"
                            }
                        }
                    }
                    }
                } else {
                    
                    DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "UPILinkUpdateVC") as! UPILinkUpdateVC
                        vc.accountDetails = self.accountDetails
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                
            } else if accountDetails.status == "R" { // Account Not active
                
                // call activate account function
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "UPISetUPIPinVC") as! UPISetUPIPinVC
                    vc.accountDetails = self.accountDetails
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
        }
    }
    
    func saveBeneficary(dataResp: String) {
        
        self.apiCallOption = "bene"
        
        let saveBeneVpa = SaveBeneVpa(vpa: self.beneVpa, name: self.beneName, nickname: txtName.text!)
        
        var strSaveBeneVpa = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(saveBeneVpa)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strSaveBeneVpa = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        DispatchQueue.global(qos: .background).async {
            
            // Manage Response
            OliveUpiManager.saveBeneVpa(bene: strSaveBeneVpa) { data, error in
                
                if let err = error {
                    
                    if err.code == 108 { // Customer Accounts not found
                        DispatchQueue.main.async {
                            self.showErrorAlert(err.localizedDescription)
                        }
                    } else if err.code == 102 { // VPA already exist!
                        
                        DispatchQueue.main.async {
                            self.showErrorAlert(err.localizedDescription)
                            
                            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "PaymentSuccessfulVC") as! PaymentSuccessfulVC
                            
                            vc.accountDetails = self.accountDetails
                            vc.beneVpa = self.beneVpa
                            vc.beneName = self.beneName
                            vc.transId = dataResp
                            vc.amount = "\(self.amtDecimal)"
                            vc.fromScreenOption = "pay"
                            
                            self.navigationController?.pushViewController(vc, animated: true)
                            
                        }
                    } else if err.code == 401 || err.code == 107 {
                        
                        self.configuration()
                        return
                        
                    }
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                    }
                    
                } else {
                    //print(data)
                    
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        self.showToast(message: "Beneficiary added Successfully")
                        
                        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "PaymentSuccessfulVC") as! PaymentSuccessfulVC
                        
                        vc.accountDetails = self.accountDetails
                        vc.beneVpa = self.beneVpa
                        vc.beneName = self.beneName
                        vc.transId = dataResp
                        vc.amount = "\(self.amtDecimal)"
                        vc.fromScreenOption = "pay"
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }
                }
            }
            
        }
    }
    
}

extension PaymentUPIIDNewConfirmationVC: MFMessageComposeViewControllerDelegate {
    
    func configuration() {
        initViewModel()
        observeEvent()
    }
    
    //MARK Network checking
    func initViewModel() {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            checksumViewModel.loginChecksumCall(Common.shared.phoneNo ?? "", Common.shared.token ?? "")
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
                //print("Data loaded...")
                if self?.checksumViewModel.checksumModel?.data?.result == "Success" {
                    Common.shared.merchantauthtoken = self?.checksumViewModel.checksumModel?.data?.data?.merchantauthtoken ?? ""
                    
                    self?.performMerchantHandshake()
                    
                }else{
                    DispatchQueue.main.async {
                        self?.showErrorAlert(self?.checksumViewModel.checksumModel?.data?.result ?? "")
                        SwiftLoader.hide()
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
        
        OliveUpiManager.initiateSDK(sdkHandshake: jsonString,view: self , delegate: self) {[weak self] (data, err) in
            guard let `self` = self else {
                return
            }
            //print("The data is:\(String(describing: data))")
            if self.apiCallOption == "pay" {
                DispatchQueue.main.async {
                    self.btnContinuePayAction(UIButton())
                }
            } else if self.apiCallOption == "bene" {
                self.saveBeneficary(dataResp: self.transId)
            } else if self.apiCallOption == "chkbal" {
                self.btnCheckBalanceAction(UIButton())
            }
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
                    if self.apiCallOption == "pay" {
                        self.btnContinuePayAction(UIButton())
                    } else if self.apiCallOption == "bene" {
                        self.saveBeneficary(dataResp: self.transId)
                    } else if self.apiCallOption == "chkbal" {
                        self.btnCheckBalanceAction(UIButton())
                    }
                }
            })
            break
        default:
            break
        }
    }
}







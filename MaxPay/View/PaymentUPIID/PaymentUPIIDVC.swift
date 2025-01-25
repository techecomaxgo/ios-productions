//
//  PaymentUPIIDVC.swift
//  MaxPay
//
//  Created by india on 13/11/23.
//

import UIKit
import OlivePayLibrary
import SwiftLoader
import MessageUI

class PaymentUPIIDVC: BaseVC {

    var accountDetails: AccountDetailsOnIIN?
    var beneVpa = ""
    var beneName = ""
    var apiCallOption = ""
    var transId = ""
    private var checksumViewModel = SIMSelectionViewModel()
    var isFromRequestScreen = false
    var isFromQrScan = false
    var amtDecimal = ""

    @IBOutlet weak var viewTextNameBg: UIView!
    @IBOutlet weak var viewBeneficiaryBg: UIView!
    
    @IBOutlet weak var constraintViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var vwBack: UIView!
    @IBOutlet weak var lblUpiId: UILabel!
    
    @IBOutlet weak var lblUpiId21: UILabel!
    @IBOutlet weak var lblRegisteredName: UILabel!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtRemark: UITextField!
    
    @IBOutlet weak var imgCheckUncheck: UIImageView!
    @IBOutlet weak var btnAddBeneficiary: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vwBack.layer.applyCornerRadiusShadow()
        
        lblUpiId.text = accountDetails?.vpa ?? ""
        lblUpiId21.text = beneVpa
        
        let trimmedBeneName = beneName.components(separatedBy: "%20").joined(separator: " ")
        lblRegisteredName.text = trimmedBeneName
        
        viewTextNameBg.isHidden = isFromQrScan
        viewBeneficiaryBg.isHidden = isFromQrScan
         
        constraintViewHeight.constant = isFromQrScan ? constraintViewHeight.constant - 50 : constraintViewHeight.constant
    }
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnProceedAction(_ sender: UIButton) {
                     
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        let accountDetails = AccountPay(name: accountDetails?.name ?? "", mmid: accountDetails?.mmid ?? "", aeba: accountDetails?.aeba ?? "", mbeba: accountDetails?.mbeba ?? "", accRefNumber: accountDetails?.accRefNumber ?? "", ifsc: accountDetails?.ifsc ?? "", maskedAccnumber: accountDetails?.maskedAccnumber ?? "", status: accountDetails?.status ?? "", type: accountDetails?.type ?? "", vpa: accountDetails?.vpa ?? "", dLength: accountDetails?.dLength ?? "", dType: accountDetails?.dType ?? "", balance: accountDetails?.balance ?? "", balTime: accountDetails?.balTime ?? "", accountIfsc: accountDetails?.ifsc ?? "", iin: accountDetails?.iin ?? "")
        
        var strAccountDetails = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(accountDetails)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strAccountDetails = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }

        self.apiCallOption = "pay"
        
        let beneVpa = BeneVpa(name: self.beneName, vpa: self.beneVpa, nickName: txtName.text ?? "")
        var strBeneVpa = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(beneVpa)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strBeneVpa = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }

//    send    Double and convert that to string
// receive   same into string and convert to Double
        
        let x = Double(self.txtAmount.text ?? "0")
        amtDecimal = String(format: "%.2f", Double(round(100 * x!) / 100))
        
        let paymentInput = PaymentInput(amount: "\(amtDecimal)", merchantVpa: MerchantVpa, merchantId: MerchantId, submerchantid: SubMerchantId, merchantChannelId: MerchChanId, tranType: "P2P", mcc: "0000", remarks: txtRemark.text ?? "", initMode: "00", purpose: "00", refCategory: "00")
        
        var strPaymentInput = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(paymentInput)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strPaymentInput = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }


        
        DispatchQueue.global(qos: .background).async {
            
            // Manage Response
            OliveUpiManager.initiatePay(account: strAccountDetails, benevpa: strBeneVpa, paymentInput: strPaymentInput, viewController: self) { data, error in
                
                if let err = error {
                    
                    if err.code == 102 || err.code == 108 { // Customer Accounts not found
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
                    
                    if let dataResp = data {
                        
                        print("dataResp =========>>>", dataResp)
                        
                        self.transId = dataResp as! String
                        
                        
                        // resp == Optional("{\"code\":\"00\",\"result\":\"Success\",\"data\":\"402983664696\",\"riskScoreValue\":\"00000\",\"checkSum\":null}")
                        
                        if self.btnAddBeneficiary.tag == 1 { // Beneficary add api call
                            self.saveBeneficary(dataResp: self.transId)
                            return
                        }
                        
                        DispatchQueue.main.async {
                            SwiftLoader.hide()
                            
                            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "PaymentSuccessfulVC") as! PaymentSuccessfulVC
                            
                            vc.accountDetails = self.accountDetails
                            vc.beneVpa = self.beneVpa
                            vc.beneName = self.beneName
                            vc.transId = self.transId
                            vc.amount = "\(self.amtDecimal)"
                            vc.fromScreenOption = "pay"

                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
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
                   // print(data)
                                        
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
    
    @IBAction func btnAddBeneficiaryAction(_ sender: UIButton) {
        
        if btnAddBeneficiary.tag == 0 {
            imgCheckUncheck.image = UIImage(named: "check")
            btnAddBeneficiary.tag = 1
        } else {
            imgCheckUncheck.image = UIImage(named: "uncheck")
            btnAddBeneficiary.tag = 0
        }
        
    }
    
}

extension PaymentUPIIDVC: MFMessageComposeViewControllerDelegate {
    
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
                if self?.checksumViewModel.checksumModel?.data?.result == "Success" {
                    Common.shared.merchantauthtoken = self?.checksumViewModel.checksumModel?.data?.data?.merchantauthtoken ?? ""
                    
                    self?.performMerchantHandshake()
                    
                }else{
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
            if self.apiCallOption == "pay" {
                self.btnProceedAction(UIButton())
            } else if self.apiCallOption == "bene" {
                self.saveBeneficary(dataResp: self.transId)
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
                        self.btnProceedAction(UIButton())
                    } else if self.apiCallOption == "bene" {
                        self.saveBeneficary(dataResp: self.transId)
                    }
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

//
//  MandateSuccessVC.swift
//  MaxPay
//
//  Created by india on 15/11/23.
//


import GameplayKit


import UIKit
import OlivePayLibrary
import SwiftLoader
import MessageUI

class MandateSuccessVC: BaseVC {

    var umnIDGener = ""
    var umnStr = ""
    
    private var checksumViewModel = SIMSelectionViewModel()

    var mandateObject: MandateListModel?
    var mandateTransactionObject: MandateTransactionModel?
    var accountDetails: AccountDetailsOnIIN?
    @IBOutlet weak var lblMandateVpa: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblFreq: UILabel!
    @IBOutlet weak var lblUMN: UILabel!
    @IBOutlet weak var lblValidity: UILabel!
    @IBOutlet weak var lblTransactionID: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var stackButtons: UIStackView!
    
    var isPending = false

    override func viewDidLoad() {
        super.viewDidLoad()

        lblMandateVpa.text = mandateObject?.payeeVpa ?? ""
        lblAmount.text = "₹ " + (mandateObject?.amount ?? "0")
        lblFreq.text = mandateObject?.recurrencePattern ?? ""
        lblUMN.text = mandateObject?.umn ?? ""
        lblValidity.text = mandateObject?.expdate ?? ""
        lblTransactionID.text = mandateObject?.txnid ?? ""
        lblStatus.text = (mandateObject?.status ?? "") == "P" ? "Pending" : (mandateObject?.status ?? "")
        
        stackButtons.isHidden = !isPending
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnRejectAction(_ sender: Any) {
        
        //  declineApproveMandate(declineApprove: MANDATE_DECLINE)
        
        declineMandate()
        
    }
    
    
    func randomString(length : Int) -> String {
        let charSet = Array("abcdefghijklmnopqrstuvwxyz")
        let shuffled = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: charSet) as! [Character]
        let array = shuffled.prefix(length)
        return String(array)
    }

    
    
    @IBAction func btnApproval(_ sender: Any) {
               // declineApproveMandate(declineApprove: MANDATE_APPROVE)
        
        approveMandate()
        
       // approveMandateBpn()
    }
    
    func declineMandate() {
        
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
        
        
        
        let x = Double(mandateObject?.amount ?? "0")
        let amtDecimal = String(format: "%.2f", Double(round(100 * x!) / 100))
        
        umnIDGener = mandateObject?.txnid ?? ""
        
        //print(mandateObject?.txnid ?? "")
        
      //  umnStr = umnIDGener.components(separatedBy: CharacterSet.decimalDigits).joined()
        
       // print(randomString(length: 32))

        umnStr = randomString(length: 32)
        
       // print(umnStr)

        
        let  baneObject = baneVpaModel(vpa: mandateObject?.payeeVpa ?? "", name:mandateObject?.beneName ?? "")
        
        let mandateInput = MandateInput(amount: amtDecimal, remark: "UPI", txnid: mandateObject?.txnid ?? "", umn: umnStr + accessMax, action: "DECLINE")
        
        var strMandateInput = ""
        
        var strBaneObj = ""
        
      
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(baneObject)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strBaneObj = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(mandateInput)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strMandateInput = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        DispatchQueue.global(qos: .background).async {
            
            OliveUpiManager.authorizeMandate(account: strAccountDetails,  beneVpa: strBaneObj, mandateInput:strMandateInput, viewController: self) { data, error in

           // OliveUpiManager.declineMandate(account: strAccountDetails, mandateInput: strMandateInput, viewController: self) { data, error in
                
                if let err = error {
                    if err.code == 102 || err.code == 108 { // 102 VPA not allowed for this customer, 108 Location has No access
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
                    
                    if let dt = data {
                       // print(dt)
                        
                        DispatchQueue.main.async {
                            
                            SwiftLoader.hide()
                            self.showToast(message: dt as! String)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                self.navigationController?.popViewController(animated: true)
                            })
                        }
                    }
                }
            }
        }
    }
    
    
    func approveMandateBpn() {
        
        
    }
    
    func approveMandate() {
        
        let accountDetails = AccountPay(name: accountDetails?.name ?? "", mmid: accountDetails?.mmid ?? "", aeba: accountDetails?.aeba ?? "", mbeba: accountDetails?.mbeba ?? "", accRefNumber: accountDetails?.accRefNumber ?? "", ifsc: accountDetails?.ifsc ?? "", maskedAccnumber: accountDetails?.maskedAccnumber ?? "", status: accountDetails?.status ?? "", type: accountDetails?.type ?? "", vpa: accountDetails?.vpa ?? "", dLength: accountDetails?.dLength ?? "", dType: accountDetails?.dType ?? "", balance: accountDetails?.balance ?? "", balTime: accountDetails?.balTime ?? "", accountIfsc: "00", iin: accountDetails?.iin ?? "")
        
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
        
        
        
        let x = Double(mandateObject?.amount ?? "0")
        let amtDecimal = String(format: "%.2f", Double(round(100 * x!) / 100))
        
        umnIDGener = mandateObject?.txnid ?? ""
        
        //print(mandateObject?.txnid ?? "")
        
        //umnStr = umnIDGener.components(separatedBy: CharacterSet.decimalDigits).joined()
        
        umnStr = randomString(length: 32)
        
       // print(umnStr)

        
        let  baneObject = baneVpaModel(vpa: mandateObject?.payeeVpa ?? "", name:mandateObject?.beneName ?? "")
        
        let mandateInput = MandateInput(amount: amtDecimal, remark: "UPI", txnid: mandateObject?.txnid ?? "", umn: umnStr + accessMax, action: "APPROVE")
        
        var strMandateInput = ""
        
        var strBaneObj = ""
        
      
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(baneObject)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strBaneObj = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(mandateInput)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strMandateInput = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        DispatchQueue.global(qos: .background).async {
            
            OliveUpiManager.authorizeMandate(account: strAccountDetails,  beneVpa: strBaneObj, mandateInput:strMandateInput, viewController: self) { data, error in

           // OliveUpiManager.declineMandate(account: strAccountDetails, mandateInput: strMandateInput, viewController: self) { data, error in
                
                if let err = error {
                    if err.code == 102 || err.code == 108 { // 102 VPA not allowed for this customer, 108 Location has No access
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
                    
                    if let dt = data {
                        //print(dt)
                        
                        DispatchQueue.main.async {
                            
                            SwiftLoader.hide()
                            self.showToast(message: dt as! String)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                self.navigationController?.popViewController(animated: true)
                            })
                        }
                    }
                }
            }
        }
    }
    
    
    
}


extension MandateSuccessVC: MFMessageComposeViewControllerDelegate {
    
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
                print("Data loaded...")

                if self?.checksumViewModel.checksumModel?.result == "Success" {
                    Common.shared.merchantauthtoken = self?.checksumViewModel.checksumModel?.data?.merchantauthtoken ?? ""
                    self?.performMerchantHandshake()
                }else{
                    DispatchQueue.main.async {
                        self?.showErrorAlert(self?.checksumViewModel.checksumModel?.result ?? "")
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
           // print("The data is:\(String(describing: data))")
            self.btnApproval(UIButton())
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
                    DispatchQueue.main.async {
                        self.showToast(message: "SMS Sent failed", font: .systemFont(ofSize: 12))
                        SwiftLoader.hide()
                    }
                } else {
                    self.btnApproval(UIButton())
                }
            })
            break
        default:
            break
        }
    }
}


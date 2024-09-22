//
//  UPIPaymentReject.swift
//  MaxPay
//
//  Created by india on 16/11/23.
//

import UIKit
import MessageUI
import SwiftLoader
import OlivePayLibrary

class UPIPaymentReject: BaseVC {
    
    @IBOutlet weak var lblReqVpaFrom: UILabel!
    @IBOutlet weak var lblReqVpato: UILabel!
    @IBOutlet weak var lblReqNameto: UILabel!
    @IBOutlet weak var lblReqAmt: UILabel!
    @IBOutlet weak var lblValidDate: UILabel!
    @IBOutlet weak var lblNote: UILabel!
    @IBOutlet weak var lblAccountType: UILabel!
    @IBOutlet weak var lblFromName: UILabel!
    @IBOutlet weak var lblCheckBalance: UILabel!

    private var checksumViewModel = SIMSelectionViewModel()
    open var notificationObj: PendingNotificationsListModel?
    var accountDetails: AccountDetailsOnIIN?
    var apiOption = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblReqVpaFrom.text = accountDetails?.vpa ?? ""
        lblReqVpato.text = notificationObj?.payeeVpa
        lblReqNameto.text = notificationObj?.beneName
        lblReqAmt.text = "₹\(notificationObj?.amount ?? "0")"
        lblValidDate.text = notificationObj?.expdate
        lblNote.text = notificationObj?.notes

        lblAccountType.text = accountDetails?.type
        lblFromName.text = accountDetails?.name

    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func btnRejectAction(_ sender: Any) {
  
        oliveRejectApiCall()
    }
    
    @IBAction func btnApprovalAction(_ sender: Any) {
        // done
        var strAccount = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(accountDetails)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strAccount = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        var strCollectBene = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(notificationObj)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strCollectBene = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }

        
        apiOption = "approve"
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        DispatchQueue.global(qos: .background).async {
            
            OliveUpiManager.collectApprove(account: strAccount, PendingReq: strCollectBene, viewController: self) { data, error in
                    
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
                    
                } else  {
                    
                    if let dt = data {
                        
                        DispatchQueue.main.async {
                            SwiftLoader.hide()
                            
                            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "PaymentSuccessfulVC") as! PaymentSuccessfulVC
                            
                            vc.accountDetails = self.accountDetails
                            vc.beneVpa = self.notificationObj?.payeeVpa ?? ""
                            vc.beneName = self.notificationObj?.beneName ?? ""
                            vc.transId = self.notificationObj?.txnid ?? ""
                            vc.amount = self.notificationObj?.amount ?? ""
                            vc.refNo = dt as! String
                            vc.fromScreenOption = "reqAppr"
                            
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                    
                }
            }
        }

    }
 
    @IBAction func btnBlockAction(_ sender: Any) {
        
        let vw = BlockalertView()
        vw.frame = UIScreen.main.bounds
        vw.setupUI("")
        vw.delegate = self
        view.addSubview(vw)
        
    }
 
    @IBAction func btnCheckBalanceAction(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        apiOption = "chkbal"
        
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
                
                DispatchQueue.global(qos: .background).async {

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
                            
                            let dataObject = data as! [String: Any]
                            
                            DispatchQueue.main.async {
                                SwiftLoader.hide()
                                self.lblCheckBalance.text = "₹\(dataObject["data"] as! String)"
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

extension UPIPaymentReject: BlockalertViewDelegate {
    
    // Block Popup handel
    
    func btnBlock() {
        oliveBlockApiCall()
    }
    func btnRejected() {
        oliveBlockApiCall()
        oliveRejectApiCall()
    }
    
    func oliveBlockApiCall() {
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        apiOption = "block"
        
        DispatchQueue.global(qos: .background).async {
            
            OliveUpiManager.collectBlockUnblock(vpa: self.notificationObj?.payerVpa ?? "", block: "B", reason: "fraud") { data, error in
                
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
                    
                } else  {

                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    func oliveRejectApiCall() {
        
        var strCollectBene = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(notificationObj)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strCollectBene = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        apiOption = "reject"
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        DispatchQueue.global(qos: .background).async {
            
            OliveUpiManager.collectReject(pendingReqVo: strCollectBene) { data, error in
                
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
                    
                } else  {
                    
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        
                        showAlertMessageWithOkAction(title: "MaxUPI", message: "Request Declined Successfully", vc: self) { status in
                            if status == 1 {
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
                        
                    }
                    
                }
            }
        }
    }
}

extension UPIPaymentReject: MFMessageComposeViewControllerDelegate {
    
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
            print("The data is:\(String(describing: data))")
            if self.apiOption == "reject" {
                self.btnRejectAction(UIButton())
            } else if self.apiOption == "approve" {
                self.btnApprovalAction(UIButton())
            } else if self.apiOption == "block" {
                self.btnBlockAction(UIButton())
            } else if self.apiOption == "chkbal" {
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
                    
                    if self.apiOption == "reject" {
                        self.btnRejectAction(UIButton())
                    } else if self.apiOption == "approve" {
                        self.btnApprovalAction(UIButton())
                    } else if self.apiOption == "block" {
                        self.btnBlockAction(UIButton())
                    } else if self.apiOption == "chkbal" {
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

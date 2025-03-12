//
//  PaymentUPIIDRequestNewVC.swift
//  MaxPay
//
//  Created by india on 13/11/23.
//

import UIKit
import OlivePayLibrary
import SwiftLoader
import MessageUI
import DatePicker

class PaymentUPIIDRequestNewVC: BaseVC {

    var contactData: ContactDetail?
    var accountDetails: AccountDetailsOnIIN?
    var beneVpa = ""
    var contactNumber = ""
    var beneName = ""
    var apiCallOption = ""
    var transId = ""
    private var checksumViewModel = SIMSelectionViewModel()
    
    var amtDecimal = ""
    
    @IBOutlet weak var lblUpiId: UILabel!
    @IBOutlet weak var lblUpiId21: UILabel!
    @IBOutlet weak var lblRegisteredName: UILabel!
    @IBOutlet weak var imgContact: UIImageView!
    @IBOutlet weak var lblCheckBalance: UILabel!
    @IBOutlet weak var lblFromName: UILabel!

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtRemark: UITextField!
    @IBOutlet weak var lblAmountText: UILabel!
    @IBOutlet weak var imgCheckUncheck: UIImageView!
    @IBOutlet weak var btnAddBeneficiary: UIButton!
    @IBOutlet weak var lblAccountType: UILabel!

    
    var txtRemarkStr = ""
    
    var expiryStr = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("contactNumber =============?? ",contactNumber)

        lblUpiId.text = accountDetails?.vpa ?? ""
        
        
        if beneVpa == ""{
            lblUpiId21.text = contactNumber
        }else{
            lblUpiId21.text =  beneVpa
        }
        
     //   lblUpiId21.text = beneVpa ?? contactNumber
        lblRegisteredName.text = beneName

        lblFromName.text = accountDetails?.name
        lblAccountType.text = accountDetails?.type

        if let imageData = contactData?.thumbnailImageData {
            imgContact.image = UIImage(data: imageData)
        } else {
            // Set a placeholder image if no contact image is available
            imgContact.image = UIImage(named: "me_profile")
        }
    }

    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnProccedAction(_ sender: UIButton) {
        
        
        txtRemarkStr = self.txtRemark.text ?? ""
        
        if Common.shared.collectRequestLimit != nil {
            if Common.shared.collectRequestLimit! >= COLLECT_REQUEST_LIMIT_PERDAY  {
                showAlertMessageWithOkAction(title: "MaxUPI", message: "You can place 5 collect request in a day", vc: self) { status in
                    if status == 1 {
                        self.navigationController?.popViewController(animated: true)
                        return
                    }
                }
            }
        }
        
        if self.txtAmount.text == "" {
            self.showErrorAlert("Please enter Amount")
            return
        }
        if self.txtDate.text == "" {
            self.showErrorAlert("Please enter Date")
            return
        }
        
        
        expiryStr = self.txtDate.text ?? ""

        
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        let accountDetails = AccountDetails(name: accountDetails?.name ?? "", aeba: accountDetails?.aeba ?? "", mbeba: accountDetails?.mbeba ?? "", accRefNumber: accountDetails?.accRefNumber ?? "", ifsc: accountDetails?.ifsc ?? "", maskedAccnumber: accountDetails?.maskedAccnumber ?? "", status: accountDetails?.status ?? "", type: accountDetails?.type ?? "", vpa: accountDetails?.vpa ?? "", dLength: accountDetails?.dLength ?? "", dType: accountDetails?.dType ?? "", balance: accountDetails?.balance ?? "", balTime: accountDetails?.balTime ?? "", atmpinFormat: accountDetails?.atmpinFormat ?? "", atmpinLength: accountDetails?.atmpinLength ?? "", iin: accountDetails?.iin ?? "", internationlActive: "N", otpFormat: accountDetails?.otpFormat ?? "")
                
        var strAccountDetails = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(accountDetails)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strAccountDetails = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }

        self.apiCallOption = "req"

        let x = Double(self.txtAmount.text ?? "0")
        self.amtDecimal = String(format: "%.2f", Double(round(100 * x!) / 100))
                
        
        let paymentInput = SaveBeneVpa(vpa: self.lblUpiId21.text!, name: self.lblRegisteredName.text!, nickname: self.txtName.text!)
        
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
            
            OliveUpiManager.initiateCollect(beneaccount: strAccountDetails, remittervpa: strPaymentInput, amount: self.amtDecimal, remarks:self.txtRemarkStr , merchantvpa: MerchantVpa, merchantid: MerchantId, submerchantid: SubMerchantId, merchantchannelid: MerchChanId, trantype: TranTypeP2P, expiry: /*"01/02/2024 15:30:50"*/ self.expiryStr , viewController: self) { data, error in
                                
                if let err = error {
                    
                    if err.domain == "Z7" {
                        DispatchQueue.main.async {
                            showAlertMessageWithOkAction(title: "MaxUpi", message: err.localizedDescription, vc: self) { status in
                                if  status == 1 {
                                    self.navigationController?.popViewController(animated: true)
                                }
                            }
                        }
                    } else if err.code == 102 || err.code == 108 { // Customer Accounts not found
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
                        
                        // NOTE: collectRequestLimit is not required, api gives err.domain == "Z7" with message
                        Common.shared.collectRequestLimit = Common.shared.collectRequestLimit == nil ? 1 : Common.shared.collectRequestLimit! + 1
                        
                        self.transId = dataResp as! String
                                                
                        if self.btnAddBeneficiary.tag == 1 { // Beneficary add api call
                            self.saveBeneficary(dataResp: self.transId)
                            return
                        }
                        // Request success screen
                        DispatchQueue.main.async {
                            SwiftLoader.hide()
                            
                            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "PaymentSuccessfulVC") as! PaymentSuccessfulVC
                            
                            vc.accountDetails = self.accountDetails
                            vc.beneVpa = self.beneVpa ?? self.contactNumber
                            vc.beneName = self.beneName
                            vc.transId = self.transId
                            vc.amount = self.amtDecimal
                            vc.fromScreenOption = "req"
                            
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
            }
        }
    }
    
    
    
    func saveBeneficary(dataResp: String) {
        
        self.apiCallOption = "bene"
        
        let saveBeneVpa = SaveBeneVpa(vpa: self.beneVpa ?? self.contactNumber, name: self.beneName, nickname: txtName.text!)
        
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
            
            OliveUpiManager.saveBeneVpa(bene: strSaveBeneVpa) { data, error in
                    
                if let err = error {
                    
                    if err.code == 108 { // Customer Accounts not found
                        DispatchQueue.main.async {
                            self.showErrorAlert(err.localizedDescription)
                        }
                    } else if err.code == 102 { // VPA already exist!
                        
                        DispatchQueue.main.async { [self] in
                            self.showErrorAlert(err.localizedDescription)
                            
                            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "PaymentSuccessfulVC") as! PaymentSuccessfulVC
                            
                            vc.accountDetails = self.accountDetails
                            vc.beneVpa = self.beneVpa ?? self.contactNumber
                            vc.beneName = self.beneName
                            vc.transId = self.transId
                            vc.amount = "\(self.amtDecimal)"
                            vc.fromScreenOption = "req"

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
                    print(data)
                                        
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        self.showToast(message: "Beneficiary added Successfully")
                        
                        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "PaymentSuccessfulVC") as! PaymentSuccessfulVC
                        
                        vc.accountDetails = self.accountDetails
                        vc.beneVpa = self.beneVpa ?? self.contactNumber
                        vc.beneName = self.beneName
                        vc.transId = self.transId
                        vc.refNo = data as! String
                        vc.fromScreenOption = "req"
                        
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
    
    @IBAction func btnDatePickerAction(_ sender: Any) {
        
        self.view.endEditing(true)
        let minDate = DatePickerHelper.shared.dateFrom(day: 01, month: 08, year: 2021)!
        let maxDate = DatePickerHelper.shared.dateFrom(day: 01, month: 08, year: 2024)!
        let today = Date()
        // Create picker object
        let datePicker = DatePicker()
        // Setup
        datePicker.setup(beginWith: today, min: minDate, max: maxDate) { (selected, date) in
            if selected, let selectedDate = date {
                print(selectedDate.string())
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                self.txtDate.text = formatter.string(from: selectedDate)
            } else {
                print("Cancelled")
            }
        }
        // Display
        datePicker.show(in: self, on: self.txtDate)
    }
    
    
    @IBAction func btnCheckBalanceAction(_ sender: UIButton) {
        
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

extension PaymentUPIIDRequestNewVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Check if the text field is the decimalTextField
        if textField == txtAmount {
            // Limit to only one decimal point
            if string == "." && textField.text?.contains(".") == true {
                return false
            }
            
            // Limit to only two digits after the decimal point
            if let text = textField.text, let range = Range(range, in: text) {
                let newText = text.replacingCharacters(in: range, with: string)
                let components = newText.components(separatedBy: ".")
                if components.count == 2 {
                    if components[1].count > 2 {
                        return false
                    }
                }
                // Limit the amount to 2000
                if let amount = Double(newText), amount > COLLECT_REQUEST_AMOUNT_LIMIT {
                    return false
                }
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .spellOut
                lblAmountText.text = numberFormatter.string(from: (Double(newText) ?? 0.00) as NSNumber)?.capitalizingFirstLetter()
            }
        } else {
            // For other text fields, limit the number of characters to 30
            if let text = textField.text, let range = Range(range, in: text) {
                let newText = text.replacingCharacters(in: range, with: string)
                return newText.count <= 30
            }
        }
        return true
    }
    
}

extension PaymentUPIIDRequestNewVC: MFMessageComposeViewControllerDelegate {
    
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
                if self?.checksumViewModel.checksumModel?.data?.result.lowercased() == "success" {
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
            if self.apiCallOption == "req" {
                self.btnProccedAction(UIButton())
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
                    if self.apiCallOption == "req" {
                        self.btnProccedAction(UIButton())
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

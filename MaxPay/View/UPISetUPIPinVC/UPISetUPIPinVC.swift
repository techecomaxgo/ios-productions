//
//  UPISetUPIPinVC.swift
//  MaxPay
//
//  Created by india on 17/11/23.
//

import UIKit
import Contacts
import OlivePayLibrary
import SwiftLoader
import MessageUI
import Alamofire

class UPISetUPIPinVC: BaseVC {

    @IBOutlet weak var txtCardDigitThird: UITextField!
    @IBOutlet weak var txtCardDigitFourth: UITextField!
    
    @IBOutlet weak var txtExpiryMonth: UITextField!
    @IBOutlet weak var txtExpiryYear: UITextField!
    
    @IBOutlet weak var imgBankLogo: UIImageView!
    @IBOutlet weak var lblBankName: UILabel!
    
    var accountDetails: AccountDetailsOnIIN?
    var primaryAccountDetails: AccountDetails?
    private var checkSumviewModel = SIMSelectionViewModel()
    private var addUpiUserViewModel = AddUpiUserViewModel()
    var strSixDigitCardNumber = ""
    var expiryCard = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.configuration()
        
        txtCardDigitThird.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtCardDigitFourth.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtExpiryMonth.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtExpiryYear.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        lblBankName.text = accountDetails?.bankName
        
        if let logo = accountDetails?.bankLogo {
            if logo == "" {
                imgBankLogo.image = UIImage(named: "bank_logo")
            } else {
                Alamofire.request(logo).response { response in
                    if let data = response.data {
                        let image = UIImage(data: data)
                        self.imgBankLogo.image = image
                    } else {
                        print("Data is nil. I don't know what to do :(")
                        self.imgBankLogo.image = UIImage(named: "bank_logo")
                    }
                }
            }
        } else {
            imgBankLogo.image = UIImage(named: "bank_logo")
        }

        txtCardDigitThird.becomeFirstResponder()

        NotificationCenter.default.addObserver(self, selector: #selector(poptoDashboard), name: Notification.Name("NotificationPoptoDashboard3"), object: nil)

    }
    
    @objc func poptoDashboard() {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: DashboardVC.self) {
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
    
    @IBAction func btnSetUpiPinAction(_ sender: Any) {
        
        strSixDigitCardNumber = (txtCardDigitThird.text ?? "") + (txtCardDigitFourth.text ?? "")
        strSixDigitCardNumber = strSixDigitCardNumber.replacingOccurrences(of: " ", with: "")

        let expiryMonth = (txtExpiryMonth.text ?? "").replacingOccurrences(of: " ", with: "")
        let expiryYear = (txtExpiryYear.text ?? "").replacingOccurrences(of: " ", with: "")
        
        if strSixDigitCardNumber.count > 6 || strSixDigitCardNumber.count < 6 {
            self.showErrorAlert("Enter valid last 6 digit card number")
            return
        }
        
        if MyBasics.isValidExpiryDate(expiryMonth: expiryMonth, expiryYear: expiryYear) {
            expiryCard = expiryMonth + expiryYear
        } else {
            self.showErrorAlert("Enter valid expiry date of card")
            return
        }
        
//        configuration()
        setUPIPin()
    }
    
    func setUPIPin() {
                
        if let iin = accountDetails?.iin {
            
            let accountDetails = AccountDetails(name: accountDetails?.name ?? "", aeba: accountDetails?.aeba ?? "", mbeba: accountDetails?.mbeba ?? "", accRefNumber: accountDetails?.accRefNumber ?? "", ifsc: accountDetails?.ifsc ?? "", maskedAccnumber: accountDetails?.maskedAccnumber ?? "", status: accountDetails?.status ?? "", type: accountDetails?.type ?? "", vpa: accountDetails?.vpa ?? "", dLength: accountDetails?.dLength ?? "", dType: accountDetails?.dType ?? "", balance: accountDetails?.balance ?? "", balTime: accountDetails?.balTime ?? "", atmpinFormat: accountDetails?.atmpinFormat ?? "", atmpinLength: accountDetails?.atmpinLength ?? "", iin: accountDetails?.iin ?? "", internationlActive: "N", otpFormat: accountDetails?.otpFormat ?? "")
            primaryAccountDetails = accountDetails
                            
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

            DispatchQueue.main.async {
                SwiftLoader.show(animated: true)
            }
            
            DispatchQueue.global(qos: .background).async {
                // Working Properly
                OliveUpiManager.activateAccount(iin: iin, account: jsonObjectString, cardNo: self.strSixDigitCardNumber, exp: self.expiryCard, viewController: self) { data, error in
                    
                    if let err = error {
                        
                        if err.domain == "F06" {
                            self.showErrorAlert("CRED DATA IS WRONG")
                        }
                        
                        if err.code == 102 || err.code == 000021 { // VPA not allowed for this customer
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
                       
                        //print(data)
                        self.addUpiUserConfiguration()
                    }
                }
            }
        }

    }
    
    func isNumeric(_ vpa: String) -> Bool {
        let numericCharacterSet = CharacterSet.decimalDigits
        return vpa.rangeOfCharacter(from: numericCharacterSet.inverted) == nil
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

extension UPISetUPIPinVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Ensure that only digits are entered
        
        let allowedCharacterSet = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        guard let currentText = textField.text else { return true }
        
        // Allow only digits
        guard allowedCharacterSet.isSuperset(of: characterSet) else {
            return false
        }
        
        if (currentText.count == 1 || currentText.count == 3 || currentText.count == 5) && !string.isEmpty {
            textField.text = currentText + " "
        }
        
        return allowedCharacterSet.isSuperset(of: characterSet) && isWithinMaxLength(textField, range: range, replacementString: string)
    }
        
    // Custom method to check if the text length is within the limit
    private func isWithinMaxLength(_ textField: UITextField, range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
                
        let maxLength = textField == txtCardDigitFourth ? 7 : textField == txtCardDigitThird ? 3 : 3
        let newLength = currentText.count + string.count - range.length
        return newLength <= maxLength

    }
    
    
    @objc func textFieldDidChange(textField: UITextField){

        let text = textField.text

        if textField != txtCardDigitFourth {
            if (text?.utf16.count)! >= 3 {
                switch textField{
                case txtCardDigitThird:
                    txtCardDigitFourth.becomeFirstResponder()
                    
                case txtCardDigitFourth:
                    txtExpiryMonth.becomeFirstResponder()
                    
                case txtExpiryMonth:
                    txtExpiryYear.becomeFirstResponder()
                    
                default:
                    break
                }
            }else{
                //            switch textField{
                //            case txtCardDigitFourth:
                //                txtCardDigitThird.resignFirstResponder()
                //
                //            case txtCardDigitThird:
                //                txtCardDigitThird.becomeFirstResponder()
                //
                //            default:
                //                break
                //            }
            }
        } else {
            if (text?.utf16.count)! >= 7 {
                switch textField{
                    
                case txtCardDigitFourth:
                    txtExpiryMonth.becomeFirstResponder()
                                        
                default:
                    break
                }
            }
        }
    }
    
}

extension UPISetUPIPinVC: MFMessageComposeViewControllerDelegate {

    func configuration() {
        initChecksum()
        observeEvent()
    }
    
    func initChecksum() {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            checkSumviewModel.loginChecksumCall(Common.shared.phoneNo ?? "", Common.shared.getDeviceID() ?? "")
        }else{
            DispatchQueue.main.async {
                SwiftLoader.hide()
                self.showErrorAlert("Please check your internet connection.")
            }
        }
    }
    
    
    //MARK: Observing the data
    func observeEvent() {
        checkSumviewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }

            switch event {
            case .loading:
                
                print("loading....")
                
            case .stopLoading:
                
                print("Stop loading...")

            case .dataLoaded:
                print("Data loaded...")

                if self?.checkSumviewModel.checksumModel?.status == "Success" {
                    Common.shared.merchantauthtoken = self?.checkSumviewModel.checksumModel?.data?.data?.merchantauthtoken ?? ""
                    
                    self?.performMerchantHandshake()
                    
                }else{
                    DispatchQueue.main.async {
                        self?.showErrorAlert(self?.checkSumviewModel.checksumModel?.message ?? "")
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
            
            DispatchQueue.main.async {
                if let error = err {
                    print("Error: \(error)")
                    // Handle the error accordingly (e.g., show an alert)
                    
                    DispatchQueue.main.async {
                        self.showErrorAlert(error.localizedDescription)
                        SwiftLoader.hide()
                    }
                    
                    
                } else {
                    print("The data is: \(String(describing: data))")
                    self.setUPIPin()
                }
                SwiftLoader.hide()
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
                    if let dt = data{
                        self.setUPIPin()
                    }
                }
            })
            break
        default:
            break
        }
    }

}

extension UPISetUPIPinVC {
    
    //MARK: API Calling
    func addUpiUserConfiguration() {
        
        SwiftLoader.show(animated: true)
        initViewModel()
        observeEvent()
    }
    //MARK Network checking
    func initViewModel() {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            self.addUpiUserViewModel.addUpiUserCall(account: primaryAccountDetails!)
        }else{
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internetconnection.")
            
        }
    }
    //MARK: Observing the data
    func addUpiUserObserveEvent() {
        addUpiUserViewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }
            
            switch event {
                
            case .loading:
                print("Loading...")
                
            case .stopLoading:
                print("stopLoading...")
                
            case .dataLoaded:
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                    if self?.addUpiUserViewModel.addUpiUserModel?.status == "success" {
                        // store new card's vpa locally
                        self?.retriveAndStoreAccount()
                        
                        DispatchQueue.main.async {
                            SwiftLoader.hide()
                            if let nav = self?.navigationController?.viewControllers {
                                print(nav)
                            }
                            
                            for controller in (self?.navigationController!.viewControllers)! as Array {
                                if controller.isKind(of: DashboardVC.self) {
                                    self?.navigationController!.popToViewController(controller, animated: true)
                                    break
                                }
                            }
                            
                        }
                    } else{
                        self?.showErrorAlert(self?.addUpiUserViewModel.addUpiUserModel?.message ?? "")
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

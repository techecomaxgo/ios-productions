//
//  SelectBankVC.swift
//  MaxPay
//
//  Created by india on 13/11/23.
//

import UIKit
import SwiftLoader
import OlivePayLibrary
import MessageUI
import ObjectMapper
import Kingfisher
import Alamofire
import CoreLocation

class SelectBankVC: BaseVC, MFMessageComposeViewControllerDelegate,CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!

    
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var tblBankSearch: UITableView!
    private var checksumViewModel = SIMSelectionViewModel()
    private var validateUpiOTPViewModel = ValidateUpiOTPViewModel()
    var accountDetails = [AccountDetailsOnIIN]()

    var filteredData: [Banks] = []
    open var updatedAccountList: [Banks] = []
    var selectedFilteredData: Banks?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize and configure CLLocationManager
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        
        tblBankSearch.dataSource = self
                
        performMerchantHandshake()
        

        NotificationCenter.default.addObserver(self, selector: #selector(poptoDashboard), name: Notification.Name("NotificationPoptoDashboard"), object: nil)
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
    
//    func performMerchantHandshake(){
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
//            SwiftLoader.show(animated: true)
//        })
//        
//        let sdkHandShake = SDKHandshake(emailId: "", merchId: "MAXPE", merchChanId: "MAXPE", submerchantid: "OLIVE", mcccode: "7322", unqCustId: "91\(Common.shared.phoneNo ?? "")", mobileNo: "91\(Common.shared.phoneNo ?? "")", deviceid: Common.shared.getDeviceID(), appid: appId, custname: "MAX", merchantauthtoken: Common.shared.merchantauthtoken ?? "", unqTxnId:SDKHandshake.shared.generateRandomDigits(12))
//        
//        let jsonString = sdkHandShake.jsonString(sdkHandShake)
//        
//        DispatchQueue.global(qos: .background).async {
//            
//            OliveUpiManager.initiateSDK(sdkHandshake: jsonString,view: self , delegate: self) { (data, err) in
//                print("The data is:\(String(describing: data))")
//                self.fetchListBanks()
//            }
//        }
//    }
    

    func performMerchantHandshake() {
            // Show loader on the main thread
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                SwiftLoader.show(animated: true)
            }

            // Background queue for the handshake process
            DispatchQueue.global(qos: .userInitiated).async {
//                let sdkHandShake = SDKHandshake(
//                    emailId: "",
//                    merchId: "ECOMAXGOPROD1234",
//                    merchChanId: "ECOMAXGOPROD1234",
//                    submerchantid: "ECOMAXGOPROD1234",
//                    mcccode: "6211",
//                    unqCustId: "918077019446",
//                    mobileNo: "918077019446",
//                    deviceid: Common.shared.getDeviceID(),
//                    appid: appId,
//                    custname: "MAX",
//                    merchantauthtoken: Common.shared.merchantauthtoken ?? "",
//                    unqTxnId: SDKHandshake.shared.generateRandomDigits(12)
//                )
                
                let sdkHandShake = SDKHandshake(
                    emailId: "",
                    merchId: "ECOMAXGOPROD1234",
                    merchChanId: "ECOMAXGOPROD1234",
                    submerchantid: "ECOMAXGOPROD1234",
                    mcccode: "6211",
                    unqCustId: "91\(Common.shared.phoneNo ?? "")",
                    mobileNo: "91\(Common.shared.phoneNo ?? "")",
                    deviceid: Common.shared.getDeviceID(),
                    appid: appId,
                    custname: "MAX",
                    merchantauthtoken: Common.shared.merchantauthtoken ?? "",
                    unqTxnId: SDKHandshake.shared.generateRandomDigits(12)
                )
                
                let jsonString = sdkHandShake.jsonString(sdkHandShake)
                
                OliveUpiManager.initiateSDK(sdkHandshake: jsonString, view: self, delegate: self) { (data, err) in
                    // Ensure fetchListBanks() runs on the main thread
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
                            self.fetchListBanks()
                        }
//                        self.fetchListBanks()
                        SwiftLoader.hide()
                    }
                }
            }
        }


    public func messageComposeViewController(_ controller: MFMessageComposeViewController,didFinishWith didFinishWithresult: MessageComposeResult) {
        controller.dismiss(animated: true, completion: {
            
            switch didFinishWithresult {
            case .cancelled:
                print("Cancelled")
                
                SwiftLoader.hide()
            case .sent:
                print("Message Sent")
                OliveUpiManager.sendMobileBindReqst(callback: { (data, err) in
                    if let er = err{
                        print(er)
                        DispatchQueue.main.async {
                            // self.showToast(message: "SMS Sent failed", font: .systemFont(ofSize: 12))
                            showAlertMessageWithActionButton(title: "MaxUPI", message: "SMS Sent failed. Resend again?", actionButtonText: "Ok", cancelActionButtonText: "Cancel", vc: self) { option in
                                if option == 1 {
                                    self.performMerchantHandshake()
                                }
                            }
                            SwiftLoader.hide()
                        }
                    }else{
                        if let dt = data{
                            print(dt)
                            DispatchQueue.main.async {
                                self.validateUpiOTPconfiguration()
                                self.showToast(message: "SMS Delivered", font: .systemFont(ofSize: 12))
                            }
                        }
                    }
                })
                break
            default:
                break
            }
            
        })
    }
   
    func  fetchListBanks(){
        
        // Working Properly
        OliveUpiManager.fetchListBanks() { (data, err) in
            if let e = err{
               
                DispatchQueue.main.async {
                    self.showErrorAlert(e.localizedDescription)
                    SwiftLoader.hide()
                }
                
            } else {
                if let json = data as? [Any] {
                    
                    self.updatedAccountList.removeAll()
                    self.filteredData.removeAll()
                    
                    // set device binding upto 3
                    Common.shared.deviceBindingLimit = Common.shared.deviceBindingLimit == nil ? 1 : Common.shared.deviceBindingLimit! + 1
                    
                    for jsonObj in json {
                        
                        if let bank = Banks(json: jsonObj as! [String : Any]) {
                            
                            self.updatedAccountList.append(bank)
                            
                        } else {
                            print("Error initializing Bank object from JSON")
                        }
                        
                    }
                    self.filteredData = self.updatedAccountList
                    DispatchQueue.main.async {
                        self.tblBankSearch.reloadData()
                        SwiftLoader.hide()
                    }
                }
                
            }
        }
    }
        
}


extension SelectBankVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BankSearchCell", for: indexPath) as! BankSearchCell
        cell.selectionStyle = .none
        cell.lblBankName?.text = filteredData[indexPath.row].name
        if let logo = filteredData[indexPath.row].logo {
            if logo == "" {
                cell.imgBankIcon.image = UIImage(named: "bank_logo")
            } else {
                Alamofire.request(logo).response { response in
                    if let data = response.data {
                        let image = UIImage(data: data)
                        cell.imgBankIcon.image = image
                    } else {
                        print("Data is nil. I don't know what to do :(")
                    }
                }
            }
        } else {
            cell.imgBankIcon.image = UIImage(named: "bank_logo")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredData.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        textFieldSearch.resignFirstResponder()
        
        selectedFilteredData = self.filteredData[indexPath.row]
        
        self.fetchAccountsiin(bankAccount: self.filteredData[indexPath.row])
    }

    
    func fetchAccountsiin(bankAccount: Banks) {
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        DispatchQueue.global(qos: .background).async {
            
            // Working Properly
            OliveUpiManager.fetchAccountsiin(iin: bankAccount.iin ?? "", accountType: "") { data, error in
                
                if let err = error {
                    
                    if err.code == 401 || err.code == 107 {
                        
                        self.configuration()
                        return
                        
                    } else {
                        DispatchQueue.main.async {
                            self.showErrorAlert(err.localizedDescription)
                            SwiftLoader.hide()
                        }
                    }
                } else {
                    
                    if let json = data as? [Any] {
                        
                        for jsonObj in json {
                            
                            let data = SelectBankVC.convertToData(jsonObj)
                            
                            do {
                                var bank = try JSONDecoder().decode(AccountDetailsOnIIN.self, from: data!)
                                bank.bankName = bankAccount.name
                                bank.bankLogo = bankAccount.logo
                                self.accountDetails.append(bank)
                            } catch {
                                DispatchQueue.main.async {
                                    SwiftLoader.hide()
                                }
                                print(error.localizedDescription)
                            }
                        }
                        
                        DispatchQueue.main.async {
                            SwiftLoader.hide()
                            
                            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "SelectedBankAccountVC") as! SelectedBankAccountVC
                            vc.accountDetails = self.accountDetails
//                                vc.accountDetails?.bankName = bankAccount.name
//                                vc.accountDetails?.bankLogo = bankAccount.logo
                            self.navigationController?.pushViewController(vc, animated: true)
                        }

                    }
                }
            }
        }
    }
    
    static func convertToData(_ object: Any) -> Data? {
        if let data = object as? Data {
            // If object is already Data, no conversion needed
            return data
        } else if let string = object as? String {
            // If object is String, convert it to Data using UTF-8 encoding
            return string.data(using: .utf8)
        } else if let number = object as? NSNumber {
            // If object is NSNumber, convert it to Data
            return number.stringValue.data(using: .utf8)
        } else if let array = object as? [Any] {
            // If object is an array, convert it to Data using JSONSerialization
            do {
                return try JSONSerialization.data(withJSONObject: array)
            } catch {
                print("Error converting array to Data: \(error)")
                return nil
            }
        } else if let dictionary = object as? [String: Any] {
            // If object is a dictionary, convert it to Data using JSONSerialization
            do {
                return try JSONSerialization.data(withJSONObject: dictionary)
            } catch {
                print("Error converting dictionary to Data: \(error)")
                return nil
            }
        }

        // Handle other cases or return nil if the type is not supported
        print("Unsupported type for conversion to Data")
        return nil
    }

    
    // Checksum
    func configuration() {
        initViewModel()
        observeEvent()
    }
    
    //MARK Network checking
    func initViewModel() {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            checksumViewModel.loginChecksumCall(Common.shared.phoneNo ?? "", Common.shared.getDeviceID())
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
                        
                        self?.fetchAccountsiin(bankAccount: (self?.selectedFilteredData)!)
                        
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
}

extension SelectBankVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let searchText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        filteredData = searchText.isEmpty ? updatedAccountList : updatedAccountList.filter({(dataString: Banks) -> Bool in
            return dataString.name?.range(of: searchText, options: .caseInsensitive) != nil
        })

        tblBankSearch.reloadData()

        return true
    }
    
}

extension SelectBankVC {
    // validate Upi OTP configuration
    func validateUpiOTPconfiguration() {
        validateUpiOTPInitViewModel()
        validateUpiOTPObserveEvent()
    }
    
    //MARK Network checking
    func validateUpiOTPInitViewModel() {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
           // validateUpiOTPViewModel.validateUpiOTPCall(Common.shared.getDeviceID())
        }else{
            DispatchQueue.main.async {
                SwiftLoader.hide()
                self.showErrorAlert("Please check your internet connection.")
            }
        }
    }
    
    //MARK: Observing the data
    func validateUpiOTPObserveEvent() {
        validateUpiOTPViewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }
            
            switch event {
            case .loading:
                
                print("loading....")
                
            case .stopLoading:
                
                print("Stop loading...")
                
            case .dataLoaded:
                print("Data loaded...")
                
                if self?.validateUpiOTPViewModel.validateUpiOTPModel?.status == "Success" {
                    print(self?.validateUpiOTPViewModel.validateUpiOTPModel?.data?.otp,self?.validateUpiOTPViewModel.validateUpiOTPModel?.data?.otp)
                    self?.fetchListBanks()
                }else{
                    DispatchQueue.main.async {
                        self?.showErrorAlert(self?.validateUpiOTPViewModel.validateUpiOTPModel?.message ?? "")
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

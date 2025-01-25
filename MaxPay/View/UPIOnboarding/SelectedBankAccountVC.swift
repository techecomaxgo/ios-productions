//
//  SelectedBankAccountVC.swift
//  MaxPay
//
//  Created by india on 13/11/23.
//

import UIKit
import SwiftLoader
import Alamofire
import MessageUI
import OlivePayLibrary

class SelectedBankAccountCell: UITableViewCell {
    
    @IBOutlet weak var btnPinExistIcon: UIButton!
    @IBOutlet weak var lblBankName: UILabel!
    @IBOutlet weak var imgBankLogo: UIImageView!
    @IBOutlet weak var lblHolderName: UILabel!
    @IBOutlet weak var lblAccountNo: UILabel!
    @IBOutlet weak var lblIfsc: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblExistingUpi: UILabel!
    
    @IBOutlet weak var viewSixDigitBg: UIView!
    @IBOutlet weak var viewExistingUpiBg: UIView!

    
    func setObject(bankObject: AccountDetailsOnIIN) {
        
        lblBankName.text = bankObject.bankName
        lblHolderName.text = bankObject.name
        lblAccountNo.text = bankObject.maskedAccnumber
        lblIfsc.text = bankObject.ifsc
        lblType.text = bankObject.type
        lblExistingUpi.text = bankObject.vpa
        
        viewSixDigitBg.isHidden = bankObject.vpa == ""
        viewExistingUpiBg.isHidden = bankObject.vpa == ""
        
        // mbeba = “Y” then MPIN is already set
        // mbeba = “N” we have to set the MPIN
        btnPinExistIcon.setImage(bankObject.mbeba == "N" ? UIImage(named: "wrong-ic") : UIImage(named: "right-ic"), for: .normal)
     
        if let logo = bankObject.bankLogo {
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
    }
}


class SelectedBankAccountVC: BaseVC {
    
    var accountDetails = [AccountDetailsOnIIN]()
    private var notificationViewModel = NotificationViewModel()
    private var checksumViewModel = SIMSelectionViewModel()
    var bankObject: AccountDetailsOnIIN?
    @IBOutlet weak var tableBanksAccounts: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        NotificationCenter.default.addObserver(self, selector: #selector(poptoDashboard), name: Notification.Name("NotificationPoptoDashboard1"), object: nil)
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
    
    func setChangeMpin(bankObject: AccountDetailsOnIIN) {
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }

        let accountDetails = AccountCheckBalance(name: bankObject.name ?? "", mmid: bankObject.mmid ?? "", aeba: bankObject.aeba ?? "", mbeba: bankObject.mbeba ?? "", accRefNumber: bankObject.accRefNumber ?? "", ifsc: bankObject.ifsc ?? "", maskedAccnumber: bankObject.maskedAccnumber ?? "", status: bankObject.status ?? "", type: bankObject.type ?? "", vpa: bankObject.vpa ?? "", dLength: bankObject.dLength ?? "", dType: bankObject.dType ?? "", balance: bankObject.balance ?? "", balTime: bankObject.balTime ?? "")

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

        
        if accountDetails.status == "R" { // upi mpin not set / not active
            
            if accountDetails.vpa == "" {
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "UPILinkUpdateVC") as! UPILinkUpdateVC
                    vc.accountDetails = bankObject
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            } else {
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "UPISetUPIPinVC") as! UPISetUPIPinVC
                    vc.accountDetails = bankObject
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
        } else if accountDetails.status == "A" { // Account active
            
            if accountDetails.vpa != "" {
                DispatchQueue.main.async {
                    SwiftLoader.show(animated: true)
                }
                DispatchQueue.global(qos: .background).async {
                    
                    // Working Properly
                    OliveUpiManager.changeMpin(bankid: bankObject.iin ?? "", account: jsonObjectString, viewController: self) { data, error in
                        
                        if let err = error {
                            
                            if err.code == 102 { // VPA not allowed for this customer
                                DispatchQueue.main.async {
                                    self.showErrorAlert(err.localizedDescription)
                                }
                            } else if err.code == 401 || err.code == 107 {
                                
                                self.checksumConfiguration()
                                return
                            }
                            DispatchQueue.main.async {
                                SwiftLoader.hide()
                            }
                                                        
                        } else {
                            
                            DispatchQueue.main.async {
                                print(data ?? "")
                                SwiftLoader.hide()
                                self.showErrorAlert("MPIN Set Successfully")
                                
                                
                                // call update token api
                                self.configurationNotification(token: Common.shared.fcmToken ?? "", vpa_address: bankObject.vpa ?? "", acc_num: bankObject.maskedAccnumber ?? "", ifsc_code: bankObject.ifsc ?? "")
                                
                            }
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "UPILinkUpdateVC") as! UPILinkUpdateVC
                    vc.accountDetails = bankObject
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
        }
    }
}

extension SelectedBankAccountVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SelectedBankAccountCell
        
        cell.setObject(bankObject: accountDetails[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        bankObject = accountDetails[indexPath.row]
        
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
        let results = accountDetailsArr.filter { $0.maskedAccnumber == bankObject?.maskedAccnumber }
        if results.isEmpty == true {
            accountDetailsArr.append(bankObject!)
        }

        
        do {
            // Convert Arr of cards to Data
            let placesData = try JSONEncoder().encode(accountDetailsArr)
            // Stored data of array to user defaults
            Common.shared.myCards = placesData
            
            if bankObject?.vpa == "" || bankObject?.vpa == nil || Common.shared.isDeregistered == true {
                // set UPI Id
                let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "UPILinkUpdateVC") as! UPILinkUpdateVC
                vc.accountDetails = bankObject
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else if bankObject?.mbeba == "N" {
                // set MPIN
                setChangeMpin(bankObject: bankObject!)
            } else {
                // call api
                self.configurationNotification(token: Common.shared.fcmToken ?? "", vpa_address: bankObject?.vpa ?? "", acc_num: bankObject?.maskedAccnumber ?? "", ifsc_code: bankObject?.ifsc ?? "")
            }

        } catch {
            print(error.localizedDescription)
        }
    }
    
}

extension SelectedBankAccountVC: MFMessageComposeViewControllerDelegate {
    
    func checksumConfiguration() {
        initChecksumViewModel()
        observeChecksumEvent()
    }
    
    
    //MARK Network checking
    func initChecksumViewModel() {
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
    func observeChecksumEvent() {
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
        
        OliveUpiManager.initiateSDK(sdkHandshake: jsonString, view: self, delegate: self) { (data, err) in
            print("The data is:\(String(describing: data))")
            self.setChangeMpin(bankObject: self.bankObject!)
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
                        print(dt)
                        self.setChangeMpin(bankObject: self.bankObject!)
                    }
                }
            })
            break
        default:
            break
        }
    }
    
}

extension SelectedBankAccountVC {
    
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
                
               // print(self?.navigationController!.viewControllers)
                
                for controller in (self?.navigationController!.viewControllers)! as Array {
                    if controller.isKind(of: DashboardVC.self) {
                        self?.navigationController!.popToViewController(controller, animated: true)
                        self?.tabBarController?.tabBar.isHidden = false

                        break
                    }
                }

            case .error(let error):
                print(error!)

            }
        }
    }
}

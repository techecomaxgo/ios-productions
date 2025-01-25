//
//  UPINumberVC.swift
//  MaxPay
//
//  Created by Admin on 24/06/24.
//

import UIKit
import Toast_Swift
import SwiftLoader
import OlivePayLibrary


class UPINumberVC: BaseVC {

    @IBOutlet weak var txtMobNumber: UITextField!
    
    private var checksumViewModel = SIMSelectionViewModel()

    var accountDetails: AccountDetailsOnIIN?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configuration()
    }
    
    
    
    
    
    @IBAction func btnCreateClicked(_ sender: UIButton) {
        
        guard let text = txtMobNumber.text, let number = Int(text) else {
            
            self.view.makeToast("Invalid input", duration: 1.0, position: .bottom)

                   return
               }
               
               if isNumberBetween8And9Digits(number) {
                   
                   
                   
                   
                   
               } else {
                   
                   self.view.makeToast("Number is not between 8 and 9 digits", duration: 1.0, position: .bottom)

                   
               }
        
        
    }
    
    
    
    
    
    
    
    func isNumberBetween8And9Digits(_ number: Int) -> Bool {
            if number <= 0 {
                return false
            }
            
            let numberOfDigits = String(number).count
            return numberOfDigits >= 8 && numberOfDigits <= 9
        }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func btnMenuClicked(_ sender: UIButton) {
        
        
        
    }
    
    
    func AddUpiNumber() {
        
        // UpiLinkToNumber
        let upiLinkNumber = UpiLinkToNumber(customerid: "91" + (Common.shared.phoneNo ?? "") ?? "", vpa: accountDetails?.vpa ?? "", regIdType: "MOBILE", regIdValue: "8076396412", status: "VPA", operationType: "ADD", consent: "Y", note: "PRCM04B", prevVpa: "", mobile: Common.shared.phoneNo ?? "")
        
        
        var upiLinkNumberMapper = ""
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(upiLinkNumber)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                upiLinkNumberMapper = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        print(upiLinkNumberMapper)
        
        DispatchQueue.main.async {
     
            OliveUpiManager.regMapper(mapper: upiLinkNumberMapper, callback: { (data, err) in
                if let err = err{
                    
                    if err.code == 102 || err.code == 108 { // Customer Accounts not found
                        DispatchQueue.main.async {
                            self.showErrorAlert(err.localizedDescription)
                        }
                    } else if err.code == 401 || err.code == 107 {
                        
                        //self.configuration()
                        
                        return
                        
                    }
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                    }

                } else {
                    
                    if let dt = data {
                        
                        print(dt)
                        
                    }
                    
                }
            })
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension UPINumberVC: MFMessageComposeViewControllerDelegate {
    
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
                if self?.checksumViewModel.checksumModel?.status == "Success" {
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
           
            //self.checkvpa(vpa: self.txtUPIID.text!)
            
            

            self.AddUpiNumber()
            
            
            
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

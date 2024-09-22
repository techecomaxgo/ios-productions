//
//  ManageUPIVC.swift
//  MaxPay
//
//  Created by Admin on 24/06/24.
//

import UIKit
import SwiftLoader
import OlivePayLibrary

class ManageUPIVC: BaseVC {

    private var checksumViewModel = SIMSelectionViewModel()

    var accountDetails: AccountDetailsOnIIN?
    var UPIAddressRequest: UPIAddressRequest?
    var RegMapper: RegMapper?
    
    var clickView = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configuration()
        
       // print(accountDetails?.vpa ?? "")
        
    }
    
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    
    
    @IBAction func btnLinkClicked(_ sender: UIButton) {
        
        
        clickView = "Link"
    
    
        let storyBoard: UIStoryboard = UIStoryboard(name: "BhimUpi", bundle: nil)
        
        let vc = storyBoard.instantiateViewController(withIdentifier: "ManageLinkVC") as! ManageLinkVC
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
       // linkToUpiNumber()
        
        configuration()
                
        
    }
    
    
    func linkToUpiNumber() {
        
     
        
        
        let upiLinkNumber = UpiLinkToNumber(customerid: "91" + (Common.shared.phoneNo ?? "") ?? "", vpa: accountDetails?.vpa ?? "", regIdType: "MOBILE", regIdValue: "8896958466", status: "VPA", operationType: "ADD", consent: "Y", note: "PRCM04B", prevVpa: "", mobile: Common.shared.phoneNo ?? "")
        
        
        
      //  let upiLinkNumber = UpiLinkToNumber(customerid: "", vpa: "", regIdType: "", regIdValue: "", status: "", operationType: "", consent: "", note: "", prevVpa: "", deviceDetails: DeviceDetails)
        
        
        print("upiLinkNumber ====",upiLinkNumber)
        
        
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
    
    
    func getAddress() {
        
        //UPIGAddress
        
        //AXI32921C48F41643AC99D514EA20D11D78
        
        let upiGetAddress = UPIGAddress(customerid: "91" + (Common.shared.phoneNo ?? "") ?? "", vpa: accountDetails?.vpa ?? "", regIdType: "MOBILE", regIdValue: "8076396412", action: "CHECK", subtype: "VPA", note: "PRCM04A", consent: "Y", mobile: Common.shared.phoneNo ?? "",telecom: "Airtel")
        
        print("phone number",Common.shared.phoneNo ?? "")
        
        
        print("upiGetAddress ====",upiGetAddress)
        
        
        
        
        // SDKHandshake.shared.generateRandomDigits(12)
        
        var strUpiGetAddress = ""
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(upiGetAddress)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strUpiGetAddress = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        print(strUpiGetAddress)
        
        // Perform API call in the background
        
        DispatchQueue.main.async {
     
            
            OliveUpiManager.getAddress(address: strUpiGetAddress, callback: { (data, err) in
                if let err = err{
                    
                    if err.code == 102 || err.code == 108 {
                        
                        // Customer Accounts not found
                        DispatchQueue.main.async {
                            self.showErrorAlert(err.localizedDescription)
                        }
                        
                    } else if err.code == 401 || err.code == 107 {
                        
                     //   self.configuration()
                        
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
    

    

}



extension ManageUPIVC: MFMessageComposeViewControllerDelegate {
    
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
           // self.checkvpa(vpa: self.txtUPIID.text!)
            
            

            
            if self.clickView != "" {
                
                self.linkToUpiNumber()
                
            }else{
                
                self.getAddress()
                
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

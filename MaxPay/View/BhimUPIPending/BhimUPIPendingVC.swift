//
//  BhimUPIPendingVC.swift
//  MaxPay
//
//  Created by india on 14/11/23.
//

import UIKit
import OlivePayLibrary
import SwiftLoader
import MessageUI

class BhimUPIPendingVC: BaseVC {
    
    private var checksumViewModel = SIMSelectionViewModel()
    var accountDetails: AccountDetailsOnIIN?
    @IBOutlet weak var btnUPI: UIButton!
    @IBOutlet weak var btnIFSC: UIButton!
    @IBOutlet weak var vwLineIFSC: UIView!
    @IBOutlet weak var vwLineUPI: UIView!
    
    var bolIsUPI = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vwLineIFSC.isHidden = true
        vwLineUPI.isHidden = false
        vwLineIFSC.backgroundColor = UIColor(hexString: "808080")
        vwLineUPI.backgroundColor = UIColor(hexString: "9FC438")
        btnIFSC.setTitleColor(UIColor(hexString: "808080"), for: .normal)
        bolIsUPI = true
        
    }
    
    @IBAction func btnUPIAction(_ sender: Any) {
        
        vwLineIFSC.isHidden = true
        vwLineUPI.isHidden = false
        vwLineUPI.backgroundColor = UIColor(hexString: "9FC438")
        vwLineIFSC.backgroundColor = UIColor(hexString: "808080")
        btnIFSC.setTitleColor(UIColor(hexString: "808080"), for: .normal)
        btnUPI.setTitleColor(UIColor(hexString: "9FC438"), for: .normal)
        bolIsUPI = true
        
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnIFSCAction(_ sender: Any) {
        
        vwLineIFSC.isHidden = false
        vwLineUPI.isHidden = true
        vwLineIFSC.backgroundColor = UIColor(hexString: "9FC438")
        vwLineUPI.backgroundColor = UIColor(hexString: "808080")
        btnIFSC.setTitleColor(UIColor(hexString: "9FC438"), for: .normal)
        btnUPI.setTitleColor(UIColor(hexString: "808080"), for: .normal)
        bolIsUPI = false
        
    }
    
    
//    func getPendingMandates() {
//        
//        DispatchQueue.main.async {
//            SwiftLoader.show(animated: true)
//        }
//        
//        DispatchQueue.global(qos: .background).async {
//            
//            OliveUpiManager.getPendingMandates { data, error in
//                
//                if let err = error {
//                    if err.code == 102 { // VPA not allowed for this customer
//                        DispatchQueue.main.async {
//                            self.showErrorAlert(err.localizedDescription)
//                        }
//                    } else if err.code == 401 || err.code == 107 {
//                        
//                        self.configuration()
//                        return
//                        
//                    }
//                    DispatchQueue.main.async {
//                        SwiftLoader.hide()
//                    }
//                    
//                } else {
//                    
//                    Common.shared.myCards = nil
//                    
//                    DispatchQueue.main.async {
//                        SwiftLoader.hide()
//                        self.showToast(message: "De-Registered Successfully")
//                        for controller in self.navigationController!.viewControllers as Array {
//                            if controller.isKind(of: DashboardVC.self) {
//                                self.navigationController!.popToViewController(controller, animated: true)
//                                break
//                            }
//                        }
//                        
//                    }
//                }
//            }
//        }
//        
//    }
}

extension BhimUPIPendingVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BhimUPITrasactionCompletedListCell", for: indexPath) as! BhimUPITrasactionCompletedListCell
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if bolIsUPI == true {
            
        }else{
            
        }
        
    }
}


extension BhimUPIPendingVC: MFMessageComposeViewControllerDelegate {
    
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
//            self.getPendingMandates()
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
//                    self.getPendingMandates()
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

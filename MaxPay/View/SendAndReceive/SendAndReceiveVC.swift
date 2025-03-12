//
//  SendAndReceiveVC.swift
//  MaxPay
//
//  Created by india on 15/11/23.
//

import UIKit
import MessageUI
import SwiftLoader
import OlivePayLibrary

class SendAndReceiveVC: BaseVC {
    
    var accountDetails: AccountDetailsOnIIN?
    @IBOutlet weak var vwBackSend: UIView!
    @IBOutlet weak var tblReceived: UITableView!
    @IBOutlet weak var vwSendConstantHeight: NSLayoutConstraint!
    @IBOutlet weak var btnUPI: UIButton!
    @IBOutlet weak var btnIFSC: UIButton!
    @IBOutlet weak var lblUPIAndIFSC: UILabel!
    @IBOutlet weak var vwLineIFSC: UIView!
    @IBOutlet weak var vwLineUPI: UIView!
    @IBOutlet weak var lblNoDataAvailable: UILabel!
    
    var beneficiaryList: [BeneficiaryListModel] = []
    
    open var notificationList: [PendingNotificationsListModel] = []
    
    private var checksumViewModel = SIMSelectionViewModel()
    var filteredData: [String]!
    var reqIsSend = true
    var bolIsPay = true
    var apiOption = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vwLineIFSC.isHidden = true
        vwLineUPI.isHidden = false
        vwLineIFSC.backgroundColor = UIColor(hexString: "808080")
        vwLineUPI.backgroundColor = UIColor(hexString: "9FC438")
        btnIFSC.setTitleColor(UIColor(hexString: "808080"), for: .normal)
        reqIsSend = true
        
        listBeneficary()
        
    }
    
    @IBAction func btnSendAction(_ sender: Any) {
        vwSendConstantHeight.constant = 50
        vwBackSend.isHidden = false
        lblUPIAndIFSC.text = "Send"
        vwLineIFSC.isHidden = true
        vwLineUPI.isHidden = false
        vwLineUPI.backgroundColor = UIColor(hexString: "9FC438")
        vwLineIFSC.backgroundColor = UIColor(hexString: "808080")
        btnIFSC.setTitleColor(UIColor(hexString: "808080"), for: .normal)
        btnUPI.setTitleColor(UIColor(hexString: "9FC438"), for: .normal)
        reqIsSend = true
        bolIsPay = true
        tblReceived.reloadData()
        
        // api call
        listBeneficary()
    }
    
    @IBAction func btnReceiveAction(_ sender: Any) {
        vwBackSend.isHidden = true
        vwSendConstantHeight.constant = 0
        vwLineIFSC.isHidden = false
        vwLineUPI.isHidden = true
        vwLineIFSC.backgroundColor = UIColor(hexString: "9FC438")
        vwLineUPI.backgroundColor = UIColor(hexString: "808080")
        btnIFSC.setTitleColor(UIColor(hexString: "9FC438"), for: .normal)
        btnUPI.setTitleColor(UIColor(hexString: "808080"), for: .normal)
        reqIsSend = false
        bolIsPay = false
        tblReceived.reloadData()
        
        // api call
        pendingNotifications()
    }
    
    @IBAction func btnSendAndReceivedAction(_ sender: Any) {
        if reqIsSend == true {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "UPIVerifyVC") as! UPIVerifyVC
            vc.accountDetails = accountDetails
            vc.isFromRequestScreen = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func listBeneficary() {
        
        apiOption = "beneList"
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        DispatchQueue.global(qos: .background).async {
            
            OliveUpiManager.listvpa { data, error in
                    
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
                    
                    
                    self.beneficiaryList.removeAll()
                    
                    if let dt = data {
                        
                        if let data = SelectBankVC.convertToData(dt) {
                            do {
                                let beneficiaryList = try JSONDecoder().decode([BeneficiaryListModel].self, from: data)
                                for beneficiary in beneficiaryList {
                                    self.beneficiaryList.append(beneficiary)
                                }
                            } catch {
                                print(error.localizedDescription)
                            }
                            
                            DispatchQueue.main.async {
                                self.tblReceived.reloadData()
                                self.lblNoDataAvailable.isHidden = self.beneficiaryList.count != 0
                                SwiftLoader.hide()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func pendingNotifications() {
        
        apiOption = "notiList"
        
        DispatchQueue.main.async {
            
            SwiftLoader.show(animated: true)
            
        }
        
        DispatchQueue.global(qos: .background).async {
            
            OliveUpiManager.pendingNotifications(callback: { data, error in
                
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
                    
                    self.notificationList.removeAll()
                    
                    if let dt = data {
                        
                        if let data = SelectBankVC.convertToData(dt) {
                            do {
                                let beneficiaryList = try JSONDecoder().decode([PendingNotificationsListModel].self, from: data)
                                for beneficiary in beneficiaryList {
                                    self.notificationList.append(beneficiary)
                                }
                            } catch {
                                print(error.localizedDescription)
                            }
                            
                            DispatchQueue.main.async {
                                self.tblReceived.reloadData()
                                self.lblNoDataAvailable.isHidden = self.notificationList.count != 0
                                SwiftLoader.hide()
                            }
                        }
                    }
                }
            })
            
            
        }
    }
}

extension SendAndReceiveVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if bolIsPay {
            return beneficiaryList.count
        }
        return notificationList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if bolIsPay {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SendCell", for: indexPath) as! SendCell
            cell.isUserInteractionEnabled = true
            
            cell.setSentData(object: beneficiaryList[indexPath.row])
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReceivedCell", for: indexPath) as! ReceivedCell
        cell.isUserInteractionEnabled = true
        
        cell.setReceivedData(object: notificationList[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if reqIsSend == true {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "PaymentUPIIDRequestVC") as! PaymentUPIIDRequestVC //PaymentUPIIDVC
            vc.beneVpa = beneficiaryList[indexPath.row].vpa ?? ""
            vc.beneName = beneficiaryList[indexPath.row].name ?? ""
            vc.accountDetails = accountDetails
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let storyBoard: UIStoryboard = UIStoryboard(name: "BhimUpi", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "UPIPaymentReject") as! UPIPaymentReject
            vc.notificationObj = notificationList[indexPath.row]
            vc.accountDetails = accountDetails
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if bolIsPay {
            return 60
        }else{
            return 100
        }
        
    }

}

extension SendAndReceiveVC: MFMessageComposeViewControllerDelegate {
    
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
                if self?.checksumViewModel.checksumModel?.data?.result?.lowercased() == "success" {
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
            if self.apiOption == "beneList" {
                self.listBeneficary()
            } else if self.apiOption == "notiList" {
                self.pendingNotifications()
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
                    if self.apiOption == "beneList" {
                        self.listBeneficary()
                    } else if self.apiOption == "notiList" {
                        self.pendingNotifications()
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

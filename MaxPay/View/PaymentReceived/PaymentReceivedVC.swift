//
//  PaymentReceivedVC.swift
//  MaxPay
//
//  Created by india on 13/11/23.
//

import UIKit
import MessageUI
import SwiftLoader
import OlivePayLibrary

class PaymentReceivedVC: BaseVC {
    
    var accountDetails: AccountDetailsOnIIN?
    @IBOutlet weak var btnUPI: UIButton!
    @IBOutlet weak var btnIFSC: UIButton!
    @IBOutlet weak var lblUPIAndIFSC: UILabel!
    @IBOutlet weak var vwLineIFSC: UIView!
    @IBOutlet weak var vwLineUPI: UIView!
    @IBOutlet weak var tableViewPay: UITableView!
    @IBOutlet weak var lblNoDataAvailable: UILabel!

    private var checksumViewModel = SIMSelectionViewModel()
    private var beneficiaryList: [BeneficiaryListModel] = []
    var bolIsUPI = true
    var apiOption = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vwLineIFSC.isHidden = true
        vwLineUPI.isHidden = false
        vwLineIFSC.backgroundColor = UIColor(hexString: "808080")
        vwLineUPI.backgroundColor = UIColor(hexString: "9FC438")
        btnIFSC.setTitleColor(UIColor(hexString: "808080"), for: .normal)
        bolIsUPI = true
        
        listBeneficary()
    }
    
    @IBAction func btnUPIAction(_ sender: Any) {
        lblUPIAndIFSC.text = "New UPI Id"
        vwLineIFSC.isHidden = true
        vwLineUPI.isHidden = false
        vwLineUPI.backgroundColor = UIColor(hexString: "9FC438")
        vwLineIFSC.backgroundColor = UIColor(hexString: "808080")
        btnIFSC.setTitleColor(UIColor(hexString: "808080"), for: .normal)
        btnUPI.setTitleColor(UIColor(hexString: "9FC438"), for: .normal)
        bolIsUPI = true
    }
    
    @IBAction func btnIFSCAction(_ sender: Any) {
        lblUPIAndIFSC.text = "New IFSC"
        vwLineIFSC.isHidden = false
        vwLineUPI.isHidden = true
        vwLineIFSC.backgroundColor = UIColor(hexString: "9FC438")
        vwLineUPI.backgroundColor = UIColor(hexString: "808080")
        btnIFSC.setTitleColor(UIColor(hexString: "9FC438"), for: .normal)
        btnUPI.setTitleColor(UIColor(hexString: "808080"), for: .normal)
        bolIsUPI = false
    }
    
    @IBAction func btnAddUPIAndIFSCAction(_ sender: Any) {
        
        if bolIsUPI == true {
            
            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "UPIVerifyVC") as! UPIVerifyVC
            vc.accountDetails = accountDetails
//            vc.isPayOrRequest = PAY
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else{
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "PaymentIFSCCode") as! PaymentIFSCCode
            vc.accountDetails = accountDetails
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
                                self.tableViewPay.reloadData()
                                self.lblNoDataAvailable.isHidden = self.beneficiaryList.count != 0
                                SwiftLoader.hide()
                            }
                        }
                    }
                }
            }
        }
    }
}

extension PaymentReceivedVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beneficiaryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UPIAndIFSCCell", for: indexPath) as! UPIAndIFSCCell
        cell.selectionStyle = .none
        
        cell.setSentData(object: beneficiaryList[indexPath.row])

        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if bolIsUPI == true {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "PaymentUPIIDVC") as! PaymentUPIIDVC
            vc.beneVpa = beneficiaryList[indexPath.row].vpa ?? ""
            vc.beneName = beneficiaryList[indexPath.row].name ?? ""
            vc.accountDetails = accountDetails
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
//            let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
//            let vc = storyBoard.instantiateViewController(withIdentifier: "PaymentIFSCCode") as! PaymentIFSCCode
//            vc.accountDetails = accountDetails
//            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
 

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

extension PaymentReceivedVC: MFMessageComposeViewControllerDelegate {
    
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
            if self.apiOption == "beneList" {
                self.listBeneficary()
            } else if self.apiOption == "rm" {
                
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
                    } else if self.apiOption == "rm" {
                        
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

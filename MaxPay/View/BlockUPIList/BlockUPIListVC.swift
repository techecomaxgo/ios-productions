//
//  BlockUPIListVC.swift
//  MaxPay
//
//  Created by india on 15/11/23.
//

import UIKit
import OlivePayLibrary
import SwiftLoader
import MessageUI

class BlockUPIListVC: BaseVC {

    @IBOutlet weak var tableBlockList: UITableView!
    @IBOutlet weak var lblNoData: UILabel!
    
    var accountDetails: AccountDetailsOnIIN?
    private var checksumViewModel = SIMSelectionViewModel()
    var apiOption = ""
    var deleteVpaButton = UIButton()
    var isFromBlockAlert = false

    var blockList = [BlockListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectBlocklist()
    }
    @IBAction func btnBackAction(_ sender: Any) {
        if isFromBlockAlert{
            if let tabBarController = self.navigationController?.tabBarController {
                tabBarController.selectedIndex = 0 // Set the first tab as selected
                tabBarController.navigationController?.popToRootViewController(animated: true)
            }else{
                self.navigationController?.popViewController(animated: true)
            }
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }

    
    func collectBlocklist() {
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        apiOption = "list"
        
        DispatchQueue.global(qos: .background).async {
            
             // get block list
            OliveUpiManager.collectBlocklist { data, error in
                
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
                    
                    
                    self.blockList.removeAll()
                    
                    if let dt = data {
                        
                        if let data = SelectBankVC.convertToData(dt) {
                            do {
                                let beneficiaryList = try JSONDecoder().decode([BlockListModel].self, from: data)
                                for beneficiary in beneficiaryList {
                                    self.blockList.append(beneficiary)
                                }
                            } catch {
                                print(error.localizedDescription)
                            }
                            
                            DispatchQueue.main.async {
                                self.tableBlockList.reloadData()
                                self.lblNoData.isHidden = self.blockList.count != 0
                                SwiftLoader.hide()
                            }
                        }
                    }
                }
            }
        }
        
    }
}

extension BlockUPIListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blockList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlockUPIListCell", for: indexPath) as! BlockUPIListCell
        
        cell.setData(object: blockList[indexPath.row])
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(deleteVpa(_:)), for: .touchUpInside)
        
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    @objc func deleteVpa(_ sender: UIButton) {
        
        deleteVpaButton = sender
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        apiOption = "unblock"
        
        DispatchQueue.global(qos: .background).async {
            
            OliveUpiManager.collectBlockUnblock(vpa: self.blockList[self.deleteVpaButton.tag].vpa ?? "", block: "U", reason: "fraud") { data, error in
                
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

                    self.blockList.remove(at: self.deleteVpaButton.tag)
                    
                    DispatchQueue.main.async {
                        self.tableBlockList.reloadData()
                        self.lblNoData.isHidden = self.blockList.count != 0
                        SwiftLoader.hide()
                    }
                }
            }
        }
    }
                                 
                                 
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vw = BlockalertView()
//        vw.frame = UIScreen.main.bounds
//        vw.setupUI("")
//        vw.delegate = self
//        view.addSubview(vw)
//    }

}

extension BlockUPIListVC: BlockalertViewDelegate {
    func btnBlock() {
        
    }
    func btnRejected() {
        
    }
}

extension BlockUPIListVC: MFMessageComposeViewControllerDelegate {
    
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
            if self.apiOption == "list" {
                self.collectBlocklist()
            } else if self.apiOption == "unblock" {
                self.deleteVpa(self.deleteVpaButton)
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
                    DispatchQueue.main.async {
                        self.showToast(message: "SMS Sent failed", font: .systemFont(ofSize: 12))
                        SwiftLoader.hide()
                    }
                } else {
                    if self.apiOption == "list" {
                        self.collectBlocklist()
                    } else if self.apiOption == "unblock" {
                        self.deleteVpa(self.deleteVpaButton)
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

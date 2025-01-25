//
//  BeneficiaryListVC.swift
//  MaxPay
//
//  Created by india on 15/11/23.
//

import UIKit
import OlivePayLibrary
import SwiftLoader
import MessageUI

class BeneficiaryListCell: UITableViewCell {

    @IBOutlet weak var btnRemoveBene: UIButton!
    @IBOutlet weak var lblBeneName: UILabel!
    @IBOutlet weak var lblBeneVpa: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class BeneficiaryListVC: BaseVC {

    open var beneficiaryList: [BeneficiaryListModel] = []
    var accountDetails: AccountDetailsOnIIN?
    private var checksumViewModel = SIMSelectionViewModel()
    var apiOption = ""
    var vpaToDelete = ""
    @IBOutlet weak var tableViewBeneficiary: UITableView!
    @IBOutlet weak var lblNoData: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listBeneficary()
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func listBeneficary() {
        
        apiOption = "list"
        
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
                                self.tableViewBeneficiary.reloadData()
                                self.lblNoData.isHidden = self.beneficiaryList.count != 0
                                SwiftLoader.hide()
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    func remopveBeneficary(vpa: String) {
        
        apiOption = "rm"
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        DispatchQueue.global(qos: .background).async {
            
            OliveUpiManager.removeVpa(vpa: vpa) { data, error in
            
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

                } else {
                    print(data)
                        
                    // add to arr and reload table
                    
                    self.listBeneficary()
                    
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        self.showToast(message: "Beneficary Removed Successfully")
                        self.lblNoData.isHidden = self.beneficiaryList.count != 0
                    }
                }
            }
            
        }
    }
}

extension BeneficiaryListVC: UITableViewDelegate, UITableViewDataSource  {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beneficiaryList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeneficiaryListCell", for: indexPath) as! BeneficiaryListCell
        
        cell.lblBeneName.text = beneficiaryList[indexPath.row].name
        cell.lblBeneVpa.text = beneficiaryList[indexPath.row].vpa
        
        cell.btnRemoveBene.tag = indexPath.row
        cell.btnRemoveBene.addTarget(self, action: #selector(removeBene(_:)), for: .touchUpInside)
        cell.selectionStyle = .none
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    @objc func removeBene(_ sender: UIButton) {
        // indexpath of arr
        
        showAlertMessageWithActionButton(title: "MaxUPI", message: "Are you sure you want to remove Beneficiary?", actionButtonText: "Ok", cancelActionButtonText: "Cancel", vc: self) { status in
            if status == 1 {
                
                self.vpaToDelete = self.beneficiaryList[sender.tag].vpa ?? ""
                self.remopveBeneficary(vpa: self.vpaToDelete)
                
            }
        }
        
        
    }
    
}

extension BeneficiaryListVC: MFMessageComposeViewControllerDelegate {
    
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
        
        OliveUpiManager.initiateSDK(sdkHandshake: jsonString,view: self , delegate: self) { (data, err) in
            print("The data is:\(String(describing: data))")
            if self.apiOption == "list" {
                self.listBeneficary()
            } else if self.apiOption == "rm" {
                self.remopveBeneficary(vpa: self.vpaToDelete)
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
                    if self.apiOption == "list" {
                        self.listBeneficary()
                    } else if self.apiOption == "rm" {
                        self.remopveBeneficary(vpa: self.vpaToDelete)
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

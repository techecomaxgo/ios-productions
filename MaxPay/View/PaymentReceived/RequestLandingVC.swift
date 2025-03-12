//
//  RequestLandingVC.swift
//  MaxPay
//
//  Created by Ios Developer on 23/02/24.
//

import UIKit
import MessageUI
import SwiftLoader
import OlivePayLibrary


class RequestLandingCell: UITableViewCell {
    

    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblVpa: UILabel!
    @IBOutlet weak var lblValidDate: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    @IBOutlet weak var btnDecline: UIButton!
    @IBOutlet weak var btnApprove: UIButton!
    @IBOutlet weak var btnMenu: UIButton!
    
    @IBOutlet weak var imgContact: UIImageView!
    

    
    public func setReceivedData(object: PendingNotificationsListModel) {
        lblName.text = object.beneName
        lblVpa.text = object.payeeVpa
        lblValidDate.text = "Valid up to \(object.expdate?.prefix(11) ?? "")"
        lblAmount.text = "₹\(object.amount ?? "0")"
        
//        if let imageData = object.thumbnailImageData {
//            imgContact.image = UIImage(data: imageData)
//        } else {
//            // Set a placeholder image if no contact image is available
//            imgContact.image = UIImage(named: "me_profile")
//        }

    }

}

class RequestLandingVC: BaseVC {
    
    var pullControl = UIRefreshControl()

    var alertAct : UIAlertController?

    @IBOutlet weak var tblReceived: UITableView!
    @IBOutlet weak var lblNoDataAvailable: UILabel!

    var accountDetails: AccountDetailsOnIIN?
    
    open var notificationList: [PendingNotificationsListModel] = []
    
    private var checksumViewModel = SIMSelectionViewModel()
    private var cardsArr:[AccountDetailsOnIIN] = []
    var apiOption = ""
    var selectedRequestIndex = -1
    
    var isComefromNotifiction = ""
    var refidSt = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(accountDetails)
        
        print(isComefromNotifiction)
        print(refidSt)
       // print(notificationList)
        
      //  print(accountDetails?.accRefNumber)
        
        // Fetch card array from user defaults
        if let decoded = Common.shared.myCards {
            
            do {
                let cardList: [AccountDetailsOnIIN] = try JSONDecoder().decode([AccountDetailsOnIIN].self, from: decoded)
                for card in cardList {
                    cardsArr.append(card)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        
//        
//         alertAct = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//        
//        for card in cardsArr {
//            alertAct?.addAction(UIAlertAction(title: (card.bankName ?? "") + " - " + (card.maskedAccnumber ?? ""), style: .default, handler: { (action) in
//                
//                
//                
//            }))
//        }
//                
//        alertAct?.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(_: UIAlertAction!) in
//        }))
//        
//        self.present(alertAct!, animated: true, completion: nil)
        
        
        
      
      //  pullControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
      //  pullControl.addTarget(self, action: #selector(pulledRefreshControl(_:)), for: UIControl.Event.valueChanged)
      //  tblReceived.addSubview(pullControl) // not required when using UITableViewController

        
        

    }
    
    
    
    
 
    @objc func pulledRefreshControl(sender:AnyObject) {
       // Code to refresh table view
    }
    
    override func viewWillAppear(_ animated: Bool) {
      
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true

        pendingNotifications()
        
        
        getCollectBlockList()
    }
    
    
    @IBAction func btnBlockListClicked(_ sender: UIButton) {
        
        //BlockUPIListVC
        
        let vc = UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "BlockUPIListVC") as! BlockUPIListVC
       // vc.accountDetails = accountDetails
        self.navigationController?.pushViewController(vc, animated: true)

        
        
        
    }
    
    
    func getCollectBlockList() {
        
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        DispatchQueue.global(qos: .background).async {
            
            
            OliveUpiManager.collectBlocklist(callback:{ data, error in
                
                
               // print(data)
                
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
                    
                    self.notificationList = []
                    
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
//                                
//                                print(self.notificationList)
//                            
//                                
//                                let refidToMatch = 415853435601
                                
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
    
    func pendingNotifications() {
        
        apiOption = "noti"
        
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
                    
                    self.notificationList = []
                    
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
                        
                        
                        
                        if self.isComefromNotifiction == "Yes" {
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {

                            
                            self.isComefromNotifiction = ""
                            
                            if let filteredTransaction = self.filterTransaction(by: self.refidSt, from: self.notificationList) {
                                
                                print("Filtered Transaction: \(filteredTransaction)")
                                
                                
                                //self.alertAct?.dismiss(animated: true, completion: nil)
                                
                                
                                DispatchQueue.main.async {
                                    
                                    // SHow popup like tag for mandate detail screen
                                    let storyBoard: UIStoryboard = UIStoryboard(name: "BhimUpi", bundle: nil)
                                    let vc = storyBoard.instantiateViewController(withIdentifier: "UPIPaymentReject") as! UPIPaymentReject
                                    vc.notificationObj = filteredTransaction
                                    
                                    vc.accountDetails = self.accountDetails
                                    self.navigationController?.pushViewController(vc, animated: true)
                                    
                                }
                                
                            } else {
                                print("No transaction found with refid \(self.refidSt)")
                            }
                            
                            
                        })
                    }
                        
                        
                        
                    }
                }
            })
            
        }
    }
    
    
    func filterTransaction(by refid: String, from transactions: [PendingNotificationsListModel]) -> PendingNotificationsListModel? {
        return transactions.first { $0.refid == refid }
    }


    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }

    @IBAction func btnCreateRequestAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "BhimUpi", bundle: nil).instantiateViewController(withIdentifier: "RequestMoneyVC") as! RequestMoneyVC
        vc.accountDetails = accountDetails
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension RequestLandingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestLandingCell") as! RequestLandingCell
        cell.selectionStyle = .none
                
        if notificationList.count > 0 {
            cell.setReceivedData(object: notificationList[indexPath.row])
        }
        
        cell.btnDecline.tag = indexPath.row
        cell.btnDecline.addTarget(self, action: #selector(btnDeclineAction(_:)), for: .touchUpInside)
        
        cell.btnApprove.tag = indexPath.row
        cell.btnApprove.addTarget(self, action: #selector(btnApproveAction(_:)), for: .touchUpInside)
        
        cell.btnMenu.tag = indexPath.row
        cell.btnMenu.addTarget(self, action: #selector(btnMenuAction(_:)), for: .touchUpInside)
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // SHow popup like tag for mandate detail screen
        let storyBoard: UIStoryboard = UIStoryboard(name: "BhimUpi", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "UPIPaymentReject") as! UPIPaymentReject
        vc.notificationObj = notificationList[indexPath.row]
        vc.accountDetails = accountDetails
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnDeclineAction(_ sender:UIButton) {
        selectedRequestIndex = sender.tag
        oliveRejectApiCall(selectedRequestIndex)
    }
    
    @objc func btnApproveAction(_ sender:UIButton) {
        
        selectedRequestIndex = sender.tag
        
        showAlertMessageWithActionButtonAndCancelButton(title: "Be Alert | सावधान रहें", message: "\nIs this transaction a fraud? \n\nक्या यह लेनदेन धोखाधड़ी है?", actionButtonText: "No", cancelActionButtonText: "Yes", vc: self) { status in
            if status == 1 {
                self.oliveBlockApiCall()
            }else if status == 0 {
                self.oliveApproveApiCall(self.selectedRequestIndex)
            }
        }
        
    }
    
    @objc func btnMenuAction(_ sender:UIButton) {
        
        selectedRequestIndex = sender.tag
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Spam or Block", style: .default, handler: { (action) in
            let vw = BlockalertView()
            vw.frame = UIScreen.main.bounds
            vw.setupUI("")
            vw.delegate = self
            self.view.addSubview(vw)
        }))
                
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(_: UIAlertAction!) in
        }))
        
        self.present(alert, animated: true, completion: nil)

    }
    
    func oliveRejectApiCall(_ selectedRequestIndex: Int) {
        
        var strCollectBene = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(notificationList[selectedRequestIndex])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strCollectBene = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        apiOption = "reject"
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        DispatchQueue.global(qos: .background).async {
            
            OliveUpiManager.collectReject(pendingReqVo: strCollectBene) { data, error in
                
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
                    
                  //  print(data!)
                    
                    DispatchQueue.main.async {
                        
                        self.showErrorAlert("Request Declined Successfully")
                        SwiftLoader.hide()
                        self.pendingNotifications()
                    }
                    
                }
            }
        }
    }
    
    func oliveApproveApiCall(_ selectedRequestIndex: Int) {
        // done
        var strAccount = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(accountDetails)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strAccount = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        var strCollectBene = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(notificationList[selectedRequestIndex])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strCollectBene = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }

        
        apiOption = "approve"
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        DispatchQueue.global(qos: .background).async {
            
            OliveUpiManager.collectApprove(account: strAccount, PendingReq: strCollectBene, viewController: self) { data, error in
                    
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
                    
                    if let dt = data {
                        
                        DispatchQueue.main.async {
                            SwiftLoader.hide()
                            
                            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "PaymentSuccessfulVC") as! PaymentSuccessfulVC
                            
                            vc.accountDetails = self.accountDetails
                            vc.beneVpa = self.notificationList[selectedRequestIndex].payeeVpa ?? ""
                            vc.beneName = self.notificationList[selectedRequestIndex].beneName ?? ""
                            vc.transId = self.notificationList[selectedRequestIndex].txnid ?? ""
                            vc.amount = self.notificationList[selectedRequestIndex].amount ?? ""
                            vc.refNo = dt as! String
                            vc.fromScreenOption = "req"
                            
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                    
                }
            }
        }

    }
}

extension RequestLandingVC: BlockalertViewDelegate {
    
    // Block Popup handel
    
    func btnBlock() {
        oliveBlockApiCall()
    }
    func btnRejected() {
        oliveBlockApiCall()
        oliveRejectApiCall()
    }
    
    func oliveBlockApiCall() {
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        apiOption = "block"
        
        DispatchQueue.global(qos: .background).async {
            
            OliveUpiManager.collectBlockUnblock(vpa: self.notificationList[self.selectedRequestIndex].payeeVpa ?? "", block: "B", reason: "fraud") { data, error in
                
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

                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    func oliveRejectApiCall() {
        
        var strCollectBene = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(self.notificationList[self.selectedRequestIndex])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strCollectBene = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        apiOption = "reject"
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        DispatchQueue.global(qos: .background).async {
            
            OliveUpiManager.collectReject(pendingReqVo: strCollectBene) { data, error in
                
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
                    
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                    }
                    
                    
                }
            }
        }
    }
}

extension RequestLandingVC: MFMessageComposeViewControllerDelegate {
    
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
                if self?.checksumViewModel.checksumModel?.data?.result!.lowercased() == "success" {
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
            if self.apiOption == "noti" {
                self.pendingNotifications()
            } else if self.apiOption == "reject" {
                self.oliveRejectApiCall(self.selectedRequestIndex)
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
                    if self.apiOption == "noti" {
                        self.pendingNotifications()
                    } else if self.apiOption == "reject" {
                        self.oliveRejectApiCall(self.selectedRequestIndex)
                    }
                }
            })
            break
        default:
            break
        }
    }
    
}

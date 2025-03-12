//
//  MandateListVC.swift
//  MaxPay
//
//  Created by india on 14/11/23.
//

import UIKit
import OlivePayLibrary
import SwiftLoader
import MessageUI

class MandateListCell: UITableViewCell {

    @IBOutlet weak var vwBack: UIView!
    
    @IBOutlet weak var lblMndateRequestFrom: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblVpa: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblOneTime: UILabel!
    @IBOutlet weak var stackButtons: UIStackView!
    
    @IBOutlet weak var btnDecline: UIButton!
    @IBOutlet weak var btnProceed: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vwBack.layer.applyCornerRadiusShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setMandateData(object: MandateListModel) {
        
        lblMndateRequestFrom.text = object.beneName
        lblAmount.text = "₹ " + (object.amount ?? "0")
        lblVpa.text = object.payeeVpa
        lblDate.text = object.createdate
        lblOneTime.text = object.recurrencePattern
        
    }
    
    func setTransactionData(object: MandateTransactionModel) {
        
        lblMndateRequestFrom.text = object.payername
        lblAmount.text = "₹ " + (object.amount ?? "0")
        lblVpa.text = object.payeeVpa
        lblDate.text = object.createdDate
        lblOneTime.text = object.recurrencePattern
        
    }
    
}

class MandateListVC: BaseVC {
    
    private var checksumViewModel = SIMSelectionViewModel()
    var accountDetails: AccountDetailsOnIIN?

    @IBOutlet weak var btnLive: UIButton!
    @IBOutlet weak var btnPending: UIButton!
    @IBOutlet weak var btnCompleted: UIButton!

    @IBOutlet weak var vwLineLive: UIView!
    @IBOutlet weak var vwLinePending: UIView!
    @IBOutlet weak var vwLineCompleted: UIView!
    @IBOutlet weak var tableViewMandate: UITableView!
    @IBOutlet weak var lblNoDataAvailable: UILabel!

    var mandateListArr: [MandateListModel] = []
    var mandateTransactionArr: [MandateTransactionModel] = []

    var selectedTab = 0
    var apiCall = ""
    var timer: Timer?
    @IBOutlet weak var viewTabs: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
      //  print(accountDetails)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyy"
        let yourDate = dateFormatter.date(from: "25032024")

        // change to local time zone from your format
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.timeZone = TimeZone.current
        let DateString = dateFormatter.string(from: yourDate!)
        print(DateString)
        

    
        viewTabs.layer.applyCornerRadiusShadow()
        
        

        
        startTimer()

    }
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy"
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            return outputFormatter.string(from: date)
        }
        return nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Invalidate the timer when the view disappears
        invalidateTimer()
    }
    
    func startTimer() {
        // Schedule the timer to call the method every 30 seconds
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    func invalidateTimer() {
        // Invalidate the timer
        timer?.invalidate()
        timer = nil
    }
    
    @objc func timerAction() {
        // Method to be called every 10 seconds
        if selectedTab == 1 {
            btnTabAction(btnPending)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //print(selectedTab)
        
        btnTabAction(btnPending)
        
    }
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTabAction(_ sender: UIButton) {
        
        selectedTab = sender.tag
        
        //print(selectedTab)
        
        setDefautTabs(btnLive, lineView: vwLineLive)
        setDefautTabs(btnPending, lineView: vwLinePending)
        setDefautTabs(btnCompleted, lineView: vwLineCompleted)
        
        setDefautTabs(sender, lineView: selectedTab == 0 ? vwLineLive : selectedTab == 1 ? vwLinePending : vwLineCompleted, isSelected: true)
        
        if sender.tag == 1 {
            
            
            getPendingMandates()
        } else if sender.tag == 2{
            
            
            getCompletedTransactions()
            
        }
        else {
            
           // print(selectedTab)
            getMandateTransactions()
        }
        
    }

    func setDefautTabs(_ sender: UIButton, lineView: UIView, isSelected: Bool = false) {
        
        lineView.isHidden = !isSelected
        lineView.backgroundColor = isSelected ? UIColor(hexString: "9FC438") : UIColor(hexString: "808080")
        sender.setTitleColor(isSelected ? UIColor(hexString: "9FC438") : UIColor(hexString: "808080"), for: .normal)
        sender.backgroundColor = .clear
    }
    
    func getPendingMandates() {
        
        apiCall = "PendingMandates"
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        DispatchQueue.global(qos: .background).async {
            
            OliveUpiManager.getPendingMandates { data, error in
//                 Data  for this
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
                    
                    self.mandateListArr.removeAll()
                    
                    if let dt = data {
                        
                        if let data = SelectBankVC.convertToData(dt) {
                            do {
                                let beneficiaryList = try JSONDecoder().decode([MandateListModel].self, from: data)
                                for beneficiary in beneficiaryList {
                                    self.mandateListArr.append(beneficiary)
                                }
                            } catch {
                                print(error.localizedDescription)
                            }
                            
                            DispatchQueue.main.async {
                                self.tableViewMandate.reloadData()
                                self.lblNoDataAvailable.isHidden = self.mandateListArr.count != 0
                                SwiftLoader.hide()
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    func getCompletedTransactions() {
        
        apiCall = "MandateTransactions"
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        DispatchQueue.global(qos: .background).async {
            
            OliveUpiManager.getMandateTransactions { data, error in  // Live & Completed same api on condition
                
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
                    
                    self.mandateTransactionArr.removeAll()
                    
                    if let dt = data {
                        
                        if let data = SelectBankVC.convertToData(dt) {
                            do {
                                let beneficiaryList = try JSONDecoder().decode([MandateTransactionModel].self, from: data)
                                for beneficiary in beneficiaryList {
                                    
                                    //self.mandateTransactionArr.append(beneficiary)

                                    
                                
                                    if self.selectedTab == 2 {
                                        
                                        if beneficiary.payerStatus == "C" {
                                            self.mandateTransactionArr.append(beneficiary)
                                        }else if beneficiary.payerStatus == "R" {
                                            self.mandateTransactionArr.append(beneficiary)
                                            
                                        }else if beneficiary.payerStatus == "F" {
                                            self.mandateTransactionArr.append(beneficiary)
                                            
                                        }else if beneficiary.payerStatus == "E" {
                                            self.mandateTransactionArr.append(beneficiary)
                                            
                                        }
                                        
                                        
                                        
                                    } else {
                                        self.mandateTransactionArr.append(beneficiary)
                                    }
                                    
                                    
                                }
                            } catch {
                                print(error.localizedDescription)
                            }
                            
                            DispatchQueue.main.async {
                                self.tableViewMandate.reloadData()
                                self.lblNoDataAvailable.isHidden = self.mandateTransactionArr.count != 0
                                SwiftLoader.hide()
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    func getMandateTransactions() {
        
        apiCall = "MandateTransactions"
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        DispatchQueue.global(qos: .background).async {
            
            OliveUpiManager.getMandateTransactions { data, error in  // Live & Completed same api on condition
                
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
                    
                    self.mandateTransactionArr.removeAll()
                    
                    if let dt = data {
                        
                        if let data = SelectBankVC.convertToData(dt) {
                            do {
                                let beneficiaryList = try JSONDecoder().decode([MandateTransactionModel].self, from: data)
                                for beneficiary in beneficiaryList {
                                    if self.selectedTab == 2 {
                                        if beneficiary.payerStatus == "C" {
                                            self.mandateTransactionArr.append(beneficiary)
                                        }
                                    } else {
                                        
                                        if beneficiary.payerStatus == "S" {
                                            self.mandateTransactionArr.append(beneficiary)
                                        }else if beneficiary.payerStatus == "U" {
                                            
                                            self.mandateTransactionArr.append(beneficiary)
                                            
                                        }
//                                        else if beneficiary.payerStatus == "F" {
//                                            self.mandateTransactionArr.append(beneficiary)
//
//                                        }else if beneficiary.payerStatus == "E" {
//                                            self.mandateTransactionArr.append(beneficiary)
//
//                                        }
                                        
                                    }
                                }
                            } catch {
                                print(error.localizedDescription)
                            }
                            
                            DispatchQueue.main.async {
                                self.tableViewMandate.reloadData()
                                self.lblNoDataAvailable.isHidden = self.mandateTransactionArr.count != 0
                                SwiftLoader.hide()
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    
    
    func declineMandates(object: MandateListModel) {
        
        apiCall = "decloineMandates"
        
        let accountDetails = AccountPay(name: accountDetails?.name ?? "", mmid: accountDetails?.mmid ?? "", aeba: accountDetails?.aeba ?? "", mbeba: accountDetails?.mbeba ?? "", accRefNumber: accountDetails?.accRefNumber ?? "", ifsc: accountDetails?.ifsc ?? "", maskedAccnumber: accountDetails?.maskedAccnumber ?? "", status: accountDetails?.status ?? "", type: accountDetails?.type ?? "", vpa: accountDetails?.vpa ?? "", dLength: accountDetails?.dLength ?? "", dType: accountDetails?.dType ?? "", balance: accountDetails?.balance ?? "", balTime: accountDetails?.balTime ?? "", accountIfsc: accountDetails?.ifsc ?? "",iin: accountDetails?.iin ?? "")
        
        var strAccountDetails = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(accountDetails)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strAccountDetails = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }

        
        
        let x = Double(object.amount ?? "0")
        let amtDecimal = String(format: "%.2f", Double(round(100 * x!) / 100))
        
        
        let mandateInput = MandateInput(amount: amtDecimal, remark: "UPI", txnid: object.txnid ?? "", umn: object.umn ?? "", action: MANDATE_DECLINE)
        
                
        var strMandateInput = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(mandateInput)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strMandateInput = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        DispatchQueue.global(qos: .background).async {
            
            
            OliveUpiManager.declineMandate(account: strAccountDetails, mandateInput: strMandateInput, viewController: self) { data, error in
                    
                if let err = error {
                    if err.code == 102 || err.code == 108 { // 102 VPA not allowed for this customer, 108 Location has No access
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
                    
//                    self.mandateListArr.removeAll()
                    
                    if let dt = data {
                        
                        
                        DispatchQueue.main.async {
                            
                            self.showToast(message: data.debugDescription , font: .systemFont(ofSize: 12))
                            SwiftLoader.hide()
                            
                        }

                        
//                    
                    }
                }
            }
        }
        
    }
}

extension MandateListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if selectedTab == 1 {
    
            return 200

            }else{
                return 175
            }

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedTab == 1 {
            return mandateListArr.count
        }else if selectedTab == 2{
            
            return mandateTransactionArr.count
        }else{
            
            return mandateTransactionArr.count

        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MandateListTVC", for: indexPath) as! MandateListTVC
        cell.selectionStyle = .none
        
        if selectedTab == 1 {
            
            cell.setMandateData(object: mandateListArr[indexPath.row])
            
            //cell.lblstatusDate.isHidden = true
            //cell.imgMandate.isHidden = true
            cell.viewStatusLine.isHidden = true
            cell.viewLineHeightConst.constant = 0
            
            
            cell.btnProceed.tag = indexPath.row
            cell.btnProceed.addTarget(self, action: #selector(btnProceedAction(_:)), for: .touchUpInside)
            
            cell.btnDecline.tag = indexPath.row
            cell.btnDecline.addTarget(self, action: #selector(btnDeclineAction(_:)), for: .touchUpInside)
            
            
        }  else if selectedTab == 2{
            
//            cell.lblstatusDate.isHidden = false
//            cell.imgMandate.isHidden = false

            cell.viewStatusLine.isHidden = false
            cell.viewLineHeightConst.constant = 30



            cell.setTransactionData(object: mandateTransactionArr[indexPath.row])

        } else {
            
//            cell.lblstatusDate.isHidden = false
//            cell.imgMandate.isHidden = false

            cell.viewStatusLine.isHidden = false
            
            cell.viewLineHeightConst.constant = 30


            cell.setTransactionData(object: mandateTransactionArr[indexPath.row])
            
        }
        
        
        cell.stackButtons.isHidden = selectedTab != 1
        

        
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectedTab == 1 {
            
            /*
             
            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MandateSuccessVC") as! MandateSuccessVC
            vc.mandateObject = mandateListArr[indexPath.row]
            vc.accountDetails = self.accountDetails
            vc.isPending = selectedTab == 1
            self.navigationController?.pushViewController(vc, animated: true)
            
            */
            
            
            //MandatePayDetailsVC
            
            
            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MandatePayDetailsVC") as! MandatePayDetailsVC
            vc.mandateObject = mandateListArr[indexPath.row]
            vc.accountDetails = self.accountDetails
            vc.isPending = selectedTab == 1
            
            vc.tabValue = selectedTab

            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if selectedTab == 2 {
            
            
            selectedTab = 2
            
            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MandatePayDetailsVC") as! MandatePayDetailsVC
            vc.mandateTransactionObject = mandateTransactionArr[indexPath.row]
            vc.accountDetails = self.accountDetails
            vc.tabValue = selectedTab

            //vc.accountDetails = self.accountDetails
            //vc.isPending =
        
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }
        
        else {
            
          //  cell.setTransactionData(object: mandateTransactionArr[indexPath.row])
            /*
            selectedTab = 0

            
            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CreateTransactVC") as! CreateTransactVC
            vc.mandateTransactionObject = mandateTransactionArr[indexPath.row]

            //vc.accountDetails = self.accountDetails
            //vc.isPending =
        
            self.navigationController?.pushViewController(vc, animated: true)
            */
            
            // MandatePayDetailsVC

            selectedTab = 0
            
            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MandatePayDetailsVC") as! MandatePayDetailsVC
            vc.mandateTransactionObject = mandateTransactionArr[indexPath.row]
            vc.tabValue = selectedTab
            
            vc.accountDetails = self.accountDetails
            //vc.isPending =
        
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }
    
        
        
    }
    
    @objc func btnProceedAction(_ sender: UIButton) {
        /*
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MandateSuccessVC") as! MandateSuccessVC
        vc.mandateObject = mandateListArr[sender.tag]
        vc.accountDetails = self.accountDetails
        vc.isPending = selectedTab == 1
        self.navigationController?.pushViewController(vc, animated: true)
        */
        
        
        
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MandatePayDetailsVC") as! MandatePayDetailsVC
        vc.mandateObject = mandateListArr[sender.tag]
        vc.accountDetails = self.accountDetails
        vc.isPending = selectedTab == 1
        
        vc.tabValue = selectedTab

        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
        
    }
    
    @objc func btnDeclineAction(_ sender: UIButton) {
        
        declineMandates(object: mandateListArr[sender.tag])
        
    }
    
    
    
}


extension MandateListVC: MFMessageComposeViewControllerDelegate {
    
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
            if self.apiCall == "PendingMandates" {
                self.getPendingMandates()
            } else {
                self.getMandateTransactions()
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
                    if self.apiCall == "PendingMandates" {
                        self.getPendingMandates()
                    } else {
                        self.getMandateTransactions()
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


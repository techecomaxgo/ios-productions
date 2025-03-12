//
//  BhimUPIHistoryVC.swift
//  MaxPay
//
//  Created by india on 14/11/23.
//

import UIKit
import DatePicker
import OlivePayLibrary
import SwiftLoader
import MessageUI

class BhimUPIHistoryVC: BaseVC {
    
    private var checksumViewModel = SIMSelectionViewModel()
    var refreshControl: UIRefreshControl!
    var accountDetails: AccountDetailsOnIIN?
    @IBOutlet weak var btnEndDate: UIButton!
    @IBOutlet weak var btnStartDate: UIButton!
    @IBOutlet weak var tblTrasactionHistory: UITableView!
    @IBOutlet weak var vwEndDate: UIView!
    @IBOutlet weak var vwStartDate: UIView!
    @IBOutlet weak var lblNoDataAvailable: UILabel!
    
    var tranHistoryArr: [TranHistoryModel] = []
    var isFromTabbar = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Refresh Control
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tblTrasactionHistory.refreshControl = refreshControl
        
        vwStartDate.layer.applyCornerRadiusShadow()
        vwEndDate.layer.applyCornerRadiusShadow()
        
        
        self.btnStartDate.setTitle(getCurrentDateAddingOneMonth(), for: .normal)
        self.btnEndDate.setTitle(getCurrentDateTime(), for: .normal)
        
        
        getTransactionHistory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        if isFromTabbar == true{
            
        }else{
            
        }
    }
    
    func getCurrentDateTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let dateString = formatter.string(from: Date())
        return dateString
    }
    
    @objc func refreshData() {
        // Simulate data fetching or refreshing
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            // Update your dataArray with new data here if needed
            self.getTransactionHistory()
            
            // Reload the table view
            self.tblTrasactionHistory.reloadData()
            
            // End the refreshing
            self.refreshControl.endRefreshing()
        }
    }
    
    func getCurrentDateAddingOneMonth() -> String {
        
        let currentDate = Date()
        // Create a calendar instance
        var calendar = Calendar.current

        // Add one month to the current date
        if let nextMonth = calendar.date(byAdding: .month, value: -1, to: currentDate) {
            // Define date components for formatting
            let components = calendar.dateComponents([.day, .month, .year], from: nextMonth)

            // Extract day, month, and year components
            if let day = components.day, let month = components.month, let year = components.year {
                // Format the date as "dd/mm/yyyy"
                let formattedDate = String(format: "%02d/%02d/%04d", day, month, year)
                return formattedDate
            }
        }

        // Return an empty string if unable to get the formatted date
        return ""
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnStartDateAction(_ sender: UIButton) {
        let minDate = DatePickerHelper.shared.dateFrom(day: 01, month: 08, year: 2021)!
        let maxDate = DatePickerHelper.shared.dateFrom(day: 01, month: 08, year: 2024)!
        let today = Date()
        // Create picker object
        let datePicker = DatePicker()
        // Setup
        datePicker.setup(beginWith: today, min: minDate, max: maxDate) { (selected, date) in
            if selected, let selectedDate = date {
               // print(selectedDate.string())
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                self.btnStartDate.setTitle("\(formatter.string(from: selectedDate))", for: .normal)
            } else {
                print("Cancelled")
            }
        }
        // Display
        datePicker.show(in: self, on: sender)
    }
    
    @IBAction func btnEndDateAction(_ sender: UIButton) {
        let minDate = DatePickerHelper.shared.dateFrom(day: 01, month: 08, year: 2021)!
        let maxDate = DatePickerHelper.shared.dateFrom(day: 01, month: 08, year: 2024)!
        let today = Date()
        // Create picker object
        let datePicker = DatePicker()
        // Setup
        datePicker.setup(beginWith: today, min: minDate, max: maxDate) { (selected, date) in
            if selected, let selectedDate = date {
               // print(selectedDate.string())
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                self.btnEndDate.setTitle("\(formatter.string(from: selectedDate))", for: .normal)
            } else {
                print("Cancelled")
            }
        }
        // Display
        datePicker.show(in: self, on: sender)
    }
    
    @IBAction func btnApplyAction(_ sender: Any) {
        SwiftLoader.show(animated: true)
        getTransactionHistory()
    }
    
    func getTransactionHistory() {
        DispatchQueue.main.async {
            let fromDateStr = self.btnStartDate.titleLabel?.text
            
            let toDateStr = self.btnEndDate.titleLabel?.text
            
            if let fromDate = fromDateStr, let toDate = toDateStr {
                
                DispatchQueue.main.async {
                    SwiftLoader.show(animated: true)
                }
                
                DispatchQueue.global(qos: .background).async {
                    
                    OliveUpiManager.tranHistory(fromDate: fromDate, toDate: toDate) { data, error in
                        
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
                            
                            
                            self.tranHistoryArr.removeAll()
                            
                            if let dt = data {
                                
                                if let data = SelectBankVC.convertToData(dt) {
                                    do {
                                        let beneficiaryList = try JSONDecoder().decode([TranHistoryModel].self, from: data)
                                        for beneficiary in beneficiaryList {
                                            self.tranHistoryArr.append(beneficiary)
                                        }
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                    
                                    DispatchQueue.main.async {
                                        self.tblTrasactionHistory.reloadData()
                                        self.lblNoDataAvailable.isHidden = self.tranHistoryArr.count != 0
                                        SwiftLoader.hide()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

extension BhimUPIHistoryVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tranHistoryArr.reverse()
        return tranHistoryArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BhimUPITrasactionHistoryCell", for: indexPath) as! BhimUPITrasactionHistoryCell
//        if let accountData = accountDetails{
//            cell.setTranHistoryData(data: tranHistoryArr[indexPath.row], accountDetails: accountData)
//        }
        cell.lblTxnId.text = tranHistoryArr[indexPath.row].debitBankName
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss a"
        inputFormatter.amSymbol = "AM"
        inputFormatter.pmSymbol = "PM"

        // Convert string to Date object
        if let date = inputFormatter.date(from: tranHistoryArr[indexPath.row].dateTime ?? "") {
            
            // Step 2: Format the Date into the desired output format
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMM, hh:mm a"
            
            cell.lblTxnDate.text = "on \(outputFormatter.string(from: date))"
            //print(formattedDate)  // Output: "01 Feb, 12:44 PM"
            
        } else {
            print("Invalid date format")
        }
        
        
        cell.lblStatus.text = Status.getStatus(from: tranHistoryArr[indexPath.row].status ?? "")
        
        cell.imgFromToStatusIc.image = tranHistoryArr[indexPath.row].status == "C" ? UIImage(systemName: "checkmark.circle.fill")?.withRenderingMode(.alwaysTemplate) : UIImage(systemName: "multiply.circle.fill")?.withRenderingMode(.alwaysTemplate)
        cell.imgFromToStatusIc.tintColor = tranHistoryArr[indexPath.row].status == "C" ? UIColor.init(named: "primary-green") : tranHistoryArr[indexPath.row].status == "P" ? UIColor.orange : UIColor.init(named: "status-red-color")
        
        
        //cell.imgSendReceiveIc.image = tranHistoryArr[indexPath.row].type == "PAY" ? UIImage(named: "ic_arrow_up")?.withRenderingMode(.alwaysTemplate) : UIImage(named: "ic_arrow_down")?.withRenderingMode(.alwaysTemplate)
        
        //cell.imgSendReceiveIc.tintColor = tranHistoryArr[indexPath.row].status == "C" ? UIColor.init(named: "primary-green") : tranHistoryArr[indexPath.row].status == "P" ? UIColor.orange : UIColor.init(named: "status-red-color")
        
        cell.lblAmount.text = "₹ " + (tranHistoryArr[indexPath.row].amount ?? "0")
        
        if tranHistoryArr[indexPath.row].type == "PAY" {
            if accountDetails?.vpa == tranHistoryArr[indexPath.row].creditVpa {
                cell.lblFromToLabel.text = "Received from"
                //cell.lblVpa.text = tranHistoryArr[indexPath.row].debitVpa
                cell.lblName.text = tranHistoryArr[indexPath.row].remitterName == nil ? "No Name" : tranHistoryArr[indexPath.row].remitterName
            } else {
                cell.lblFromToLabel.text = "Paid to"
               // cell.lblVpa.text = tranHistoryArr[indexPath.row].creditVpa
                cell.lblName.text = tranHistoryArr[indexPath.row].beneficiaryName == nil ? "No Name" : tranHistoryArr[indexPath.row].beneficiaryName
            }
        } else if tranHistoryArr[indexPath.row].type == "COLLECT" {
            if accountDetails?.vpa == tranHistoryArr[indexPath.row].creditVpa {
                cell.lblFromToLabel.text = "Request to"
                //cell.lblVpa.text = tranHistoryArr[indexPath.row].debitVpa
                cell.lblName.text = tranHistoryArr[indexPath.row].remitterName == nil ? "No Name" : tranHistoryArr[indexPath.row].remitterName
            } else {
                cell.lblFromToLabel.text = "Request from"
                //cell.lblVpa.text = tranHistoryArr[indexPath.row].creditVpa
                cell.lblName.text = tranHistoryArr[indexPath.row].beneficiaryName == nil ? "No Name" : tranHistoryArr[indexPath.row].beneficiaryName
            }
        }
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "BhimTrasactionDetailsVC") as! BhimTrasactionDetailsVC
        vc.tranHistoryObj = tranHistoryArr[indexPath.row]
        vc.accountDetails = self.accountDetails
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension BhimUPIHistoryVC: MFMessageComposeViewControllerDelegate {
    
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
                        SwiftLoader.hide()
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
            self.getTransactionHistory()
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
                    self.getTransactionHistory()
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


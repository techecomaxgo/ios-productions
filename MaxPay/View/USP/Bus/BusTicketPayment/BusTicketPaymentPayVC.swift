//
//  BusTicketPaymentPayVC.swift
//  MaxPay
//
//  Created by Ios Developer on 12/02/24.
//

import UIKit
import OlivePayLibrary
import SwiftLoader
import MessageUI

class BusTicketPaymentPayCell: UITableViewCell {
    
    @IBOutlet weak var imgSelection: UIImageView!
    @IBOutlet weak var lblBankNameACNo: UILabel!
    
}

class BusTicketPaymentPayVC: BaseVC {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblAvailableBalance: UILabel!
    @IBOutlet weak var lblPayingFor: UILabel!
    @IBOutlet weak var tablePaymentMethods: UITableView!
    @IBOutlet weak var btnPay: UIButton!
    @IBOutlet weak var btnWalletSelection: UIButton!

    var busName = ""
    var amtDecimal = ""
    var accountDetails: AccountDetailsOnIIN?
    private var dashboardViewModel = DashboardViewModel()
    private var checksumViewModel = SIMSelectionViewModel()
    private var busReviewViewModel = BusReviewViewModel()
    
    var selectedPickIndex = -1
    private var cardsArr:[AccountDetailsOnIIN] = []
    var totalSeatPrice:Double?
    var paymentOf = "" // "bus" / "flight" / "hotel"
    var transactionId = ""
    var selectedPaymentOption = "" // wallet / upi

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        lblPayingFor.text = "Paying for \(busName)"

//        print(Common.shared.secondary_wallet_balance ?? "0")
//        print(Common.shared.primary_wallet_balance ?? "0")
        
        lblAvailableBalance.text = "Available Balance ₹\(Common.shared.secondary_wallet_balance ?? "0")" // set wallet balance
        
        btnPay.setTitle("Pay \("₹\(totalSeatPrice ?? 0.00)")", for: .normal)

        lblAmount.text = "₹\(totalSeatPrice ?? 0.00)/-"
        
        fatchLocallyStoredAccount()
    }
    

    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
    func fatchLocallyStoredAccount() {
        
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
        tablePaymentMethods.reloadData()
    }

    @IBAction func btnWalletSelectionAction(_ sender: UIButton) {
        sender.setImage(sender.tag == 0 ? UIImage(named: "check") : UIImage(named: "uncheck"), for: .normal)
        sender.tag = sender.tag == 0 ? 1 : 0
        selectedPaymentOption = sender.tag == 1 ? "wallet" : ""
        
        selectedPickIndex = -1
        tablePaymentMethods.reloadData()
        
        accountDetails = nil
    }
    
    
    
    @IBAction func btnInfoAction(_ sender: Any) {
        
    }
    
    @IBAction func btnPayAction(_ sender: Any) {
        
        if selectedPaymentOption == "" {
            self.showErrorAlert("Please Select Payment Method to Pay.")
            return
        }

        if selectedPaymentOption == "wallet" {
            configurationDeductWallet()
        } else {
            configurationUpiPayment()
        }
    }
    
    func configurationUpiPayment() {
        
        if accountDetails == nil {
            self.showErrorAlert("Please Select Payment Method to Pay.")
            return
        }
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
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

                
        let beneVpa = BeneVpa(name: "MaxPay Billdesk", vpa: MerchantVpa, nickName: "MaxPay Billdesk")
        var strBeneVpa = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(beneVpa)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strBeneVpa = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }

        
        let x = totalSeatPrice ?? 0.00
        amtDecimal = String(format: "%.2f", Double(round(100 * x) / 100))
        
        let paymentInput = PaymentInput(amount: "\(amtDecimal)", merchantVpa: MerchantVpa, merchantId: MerchantId, submerchantid: SubMerchantId, merchantChannelId: MerchChanId, tranType: TranTypeP2M, mcc: "0000", remarks: "Bill payment for \(paymentOf) Booking", initMode: "00", purpose: "00", refCategory: "00", orderId: "", refUrl: "")
        var strPaymentInput = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(paymentInput)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strPaymentInput = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        DispatchQueue.global(qos: .background).async {
            
            // Working Properly
            OliveUpiManager.initiatePay(account: strAccountDetails, benevpa: strBeneVpa, paymentInput: strPaymentInput, viewController: self) { data, error in
                
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
                    
                    if let dataResp = data {
                        
//                        self.transId = dataResp as! String
                        self.configurationBookBus()
                        
                    }
                }
            }
        }
    }
}

// deduct-swallet-balance api call
extension BusTicketPaymentPayVC {
   //MARK: API Calling
    func configurationDeductWallet() {
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        initViewModelDeductWallet()
        observeEventDeductWallet()
    }
    //MARK Network checking
    func initViewModelDeductWallet() {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            busReviewViewModel.deductWalletBalanceCall(totalSeatPrice ?? 0.00, paymentOf)
        }else{
            DispatchQueue.main.async {
                SwiftLoader.hide()
                self.showErrorAlert("Please check your internetconnection.")
            }
        }
    }
    //MARK: Observing the data
    func observeEventDeductWallet() {
        
        busReviewViewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }

            switch event {
            case .loading:
                
                print("loading....")
                
            case .stopLoading:
                
                print("Stop loading...")
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                }
            case .dataLoaded:
                print("Data loaded...")
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                }
                if self?.busReviewViewModel.deductSWalletModel?.status == "success" {
                    
                    Common.shared.secondary_wallet_balance = self?.busReviewViewModel.deductSWalletModel?.data?.balance ?? "0.00"
                    
//                     self?.showBookingSuccess(self?.busReviewViewModel.busRevieweModel?.data?.transactionid ?? "")
                    
                    self?.configurationBookBus()
                    
//                    DispatchQueue.main.async {
//                        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
//                        let vc = storyboard.instantiateViewController(withIdentifier: "PaymentSuccessfulVC") as! PaymentSuccessfulVC
//
//                        vc.accountDetails = self?.accountDetails
//    //                    vc.beneVpa = self?.beneVpa
//    //                    vc.beneName = self?.txtName.text!
//                        vc.transId = self?.transactionId ?? ""
//                        vc.amount = "\(self?.amtDecimal ?? "0.00")"
//
//                        self?.navigationController?.pushViewController(vc, animated: true)
//                    }
                }
                else{
                    DispatchQueue.main.async {
                        self?.showErrorAlert(self?.busReviewViewModel.deductSWalletModel?.message ?? "")
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
    
    func showBookingSuccess(_ IntTrasactionID: String){
        let vw = BookingViewSuccess()
        vw.frame = UIScreen.main.bounds
        vw.delegate = self
        vw.setupUI(IntTrasactionID)
        view.addSubview(vw)
    }
}

extension BusTicketPaymentPayVC: BookingViewSuccessDelegate {
    func backToHome() {
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
        self.navigationController?.pushViewController(vc,animated: true)
    }
}

// Book bus api call
extension BusTicketPaymentPayVC {
   //MARK: API Calling
    func configurationBookBus() {
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        initViewModelBookBus()
        observeEventBookBus()
    }
    //MARK Network checking
    func initViewModelBookBus() {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            busReviewViewModel.busBookCall(transactionId)
        }else{
            DispatchQueue.main.async {
                SwiftLoader.hide()
                self.showErrorAlert("Please check your internetconnection.")
            }
        }
    }
    //MARK: Observing the data
    func observeEventBookBus() {
        
        busReviewViewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }

            switch event {
            case .loading:
                
                print("loading....")
                
            case .stopLoading:
                
                print("Stop loading...")
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                }
            case .dataLoaded:
                print("Data loaded...")
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                }
                if self?.busReviewViewModel.busBookModel?.status == "success" {
                    
                    self?.showBookingSuccess(self?.transactionId ?? "")

//                    DispatchQueue.main.async {
//                        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
//                        let vc = storyboard.instantiateViewController(withIdentifier: "PaymentSuccessfulVC") as! PaymentSuccessfulVC
//
//                        vc.accountDetails = self?.accountDetails
//    //                    vc.beneVpa = self?.beneVpa
//    //                    vc.beneName = self?.txtName.text!
//                        vc.transId = self?.transactionId ?? ""
//                        vc.amount = "\(self?.amtDecimal ?? "0.00")"
//
//                        self?.navigationController?.pushViewController(vc, animated: true)
//                    }
                }
                else{
                    DispatchQueue.main.async {
                        self?.showErrorAlert("Something went wrong, please try again.") // self?.busReviewViewModel.busBookModel?.message ?? ""
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
}

extension BusTicketPaymentPayVC: MFMessageComposeViewControllerDelegate {
    
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
            //print("The data is:\(String(describing: data))")
            self.btnPayAction(UIButton())
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
                    
                    self.btnPayAction(UIButton())
                    
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

extension BusTicketPaymentPayVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardsArr.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == cardsArr.count {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.font = UIFont(name: "Roboto", size: 14)
            cell.textLabel?.text = "+ Add Account"
            cell.textLabel?.textColor = UIColor(named: "reload-grey-color")
            return cell
        }

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusTicketPaymentPayCell") as! BusTicketPaymentPayCell
        
        cell.imgSelection.image = selectedPickIndex == indexPath.row ? UIImage(named: "circle-boarding-selected") : UIImage(named: "circle-boarding-notselected")
        cell.lblBankNameACNo.text = (cardsArr[indexPath.row].bankName ?? "") + " A/C " + (cardsArr[indexPath.row].maskedAccnumber ?? "")
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == cardsArr.count {
            let vc = UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "BhimUPVC") as! BhimUPVC
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        selectedPickIndex = indexPath.row
        tablePaymentMethods.reloadData()
        
        selectedPaymentOption = "upi"
        btnWalletSelection.setImage(UIImage(named: "uncheck"), for: .normal)
        btnWalletSelection.tag = 0
        
        accountDetails = cardsArr[indexPath.row]
        
    }
    
}


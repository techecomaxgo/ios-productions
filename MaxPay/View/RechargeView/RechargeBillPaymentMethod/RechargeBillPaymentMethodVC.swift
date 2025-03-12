//
//  RechargeBillPaymentMethodVC.swift
//  MaxPay
//
//  Created by Ios Developer on 21/05/24.
//

import UIKit
import SwiftLoader
import OlivePayLibrary

class RechargeBillPaymentMethodVC: BaseVC,UIGestureRecognizerDelegate{
    var accountDetails: AccountDetailsOnIIN?
    var paymentOf = ""
    var txnID = ""
    var apiCallOption = ""
    private var checksumViewModel = SIMSelectionViewModel()
    //----
    private var cardsArr:[AccountDetailsOnIIN] = []
    
    private var rechargeAllPlanVM =  RechargePlansViewModel()
    
    var paymentMode = ""
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var priceBreakupView: UIView!
    
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblBillAmt: UILabel!
    @IBOutlet weak var lblPlatformfees: UILabel!
    @IBOutlet weak var lblgrandTotal: UILabel!
    

    @IBOutlet weak var tableViewCard: UITableView!
    
    
    @IBOutlet weak var lblTotalamount: UILabel!
    
    @IBOutlet weak var lblUPIamount: UILabel!
    
    @IBOutlet weak var btnPay: DesignableButton!
    
    @IBOutlet weak var btnViewDetails: UIButton!
    
    
    
    var activityIndicator: UIActivityIndicatorView!

    var priceStr = 0
    
    var selectedBankIndex: IndexPath?

    @IBOutlet weak var lblAvBalance: UILabel!
    
    @IBOutlet weak var btnWallet: UIButton!
    
    private var paymentWalletDeductVM =  PaymentWalletDeductViewModel()
    
    var rechargeModelView = Recharge_ModelView()

    @IBOutlet weak var lblPaymentModedisp: UILabel!
    
    @IBOutlet weak var viewForUpiCardConst: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.viewDetails.isHidden = true
        self.priceBreakupView.isHidden = true
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        self.viewDetails.addGestureRecognizer(gesture)
        
        print(Common.shared.sum_wallet_balance ?? "")
        
        // Available Balance ₹2490
        
        lblAvBalance.text = "Available Balance ₹\(Common.shared.secondary_wallet_balance ?? " 0.00")"
        
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
        
        print(cardsArr)
        
        //btnPay.setTitle("Pay ₹ \(priceStr)", for: .normal)
        
        lblUPIamount.text = "UPI amount \(formatPriceWithRupeeSymbols(price: priceStr))"
        
        lblTotalamount.text = "\(formatPriceWithRupeeSymbol(price: priceStr))"
        
        lblBillAmt.text = "\(formatPriceWithRupeeSymbol(price: priceStr))"

        lblgrandTotal.text = "\(formatPriceWithRupeeSymbol(price: priceStr))"
        
        
        if cardsArr.count == 1 {
            viewForUpiCardConst.constant = 300

        }else if cardsArr.count == 2 {
            viewForUpiCardConst.constant = 300 + 80

        }else if cardsArr.count == 3 {
            viewForUpiCardConst.constant = 300 + 160

        }else if cardsArr.count >= 4 {
            viewForUpiCardConst.constant = 980 + 240

        }
        else{
            
            viewForUpiCardConst.constant = 150

        }
        let userDefaults = UserDefaults.standard
        for (key, value) in userDefaults.dictionaryRepresentation() {
            print("\(key): \(value)")
        }
    }
    
    
     func formatPriceWithRupeeSymbol(price: Int) -> String {
        // Format the price to 2 decimal places if needed
        let formattedPrice = String(price)
        
        // Concatenate the rupee symbol with the formatted price
        let priceWithRupeeSymbol = "₹ \(formattedPrice)/-"
        
        return priceWithRupeeSymbol
    }
    func formatPriceWithRupeeSymbols(price: Int) -> String {
       // Format the price to 2 decimal places if needed
       let formattedPrice = String(price)
       
       // Concatenate the rupee symbol with the formatted price
       let priceWithRupeeSymbol = "₹ \(formattedPrice)"
       
       return priceWithRupeeSymbol
   }
    
    
    @IBAction func btnWalletClicked(_ sender: UIButton) {
    
        sender.isSelected.toggle()
        updateButtonImage()
        

    }
    
    @IBAction func btnClose(_ sender: UIButton) {
    
        self.viewDetails.isHidden = true
        self.priceBreakupView.isHidden = true
    }
    
    @IBAction func btnVDetailsClicked(_ sender: UIButton) {
    
        self.viewDetails.isHidden = false
        self.priceBreakupView.isHidden = false
        
    }
    
    @objc func someAction(_ sender:UITapGestureRecognizer){
        print("view was clicked")
        self.viewDetails.isHidden = true
        self.priceBreakupView.isHidden = true
    }
    
    
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func btnPayClicked(_ sender: UIButton) {
        

       
        
       
        let getName = UserDefaults.standard.string(forKey: "operatorName")
        print("getName:",getName ?? "")
        
        let getcircle = UserDefaults.standard.string(forKey: "circle")
        print("getcircle:",getcircle ?? "")

        
        // RechargeBillSuccess
        
        //btnPay
        
        //  paymentMode = "WalletPay"
        
        if paymentMode != ""{
            
           PaymentProcess()
           // rechargeMethod()
            
        }else{
            
            
            let refreshAlert = UIAlertController(title: "Bill Pay", message: "Please select Payment mode", preferredStyle: UIAlertController.Style.alert)

            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                  print("Handle Ok logic here")
            }))


            present(refreshAlert, animated: true, completion: nil)
            
            
            
        }
       
        
        func PaymentProcess() {
            
            let isConnected = ReachabilityClass.isConnectedToNetwork()
            
            if isConnected == true {
                //configurationUpiPayment()
                
                let txnID = self.getUniqueTransId()
                self.rechargeModelView.RechargePayUFirstAPICall(amountStr: self.priceStr, phoneStr: Common.shared.phoneNo ?? "", txnidnew: txnID, customerEmail: (Common.shared.phoneNo ?? "") + "@maxupi.in", productinfo: "recharge", firstname: Common.shared.userFirstName ?? "", device_id: Common.shared.getDeviceID(), client_ip: Common.shared.getDeviceIP())

                observePayUFirstAPI()
                
                
                //paymentWalletDeductVM.PaymentDeductCall(skeyStr: "AVJQIdwn79iR0zlP0iKNKumME",deduct_amountStr: priceStr, categoryStr: "recharge")  Anand
                
//                circleView_Model.CircleZoneCall(skeyStr: "142418AgQWGaSEHXoQ58ae75c4")

               //observeDeductApi()  Anand
                
            }else{
                
                SwiftLoader.hide()
                self.showErrorAlert("Please check your internet connection.")
                
            }
            
            
            
        }
        
        
        
        //MARK: Observing the data
        func observeDeductApi() {
            
            paymentWalletDeductVM.eventHandler = { [weak self] event in
                guard self != nil else { return }

                switch event {
                case .loading:
                    
                    print("loading....")
                    
                case .stopLoading:
                    
                    print("Stop loading...")
                    SwiftLoader.hide()
                case .dataLoaded:
                    
                    print("Data loaded...")
                    DispatchQueue.main.async {
                                            
                  //  print(self?.paymentWalletDeductVM.paymentDeductModel?.data)
                        
                        SwiftLoader.hide()
                        
                        if self?.paymentWalletDeductVM.paymentDeductModel?.status == "success" {
                            
                          //  self?.circleNamesArr = self?.circleView_Model.circlezoneModel?.circle_names
                            
                         //   print("result :", self?.paymentWalletDeductVM.paymentDeductModel?.data)
                          //  print(self?.paymentWalletDeductVM.paymentDeductModel?.data?.txn_id ?? "")
                            
                            self?.rechargeModelView.RechargeModelApiCall(skeyStr: "AVJQIdwn79iR0zlP0iKNKumME", amountStr: self?.priceStr ?? 0, rechargenumberStr: Common.shared.userMobile_NUMBER ?? "", phoneStr: Common.shared.phoneNo ?? "", txnIdStr:self?.paymentWalletDeductVM.paymentDeductModel?.data?.txn_id ?? "", ViaStr: "swallet")
                            
                            ObserveRechargeModelViewApi()
                            
                            DispatchQueue.main.async {
                               
                                SwiftLoader.hide()
                            }
                            
                        }else{
                            
                            self?.showErrorAlert(self?.paymentWalletDeductVM.paymentDeductModel?.status ?? "")

                        }
                        
                        
                    }
                case .error(let error):
                    print(error!)
                    SwiftLoader.hide()
                }
            }
        }
        
        func observePayUFirstAPI() { // First Call
            
            rechargeModelView.eventHandler = { [weak self] event in
                guard self != nil else { return }

                switch event {
                case .loading:
                    
                    print("loading....")
                    
                case .stopLoading:
                    
                    print("Stop loading...")
                    SwiftLoader.hide()
                case .dataLoaded:
                    
                    print("Data loaded...")
                    DispatchQueue.main.async { [self] in
                        self?.apiCallOption = "pay"
                        SwiftLoader.hide()
                        print("self?.rechargeModelView.PayUFirstForRecharge: ", self?.rechargeModelView.payUFirstForRecharge)
                      //  self?.configurationUpiPayment()
                        
                        if self!.accountDetails == nil {
                           // self.showErrorAlert("Please Select Payment Method to Pay.")
                            return
                        }
                        
                        DispatchQueue.main.async {
                            SwiftLoader.show(animated: true)
                        }
                        
                        let accountDetails = AccountPay2(name: self!.accountDetails?.name ?? "", mmid: self!.accountDetails?.mmid ?? "", aeba: self!.accountDetails?.aeba ?? "", mbeba: self!.accountDetails?.mbeba ?? "", accRefNumber: self!.accountDetails?.accRefNumber ?? "", ifsc: self!.accountDetails?.ifsc ?? "", maskedAccnumber: self?.accountDetails?.maskedAccnumber ?? "", status: self!.accountDetails?.status ?? "", type: self!.accountDetails?.type ?? "", vpa: self!.accountDetails?.vpa ?? "", dLength: self!.accountDetails?.dLength ?? "", dType: self!.accountDetails?.dType ?? "", balance: self!.accountDetails?.balance ?? "", balTime: self!.accountDetails?.balTime ?? "", iin: self!.accountDetails?.iin ?? "")
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
                        print("strAccountDetails: ", strAccountDetails)
                        
                        
                        let paymentInput = PaymentInput2(amount: self?.rechargeModelView.am ?? "", merchantVpa: "ecomaxgo@maxaxis", merchantId: "ECOMAXGOPROD1234", submerchantid: "ECOMAXGOPROD1234", merchantChannelId: "ECOMAXGOPROD1234", tranType: "P2M", mcc: "4814", remarks: "Recharge", initMode: "00", purpose: "00", refCategory: "00", orderId: self?.rechargeModelView.tr ?? "id", refUrl: "https://www.maxupi.in", merchatntTxnId: self?.rechargeModelView.payUFirstForRecharge?.metaData?.txnId ?? "")
                        
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
                        print("strPaymentInput: ", strPaymentInput)
                            
                        
                        var strBeneVpa = ""
                        do {
                            let encoder = JSONEncoder()
                            encoder.outputFormatting = .prettyPrinted
                            let jsonData = try encoder.encode(self?.rechargeModelView.beneVpa)
                            if let jsonString = String(data: jsonData, encoding: .utf8) {
                                strBeneVpa = jsonString
                            }
                        } catch {
                            print("Error encoding JSON: \(error)")
                        }
                        print("strBeneVpa: ", strBeneVpa)
                        
                        OliveUpiManager.initiatePay(account: strAccountDetails, benevpa: strBeneVpa, paymentInput: strPaymentInput, viewController: self!) { data, error in
                            
                            if let err = error {
                                DispatchQueue.main.async {
                                    let storyboard = UIStoryboard(name: "USP", bundle: nil)
                                    if let vc = storyboard.instantiateViewController(withIdentifier: "MPinPopUpVC") as? MPinPopUpVC {
                                        vc.desTitle = err.localizedDescription  // Using proper error description
                                        self?.present(vc, animated: true)
                                    }
                                }

        
                                if err.code == 102 || err.code == 108 { // Customer Accounts not found
                                    DispatchQueue.main.async {
                                        self?.showErrorAlert(err.localizedDescription)
                                    }
                                } else if err.code == 401 || err.code == 107{
                                    
                                    self?.configuration()
                                    return
                                    
                                }
                                DispatchQueue.main.async {
                                    SwiftLoader.hide()
                                }

                            } else {
                                
                                
                               
                                if let dataResp = data  {
                                    
                                    
                                    //let isConnected = ReachabilityClass.isConnectedToNetwork()
//                                    if isConnected == true {
                                        let txnID = dataResp as! String
                                        
                                        // Today Task
                                        
                                        let rechargeNo = Common.shared.userMobile_NUMBER ?? ""
                                        print("rechargeNo:",rechargeNo)
                                        
//                                        print("OperatorName:",(self?.rechargeAllPlanVM.rechargeAllModel?.data?.operatorName)!)
//                                        print("Circle:",(self?.rechargeAllPlanVM.rechargeAllModel?.data?.circle)!)
                                       
                                        let  operatorStr = self?.rechargeAllPlanVM.rechargeAllModel?.data?.operatorName ?? ""
                                        let  circle = self?.rechargeAllPlanVM.rechargeAllModel?.data?.circle ?? ""

                                        
                                        
//                                        let x : Int = self!.priceStr
//                                        let xNSNumber = x as NSNumber
//                                        let xString : String = xNSNumber.stringValue
//
//                                    self?.rechargeModelView.RechargePayUSecondAPICall(amountStr: xString, phoneStr:rechargeNo, provider:operatorStr, location:circle, txnidnew: txnID, latitude: "77.391029", longitude:"28.535517", device_id: Common.shared.getDeviceID(), client_ip: Common.shared.getDeviceIP())
                                        
                                    
                                        DispatchQueue.main.async {
                                            
                                            if dataResp is [String: Any] {
                                            
                                            } else {
                                                print("Error: Data format is incorrect")  // Handle unexpected response format
                                            }
                                        let storyboard = UIStoryboard(name: "USP", bundle: nil)
                                        if let successVC = storyboard.instantiateViewController(withIdentifier: "RechargeBillSuccess") as? RechargeBillSuccess {
                                            if let dataDict = dataResp as? [String: Any] {
                                                successVC.transactionData = dataDict
                                            } else {
                                                print("Error: dataResp is not a valid dictionary")
                                            }
                                            self?.navigationController?.pushViewController(successVC, animated: true)
                                        }
                                        }
                                    
                                    
                                }
                            }
                        }

                    }
                case .error(let error):
                    print(error!)
                    SwiftLoader.hide()
                }
            }
        }
        

        
        //MARK: Observing the data
        func ObserveRechargeModelViewApi() {
            
            rechargeModelView.eventHandler = { [weak self] event in
                guard self != nil else { return }

                switch event {
                case .loading:
                    
                    print("loading....")
                    
                case .stopLoading:
                    
                    print("Stop loading...")
                    SwiftLoader.hide()
                case .dataLoaded:
                    
                    print("Data loaded...")
                    DispatchQueue.main.async {
                                            
                       // print((self?.rechargeAllPlanVM.rechargeAllModel?.data?.plans)!)
                        
                 
                           
                            SwiftLoader.hide()
                        
                        if self?.rechargeModelView.rechargeModelBase?.status == "success" {
                            
                          //  self?.circleNamesArr = self?.circleView_Model.circlezoneModel?.circle_names
                            
                           // print("result :", self?.rechargeModelView.rechargeModelBase?.data)
                            
                            //RechargeBillSuccess
                                                    
                            
//                            self?.showErrorAlert(self?.paymentWalletDeductVM.paymentDeductModel?.status ?? "")
                            
                            
                            let storyboard = UIStoryboard(name: "USP", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "RechargeBillSuccess") as! RechargeBillSuccess
                            //vc.priceStr = String(pricePStr)
                            vc.amountStr = String(self?.priceStr ?? 0)

                            self?.navigationController?.pushViewController(vc, animated: true)
                          
                            
                        }else if  self?.rechargeModelView.rechargeModelBase?.status == "failed" {
                            
                            
                            
                            let storyboard = UIStoryboard(name: "USP", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "RechargeBillFailedVC") as! RechargeBillFailedVC
                            //vc.priceStr = String(pricePStr)
                            vc.amountStr = String(self?.priceStr ?? 0)
                            
                            if self?.paymentMode == "WalletPay" {
                                
                                vc.consumerName = "S Wallet"
                                
                            }else{
                                vc.consumerName = "UPI"
                                
                            }
                            vc.receiverName = "MaxPay recharge"
                            
                           
                            
                            self?.navigationController?.pushViewController(vc, animated: true)
                            
                            
                        }
                        else if  self?.rechargeModelView.rechargeModelBase?.status == "pending" {
                            
                            
                            
                            let storyboard = UIStoryboard(name: "USP", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "RechargeBillPendingVC") as! RechargeBillPendingVC
                            //vc.priceStr = String(pricePStr)
                            vc.amountStr = String(self?.priceStr ?? 0)

                            self?.navigationController?.pushViewController(vc, animated: true)
                            
                            
                        }
                        
                        
                        else{
                            
                            self?.showErrorAlert(self?.paymentWalletDeductVM.paymentDeductModel?.status ?? "")

                            
                        }
                      
                    }
                case .error(let error):
                    print(error!)
                    SwiftLoader.hide()
                }
            }
        }
        
        
        
//        let storyboard = UIStoryboard(name: "USP", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "RechargeBillSuccess") as! RechargeBillSuccess
//       // vc.priceStr = String(pricePStr)
//
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    private func updateButtonImage() {
            if btnWallet.isSelected {
                btnWallet.setImage(UIImage(named: "check"), for: .normal)
                
                paymentMode = "WalletPay"
                
              //  Paying through wallet or UPI
                if paymentMode == "WalletPay" {
                    lblPaymentModedisp.text = "Paying through wallet"
                    
                }else{
                    lblPaymentModedisp.text = "Paying through UPI"

                    
                }
                
            } else {
                
                btnWallet.setImage(UIImage(named: "uncheck"), for: .normal)
                
                paymentMode = ""
                
            }
        }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func getUniqueTransId() -> String {
        let idOne = UUID().uuidString
        var txnId = idOne.replacingOccurrences(of: "-", with: "")
        txnId = "AXI" + txnId

        // Ensure the transaction ID is exactly 35 characters
        if txnId.count > 35 {
            txnId = String(txnId.prefix(35))
        } else if txnId.count < 35 {
            // If somehow it's less than 35 characters, pad it with zeros
            txnId = txnId.padding(toLength: 35, withPad: "0", startingAt: 0)
        }
        return txnId
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
        print("strAccountDetails: ", strAccountDetails)
                
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
        print("strBeneVpa: ", strBeneVpa)
        
        
        let paymentInput = PaymentInput(amount: "\(priceStr)", merchantVpa: MerchantVpa, merchantId: MerchantId, submerchantid: SubMerchantId, merchantChannelId: MerchChanId, tranType: TranTypeP2M, mcc: "0000", remarks: "Bill payment for \(paymentOf) Booking", initMode: "00", purpose: "00", refCategory: "00", orderId: (self.rechargeModelView.tr)!, refUrl: (self.rechargeModelView.am)!)
        print("paymentInput: ", paymentInput)
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
        print("strPaymentInput: ", strPaymentInput)
        DispatchQueue.global(qos: .background).async {
            
            // Working Properly
            OliveUpiManager.initiatePay(account: strAccountDetails, benevpa: strBeneVpa, paymentInput: strPaymentInput, viewController: self) { data, error in
                
                if let err = error {
                    
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
                    
                    if let dataResp = data {
                        
//                        self.transId = dataResp as! String
                        //self.configurationBookBus()
                        
                    }
                }
            }
        }
    }
//    func configuration() {
//        initViewModel()
//        observeEvent()
//    }
//    func initViewModel() {
//        let isConnected = ReachabilityClass.isConnectedToNetwork()
//
//        if isConnected == true {
//            checksumViewModel.loginChecksumCall(Common.shared.phoneNo ?? "", Common.shared.getDeviceID() ?? "")
//        }else{
//            DispatchQueue.main.async {
//                SwiftLoader.hide()
//                self.showErrorAlert("Please check your internet connection.")
//            }
//
//        }
//    }
    
}


extension RechargeBillPaymentMethodVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cardsArr.count

        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableViewCard.dequeueReusableCell(withIdentifier: "PayCardsTableViewCell") as! PayCardsTableViewCell
        
        cell.lblBankName.text = "\(cardsArr[indexPath.row].bankName ?? "") \(cardsArr[indexPath.row].maskedAccnumber ?? "")"
        
        
        cell.isSelectedCell = indexPath == selectedBankIndex

        
        //print("Index Selected : ",indexPath)
        //print("Bank Index Selected : ",cardsArr[indexPath.row].bankName ?? "")
        //print(indexPath.row)
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //PlanViewPopupVC
//        popOverVC.view.frame = self.view.frame
//        self.view.addSubview(popOverVC.view)
//        self.addChild(popOverVC)
        paymentMode = "UPI"
        print("Index Selected",indexPath.row)
        selectedBankIndex = indexPath
        tableView.reloadData()
        accountDetails = cardsArr[indexPath.row]

        
    }
    
    
    
}

extension RechargeBillPaymentMethodVC: MFMessageComposeViewControllerDelegate {
    
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
                    
                    //self?.performMerchantHandshake()
                    
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
            if self.apiCallOption == "pay" {
                //self.btnProceedAction(UIButton())
            } else if self.apiCallOption == "bene" {
                //self.saveBeneficary(dataResp: self.transId)
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
                    if self.apiCallOption == "pay" {
                        //self.btnProceedAction(UIButton())
                    } else if self.apiCallOption == "bene" {
                        //self.saveBeneficary(dataResp: self.transId)
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

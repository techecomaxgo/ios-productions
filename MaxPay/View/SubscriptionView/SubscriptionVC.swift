import UIKit
import SwiftLoader
import OlivePayLibrary

class SubscriptionVC: BaseVC {

    @IBOutlet weak var tableViewsubscription: UITableView!
  
    @IBOutlet weak var totalAmount: UILabel!
    
    var accountDetails: AccountDetailsOnIIN?
    private var cardsArr:[AccountDetailsOnIIN] = []
    let subscriptionAdd = SubscriptionAddModel() // Initialize it
    
    var subscription = Recharge_ModelView()
    //var subscriptionAdd = SubscriptionAddModel()
    var subscriptionResponse: SubscriptionResponse?
    private var subscriptionViewViewModel = SubscriptionViewViewModel()
    var selectedFeatures: [Feature] = []
    var selectedAmounts: [String] = []  // Store selected amounts

    var priceStr = "0"
    var txnID = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableViewsubscription.delegate = self
        tableViewsubscription.dataSource = self
        
        subscriptionViewViewModel.subscriptionmodel()
        
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
        accountDetails = cardsArr[0]
        observeEvent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        tableViewsubscription.reloadData()
    }

    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnPay(_ sender: Any) {
        
        if let price = Double(self.priceStr), price > 0 {
        
            RequestSubscriptionPay()
        } else {
          
            showToast(message: "Please select a subscription")
        }
        
       
        
    }
    
    func observeEvent() {
        subscriptionViewViewModel.eventHandler = { [weak self] event in
            guard let self = self else { return }

            switch event {
            case .loading:
                SwiftLoader.show(animated: true)
            case .stopLoading:
                SwiftLoader.hide()
            case .dataLoaded:
                if self.subscriptionViewViewModel.subscription?.status.lowercased() == "success" {
                    self.subscriptionResponse = self.subscriptionViewViewModel.subscription
                    DispatchQueue.main.async {
                        self.tableViewsubscription.reloadData()
                    }
                } else {
                    self.showErrorAlert("Error: Invalid subscription status.")
                }
            case .error(let error):
                SwiftLoader.hide()
                print(error ?? "Unknown error")
            }
        }
    }
    
    func RequestSubscriptionPay() {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            //configurationUpiPayment()
            
             txnID = self.getUniqueTransId()
            
            subscription.RechargePayUFirstAPICall(amountStr: priceStr, phoneStr: Common.shared.phoneNo ?? "", txnidnew: txnID, customerEmail: (Common.shared.phoneNo ?? "") + "@maxupi.in", productinfo: "subscription", firstname: Common.shared.userFirstName ?? "", device_id: Common.shared.getDeviceID(), client_ip: Common.shared.getDeviceIP())

            observePayUFirstAPI()
            
            
        
            
        }else{
            
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internet connection.")
            
        }
    }
    func observeFinalSubscribe() {
        
        subscriptionAdd.eventHandler = { [weak self] event in
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
                                        
                        SwiftLoader.hide()
                    self?.showPopupDialog()
                    
                }
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
            }
        }
    }
    func showPopupDialog() {
             let alertController = UIAlertController(title: "Payment successful",
                                                     message: "Feature Activated.",
                                                     preferredStyle: .alert)

             let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                 // Dismiss alert and close the current view controller
                 self.dismiss(animated: true, completion: nil)
             }

             alertController.addAction(okAction)
             present(alertController, animated: true, completion: nil)
         }

     
    func observePayUFirstAPI() { // First Call
        
        subscription.eventHandler = { [weak self] event in
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
                    
                    SwiftLoader.hide()
                    print("self?.rechargeModelView.PayUFirstForRecharge: ", self?.subscription.payUFirstForRecharge)
                    
                    // Check if account details are selected
                    if self!.accountDetails == nil {
                        print("errorcheckvinay")
                        return
                    }
                    
                    // Show loader again before initiating the Olive service call
                    DispatchQueue.main.async {
                        SwiftLoader.show(animated: true)
                    }
                    
                    // Prepare account details
                    
                    let accountDetails = AccountPay2(name: self!.accountDetails?.name ?? "", mmid: self!.accountDetails?.mmid ?? "", aeba: self!.accountDetails?.aeba ?? "", mbeba: self!.accountDetails?.mbeba ?? "", accRefNumber: self!.accountDetails?.accRefNumber ?? "", ifsc: self!.accountDetails?.ifsc ?? "", maskedAccnumber: self?.accountDetails?.maskedAccnumber ?? "", status: self!.accountDetails?.status ?? "", type: self!.accountDetails?.type ?? "", vpa: self!.accountDetails?.vpa ?? "", dLength: self!.accountDetails?.dLength ?? "", dType: self!.accountDetails?.dType ?? "", balance: self!.accountDetails?.balance ?? "", balTime: self!.accountDetails?.balTime ?? "", iin: self!.accountDetails?.iin ?? "")
                    
                    var strAccountDetails = ""
                    do {
                        let encoder = JSONEncoder()
                        encoder.outputFormatting = .prettyPrinted
                        let jsonData = try encoder.encode(accountDetails)
                        if let jsonString = String(data: jsonData, encoding: .utf8) {
                            strAccountDetails = jsonString
                        }
                    } catch {
                        print("Error encoding JSON: \(error)")
                    }
                    print("strAccountDetails: ", strAccountDetails)
                    
                    
                    
                    
                    // Prepare payment input details
                    let paymentInput = PaymentInput2(amount: self?.priceStr ?? "" , merchantVpa: Merchantvpa, merchantId: Merchantid, submerchantid: Submerchantid, merchantChannelId: MerchantChannelId, tranType: TranType, mcc: Mcc, remarks: "Subscription", initMode: Codezero, purpose: Codezero, refCategory: Codezero, orderId: self?.subscription.tr ?? "", refUrl: RefUrl, merchatntTxnId: self?.txnID ?? "")
                    //orderId = tr
                    //merchatntTxnId = txnID
                    var strPaymentInput = ""
                    do {
                        let encoder = JSONEncoder()
                        encoder.outputFormatting = .prettyPrinted
                        let jsonData = try encoder.encode(paymentInput)
                        if let jsonString = String(data: jsonData, encoding: .utf8) {
                            strPaymentInput = jsonString
                        }
                    } catch {
                        print("Error encoding JSON: \(error)")
                    }
                    print("strPaymentInput: ", strPaymentInput)
                    
                    // Prepare Bene VPA
                    var strBeneVpa = ""
                    do {
                        let encoder = JSONEncoder()
                        encoder.outputFormatting = .prettyPrinted
                        let jsonData = try encoder.encode(self?.subscription.beneVpa)
                        if let jsonString = String(data: jsonData, encoding: .utf8) {
                            strBeneVpa = jsonString
                        }
                    } catch {
                        print("Error encoding JSON: \(error)")
                    }
                    print("strBeneVpa: ", strBeneVpa)
                    
                    // Call the new function to initiate the Olive payment
                    initiateOlivePayment(accountDetails: strAccountDetails, beneVpa: strBeneVpa, paymentInput: strPaymentInput)
                    
                }
                
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
            }
        }
        
        func initiateOlivePayment(accountDetails: String, beneVpa: String, paymentInput: String) {
        
            
            OliveUpiManager.initiatePay(account: accountDetails, benevpa: beneVpa, paymentInput: paymentInput, viewController: self) { data, error in
                if let err = error {
                    DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: "USP", bundle: nil)
                        if let vc = storyboard.instantiateViewController(withIdentifier: "MPinPopUpVC") as? MPinPopUpVC {
                            vc.desTitle = err.localizedDescription
                            self.present(vc, animated: true)
                        }
                    }
                    
                    // Handle specific error codes
                    if err.code == 102 || err.code == 108 { // Customer Accounts not found
                        DispatchQueue.main.async {
                            self.showErrorAlert(err.localizedDescription)
                        }
                    } else if err.code == 401 || err.code == 107 {
                        self.showErrorAlert(err.localizedDescription)
                        //  self.configuration()
                        return
                    }
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                    }
                    
                } else {
                    if let dataResp = data {
                        SwiftLoader.hide()
                        var transId = dataResp as! String
                        
                        let subscriptionsArray = self.selectedFeatures.map { feature in
                            return [
                                "feature": feature.feature,
                                "amount": Double(feature.price) ?? 0.0
                            ]
                        }
                        
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: subscriptionsArray, options: .prettyPrinted)
                            
                            if let jsonString = String(data: jsonData, encoding: .utf8) {
                                print(jsonString) // Debug output
                                self.subscriptionAdd.subscriptionmodelAdd(KSkeyValue, total: self.priceStr, txn_id: transId, jsonString: jsonString)
                                self.observeFinalSubscribe()
                            }
                            
                            //  return String(data: jsonData, encoding: .utf8)
                        } catch {
                            print("Error converting subscriptions to JSON: \(error)")
                            
                        }
                        //SubscribeNow(transId: transId)
                        
                        
                        
                        
                    }
                }
            }
        }
        
    }
      
 
    
    func getUniqueTransId() -> String {
        let idOne = UUID().uuidString
        var txnid = idOne.replacingOccurrences(of: "-", with: "")
        txnid = "AXI" + txnid

        // Ensure the transaction ID is exactly 35 characters
        if txnid.count > 35 {
            txnid = String(txnid.prefix(35))
        } else if txnid.count < 35 {
            // If somehow it's less than 35 characters, pad it with zeros
            txnid = txnid.padding(toLength: 35, withPad: "0", startingAt: 0)
        }
        return txnid
    }
}

// MARK: TableView Methods
extension SubscriptionVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subscriptionResponse?.data?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FetechingBillCellTable", for: indexPath) as! FetechingBillCellTable
            let feature = subscriptionResponse?.data?[indexPath.row]
            cell.selectionStyle = .none
            if let feature = feature {
                let isSelected = selectedFeatures.contains { $0.feature == feature.feature }
                cell.configure(with: feature, isSelected: isSelected)
                
                // Handle switch toggle event
                cell.switchAction = { [weak self] isOn in
                    guard let self = self else { return }

                    if isOn {
                        if !self.selectedFeatures.contains(where: { $0.feature == feature.feature }) {
                            self.selectedFeatures.append(feature)
                        }
                    } else {
                        self.selectedFeatures.removeAll { $0.feature == feature.feature }
                    }

                    self.updateTotalAmount()
                }
            }

            return cell
        }

    func updateTotalAmount() {
        let total = selectedFeatures.compactMap { Double($0.price) }.reduce(0, +)
        totalAmount.text = "₹ \(total)"
        let formattedTotal = String(format: "%.2f", total)
        priceStr = "1.00"
        priceStr = "\(formattedTotal)"
    }
}

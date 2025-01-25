//
//  RechargeBillPaymentMethodVC.swift
//  MaxPay
//
//  Created by Ios Developer on 21/05/24.
//

import UIKit
import SwiftLoader

class RechargeBillPaymentMethodVC: BaseVC {

    private var cardsArr:[AccountDetailsOnIIN] = []
    
    var paymentMode = ""
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var tableViewCard: UITableView!
    
    
    @IBOutlet weak var lblTotalamount: UILabel!
    
    @IBOutlet weak var btnPay: DesignableButton!
    
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
        
        
        print(Common.shared.sum_wallet_balance ?? "")
        
        // Available Balance ₹2490
        
        lblAvBalance.text = "Available Balance ₹\(Common.shared.secondary_wallet_balance ?? "")"
        
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
        
        btnPay.setTitle("Pay ₹ \(priceStr)", for: .normal)

        lblTotalamount.text = "\(formatPriceWithRupeeSymbol(price: priceStr))"
        
        
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
        
    }
    
    
     func formatPriceWithRupeeSymbol(price: Int) -> String {
        // Format the price to 2 decimal places if needed
        let formattedPrice = String(price)
        
        // Concatenate the rupee symbol with the formatted price
        let priceWithRupeeSymbol = "₹\(formattedPrice)"
        
        return priceWithRupeeSymbol
    }
    
    
    @IBAction func btnWalletClicked(_ sender: UIButton) {
        
        
        
        sender.isSelected.toggle()
        updateButtonImage()
        
        
        
    }
    
    
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func btnPayClicked(_ sender: UIButton) {
        
        
        // RechargeBillSuccess
        
        //btnPay
        
        //  paymentMode = "WalletPay"
        
        if paymentMode != ""{
            
            PaymentProcess()
            
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
                
                paymentWalletDeductVM.PaymentDeductCall(skeyStr: "AVJQIdwn79iR0zlP0iKNKumME",deduct_amountStr: priceStr, categoryStr: "recharge")

//                circleView_Model.CircleZoneCall(skeyStr: "142418AgQWGaSEHXoQ58ae75c4")

                observeDeductApi()
                
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


        
    }
    
    
    
}


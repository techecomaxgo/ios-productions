//
//  TransferVC.swift
//  MaxPay
//
//  Created by Ios Developer on 19/02/24.
//

import UIKit
import OlivePayLibrary
import SwiftLoader
import MessageUI

class FavouriteTransferCell: UITableViewCell {
    
    @IBOutlet weak var lblTitleName: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblBankName: UILabel!
    @IBOutlet weak var btnMenu: UIButton!
    
}

class TransferVC: BaseVC {
    
    var accountDetails: AccountDetailsOnIIN?


    @IBOutlet weak var viewTextfieldEntryBg: UIView!
    @IBOutlet weak var viewFavouriteTableBg: UIView!
    
    @IBOutlet weak var btnTabNew: UIButton!
    @IBOutlet weak var btnTabFavourites: UIButton!
    @IBOutlet weak var btnTabSelf: UIButton!
    
    @IBOutlet weak var txtAccountHolderName: UITextField!
    @IBOutlet weak var txtAccountNumber: UITextField!
    @IBOutlet weak var txtAccountIfsc: UITextField!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtRemark: UITextField!
    
    @IBOutlet weak var lblAmountText: UILabel!
    @IBOutlet weak var btnAddToFavourite: UIButton!
    @IBOutlet weak var btnSendAction: UIButton!
    @IBOutlet weak var collVWCard: UICollectionView!
    @IBOutlet weak var tableFavourites: UITableView!
    @IBOutlet weak var btnAddAccount: UIButton!
    
    var sendOption = "" // bank / self
    private var cardsArr:[AccountDetailsOnIIN] = []
    var accountDetail: AccountDetailsOnIIN?
    var selectedCardIndex = -1
    private var checksumViewModel = SIMSelectionViewModel()
    var transId = ""
    var amtDecimal = ""
    var apiCallOption = ""
    open var beneficiaryList: [BeneficiaryListModel] = []
    var vpaToDelete = ""
    var selectedBeneIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        configuration()
        
        btnAddToFavourite.isHidden = true
        
        cardsArr = []
        
        if let decoded = Common.shared.myCards {
            do {
                let cardList: [AccountDetailsOnIIN] = try JSONDecoder().decode([AccountDetailsOnIIN].self, from: decoded)
                
                for card in cardList {
                    cardsArr.append(card)
//                    cardsArr.append(card)
                }
                
                if cardsArr.count > 0 {
//                    lblUpiStatus.text =  cardsArr.first?.status == "A" ? "ACTIVE" : "INACTIVE"
//                    lblUpiId.text =  cardsArr.first?.vpa ?? ""
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
        collVWCard.reloadData()

        
        
        if sendOption == "bank" {
//            setTabButtons(btnTabNew)
            btnTabsAction(btnTabNew)
        } else if sendOption == "self" {
//            setTabButtons(btnTabSelf)
            btnTabsAction(btnTabSelf)
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .spellOut
        lblAmountText.text = numberFormatter.string(from: (Double(txtAmount.text ?? "0") ?? 0.00) as NSNumber)?.capitalizingFirstLetter()

        txtAccountIfsc.autocapitalizationType = .allCharacters
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Fetch card array from user defaults
        
        
    }
    
    @IBAction func btnAddAccountAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "BhimUPVC") as! BhimUPVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTabsAction(_ sender: UIButton) {
        
        setTabButtons(sender)
        
        if sender.tag == 0 { // New
            
            viewTextfieldEntryBg.isHidden = false
            viewFavouriteTableBg.isHidden = true
            
            btnAddToFavourite.setTitle("Add to favorites", for: .normal)
            btnAddToFavourite.tag = 0
           // btnAddToFavourite.isHidden = false

            txtAccountHolderName.isEnabled = true
            txtAccountNumber.isEnabled = true
            txtAccountIfsc.isEnabled = true
            txtAmount.isEnabled = true
            
            btnAddAccount.isHidden = true
            
        } else if sender.tag == 1 { // Favourite

            listBeneficary()
            
            viewTextfieldEntryBg.isHidden = true
            viewFavouriteTableBg.isHidden = false

            btnAddToFavourite.setImage(UIImage(named: "toggle-on-button"), for: .normal)
            btnAddToFavourite.setTitle("Remove from favorites", for: .normal)
            btnAddToFavourite.tag = 1
            //btnAddToFavourite.isHidden = false
            
            btnAddAccount.isHidden = true
            
        } else if sender.tag == 2 { // Self
            
            if cardsArr.count > 1 {
                
                btnAddAccount.isHidden = true
                
                viewTextfieldEntryBg.isHidden = false
                viewFavouriteTableBg.isHidden = true

                txtAccountHolderName.isEnabled = false
                txtAccountNumber.isEnabled = false
                txtAccountIfsc.isEnabled = false
                txtAmount.isEnabled = true
                
               // btnAddToFavourite.isHidden = true

            } else {
                btnAddAccount.isHidden = false
                viewTextfieldEntryBg.isHidden = true
                viewFavouriteTableBg.isHidden = true
            }
            
            
            
            
        }
        
    }
    
    func setTabButtons(_ selectedButton: UIButton) {
        btnTabNew.backgroundColor = UIColor.clear
        btnTabNew.setTitleColor(UIColor(named: "card-number-color"), for: .normal)
        
        btnTabFavourites.backgroundColor = UIColor.clear
        btnTabFavourites.setTitleColor(UIColor(named: "card-number-color"), for: .normal)
        
        btnTabSelf.backgroundColor = UIColor.clear
        btnTabSelf.setTitleColor(UIColor(named: "card-number-color"), for: .normal)
        
        selectedButton.backgroundColor = UIColor.init(named: "primary-green")
        selectedButton.setTitleColor(UIColor(named: "white-color"), for: .normal)
    }
    
    @IBAction func btnAddToFavouriteAction(_ sender: UIButton) {
        
        if sender.tag == 0 {
            sender.tag = 1
            sender.setImage(UIImage(named: "toggle-on-button"), for: .normal)
        } else {
            sender.tag = 0
            sender.setImage(UIImage(named: "toggle-off-button"), for: .normal)
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in collVWCard.visibleCells {
            if let indexPath = collVWCard.indexPath(for: cell) {
                print(indexPath)
                
//                accountDetail = cardsArr[indexPath.row]
                
                
                
                
                
            }
            
        }
    }
    
//    func indexPathForPreferredFocusedView(in collectionView: UICollectionView) -> IndexPath? {
//        let center = collectionView.center
//
//        //The center of the view is a better point to use, but we can only use it if the view has a superview
//        guard let superview = view.superview else {
//            //The view we were passed does not have a valid superview.
//            //Use the view's bounds.origin and convert from the view's coordinate system
//            let origin = collectionView.convert(view.bounds.origin, from: view)
//            let indexPath = collectionView.indexPathForRow(at: origin)
//            return indexPath
//        }
//        let viewCenter = self.convert(center, from: superview)
//        let indexPath = self.indexPathForRow(at: viewCenter)
//        return indexPath
//    }
    
    @IBAction func btnSendAction(_ sender: Any) {
    
        if txtAccountHolderName.text == "" {
            self.showErrorAlert("Please enter account holder name")
            return
        } else if txtAccountNumber.text == "" {
            self.showErrorAlert("Please enter account number")
            return
        } else if txtAccountIfsc.text == "" {
            self.showErrorAlert("Please enter IFSC code")
            return
        } else if accountDetail == nil || selectedCardIndex == -1 {
            self.showErrorAlert("Please select account")
            return
        } else if txtAmount.text == "" {
            self.showErrorAlert("Please enter amount")
            return
        } else if MyBasics.validateAmount(txtAmount.text ?? "") {
            self.showErrorAlert("Please enter valid amount")
            return
        }
        
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        let accountDetail = AccountPay(name: accountDetail?.name ?? "", mmid: accountDetail?.mmid ?? "", aeba: accountDetail?.aeba ?? "", mbeba: accountDetail?.mbeba ?? "", accRefNumber: accountDetail?.accRefNumber ?? "", ifsc: accountDetail?.ifsc ?? "", maskedAccnumber: accountDetail?.maskedAccnumber ?? "", status: accountDetail?.status ?? "", type: accountDetail?.type ?? "", vpa: accountDetail?.vpa ?? "", dLength: accountDetail?.dLength ?? "", dType: accountDetail?.dType ?? "", balance: accountDetail?.balance ?? "", balTime: accountDetail?.balTime ?? "", accountIfsc: accountDetail?.ifsc ?? "",iin: accountDetails?.iin ?? "")
        var straccountDetail = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(accountDetail)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                straccountDetail = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }

        
        let vpa = (txtAccountNumber.text ?? "") + "@" + (txtAccountIfsc.text ?? "") + ".ifsc.npci"
        
      //  print(vpa)
        
        
        let beneVpa = BeneVpa(name: txtAccountHolderName.text ?? "", vpa: vpa, nickName: txtAccountHolderName.text ?? "")
        var strBeneVpa = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(beneVpa)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strBeneVpa = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }

        
        let x = Double(self.txtAmount.text ?? "0")
        amtDecimal = String(format: "%.2f", Double(round(100 * x!) / 100))
        
        let paymentInput = PaymentInput(amount: amtDecimal, merchantVpa: MerchantVpa, merchantId: MerchantId, submerchantid: SubMerchantId, merchantChannelId: MerchChanId, tranType: TranTypeP2P, mcc: "0000", remarks: txtRemark.text ?? "", initMode: "00", purpose: "00", refCategory: "00")
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

        apiCallOption = "pay"
        
       // DispatchQueue.global().async {
        
        ///VpaCallCheck after 2nd call
        
        
       // checkvpa(vpa: vpa)
    
        ///2ndCall

        DispatchQueue.global(qos: .background).async {

            print(strBeneVpa)
            
            // Working Properly
            
            OliveUpiManager.initiatePay(account: straccountDetail, benevpa: strBeneVpa, paymentInput: strPaymentInput, viewController: self) { data, error in
                
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                }
                
                if let err = error {
                    
                    if err.code == 102 || err.code == 108 { // Customer Accounts not found
                        DispatchQueue.main.async {
                            self.showErrorAlert(err.localizedDescription)
                        }
                    } else if err.code == 401 || err.code == 107 {
                        
                        DispatchQueue.main.async {
                            SwiftLoader.hide()

                            self.showErrorAlert(err.localizedDescription)
                        }
                        
                        self.configuration()
                        return
                        
                    }
                    
                  

                } else {
                    
                    if let dataResp = data {
                        
                        DispatchQueue.main.async {
                            
                            //SwiftLoader.hide()
                            
                        self.transId = dataResp as! String
                                                
                        if self.btnTabFavourites.tag == 1 { // Beneficary add - api call
                            self.saveBeneficary(dataResp: self.transId)
                            return
                        }
                        
                            
                            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "PaymentSuccessfulVC") as! PaymentSuccessfulVC
                            
                            vc.accountDetails = self.accountDetail
                            vc.beneVpa = vpa
                            vc.beneName = self.txtAccountHolderName.text!
                            vc.transId = self.transId
                            vc.amount = self.amtDecimal
                            vc.fromScreenOption = "pay"
                            vc.isFromBank = true
                            
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
            }
            
        }
        
    }
    
    
    func checkvpa(vpa: String) {
        let payerInfo = PayerInfo(accountnumber: txtAccountNumber.text ?? "", mcc: MCC, name: accountDetail?.name ?? "", payervpa: accountDetail?.vpa ?? "")
        
        var jsonToString = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(payerInfo)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                jsonToString = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }

        DispatchQueue.global(qos: .background).async {
            
            // Working properly
            OliveUpiManager.checkvpa(vpa: vpa, payerInfo: jsonToString) { data, error in
                
                if let err = error {
                    if err.code == 102 { // Customer Accounts not found / Timed Out
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
                    
//                    DispatchQueue.main.async {
//                        SwiftLoader.hide()
//
//                        let vc = UIStoryboard(name: "BhimUpi", bundle: nil).instantiateViewController(withIdentifier: "PaymentUPIIDNewVC") as! PaymentUPIIDNewVC
////                        vc.contactData = contact
//                        vc.accountDetails = self.accountDetails
//                        vc.beneVpa = vpa
//                        vc.beneName = data as? String ?? ""
//                        self.navigationController?.pushViewController(vc, animated: true)
//
//                    }
                }
            }
        }

    }
    
    func saveBeneficary(dataResp: String) {
        
        let vpa = (txtAccountNumber.text ?? "") + "@" + (txtAccountIfsc.text ?? "") + ".ifsc.npci"
        
        let beneVpa = BeneVpa(name: accountDetail?.name ?? "", vpa: vpa, nickName: txtAccountHolderName.text!)
        var strBeneVpa = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(beneVpa)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strBeneVpa = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }

        apiCallOption = "bene"
        
        DispatchQueue.global(qos: .background).async {
            
            // Manage Response
            OliveUpiManager.saveBeneVpa(bene: strBeneVpa) { data, error in
                    
                if let err = error {
                    
                    if err.code == 108 { // Customer Accounts not found
                        DispatchQueue.main.async {
                            self.showErrorAlert(err.localizedDescription)
                        }
                    } else if err.code == 102 { // VPA already exist!
                        
                        DispatchQueue.main.async {
                            self.showErrorAlert(err.localizedDescription)
                            
                            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "PaymentSuccessfulVC") as! PaymentSuccessfulVC
                            
                            vc.accountDetails = self.accountDetail
                            vc.beneVpa = vpa
                            vc.beneName = self.txtAccountNumber.text ?? ""
                            vc.transId = dataResp
                            vc.amount = self.amtDecimal
                            vc.fromScreenOption = "pay"

                            self.navigationController?.pushViewController(vc, animated: true)

                        }
                    } else if err.code == 401 || err.code == 107 {
                        
                        self.configuration()
                        return
                        
                    }
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                    }

                } else {
                    if let da = data {
                        
                        DispatchQueue.main.async {
                            SwiftLoader.hide()
                            self.showToast(message: "Beneficiary added Successfully")
                            
                            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "PaymentSuccessfulVC") as! PaymentSuccessfulVC
                            
                            vc.accountDetails = self.accountDetail
                            vc.beneVpa = vpa
                            vc.beneName = self.txtAccountNumber.text ?? ""
                            vc.transId = dataResp
                            vc.amount = "\(self.amtDecimal)"
                            vc.fromScreenOption = "pay"
                            
                            self.navigationController?.pushViewController(vc, animated: true)
                            
                        }
                    }
                }
            }
            
        }
    }
    
    func listBeneficary() {
        
        apiCallOption = "list"
        
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
                                self.tableFavourites.reloadData()
//                                self.lblNoData.isHidden = self.beneficiaryList.count != 0
                                SwiftLoader.hide()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func remopveBeneficary(vpa: String, index: Int) {
        
        apiCallOption = "rm"
        
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
                  //  print(data)
                        
//                    self.beneficiaryList.remove(at: index)
                    
                    self.listBeneficary()
                    
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        self.showToast(message: "Beneficary Removed Successfully")
                        self.tableFavourites.reloadData()
//                        self.lblNoData.isHidden = self.beneficiaryList.count != 0
                    }
                }
            }
            
        }
    }
}

extension TransferVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let finalText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if textField == txtAmount {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .spellOut
            lblAmountText.text = numberFormatter.string(from: (Double(finalText) ?? 0.00) as NSNumber)?.capitalizingFirstLetter()
        }
//        else if textField == txtAccountIfsc {
//
//        }
        
        return true

    }
}

extension TransferVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsArr.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollViewCardCell", for: indexPath) as! CollViewCardCell
        cell.setValues(accountDetailsOnIIN: cardsArr[indexPath.item])
        cell.imgCardBg.image = indexPath.row == 0 ? UIImage(named: "my-card-ic") : UIImage(named: "my-card2-ic")
        cell.lblSelected.isHidden = !(selectedCardIndex == indexPath.row)
        return cell
    }
    
//    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        accountDetail = cardsArr[indexPath.row]
        selectedCardIndex = indexPath.row
        collVWCard.reloadData()
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collVWCard.frame.width/1.2, height: self.collVWCard.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

extension TransferVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beneficiaryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteTransferCell") as! FavouriteTransferCell
        
        cell.lblName.text = beneficiaryList[indexPath.row].name
        
        cell.btnMenu.tag = indexPath.row
        cell.btnMenu.addTarget(self, action: #selector(btnMenuAction(_:)), for: .touchUpInside)

        let stringInputArr = (beneficiaryList[indexPath.row].name ?? "").components(separatedBy:" ")
        var stringNeed = ""

        for string in stringInputArr {
            stringNeed += String(string.first!)
        }
        cell.lblTitleName.text = stringNeed
        
        cell.lblBankName.text = beneficiaryList[indexPath.row].vpa
        
        cell.selectionStyle = .none

        return cell
    }
    
    @objc func btnMenuAction(_ sender: UIButton) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Remove", style: .default, handler: { (action) in
            self.removeBene(sender)
        }))
        
        alert.addAction(UIAlertAction(title: "Pay" , style: .default, handler: { (action) in
            
            if self.selectedCardIndex == -1 {
                self.showErrorAlert("Please select account")
                return
            }
            
            DispatchQueue.main.async {
                let vc = UIStoryboard(name: "BhimUpi", bundle: nil).instantiateViewController(withIdentifier: "PaymentUPIIDNewVC") as! PaymentUPIIDNewVC
                vc.accountDetails = self.accountDetail
                vc.beneVpa = self.beneficiaryList[sender.tag].vpa ?? ""
                vc.beneName = self.beneficiaryList[sender.tag].name ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(_: UIAlertAction!) in
        }))
        
        self.present(alert, animated: true, completion: nil)

    }
    
    func removeBene(_ sender: UIButton) {
        // indexpath of arr
        
        showAlertMessageWithActionButton(title: "MaxUPI", message: "Are you sure you want to remove Beneficiary?", actionButtonText: "Ok", cancelActionButtonText: "Cancel", vc: self) { status in
            if status == 1 {
                
                self.vpaToDelete = self.beneficiaryList[sender.tag].vpa ?? ""
                self.remopveBeneficary(vpa: self.vpaToDelete, index: self.selectedBeneIndex)
                
            }
        }
        
    }
    
    
}

extension TransferVC: MFMessageComposeViewControllerDelegate {
    
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
            if self.apiCallOption == "pay" {
                self.btnSendAction(UIButton())
            } else if self.apiCallOption == "bene" {
                self.saveBeneficary(dataResp: self.transId)
            } else if self.apiCallOption == "list" {
                self.listBeneficary()
            } else if self.apiCallOption == "rm" {
                self.remopveBeneficary(vpa: self.vpaToDelete, index: self.selectedBeneIndex)
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
                }else{
                    if self.apiCallOption == "pay" {
                        self.btnSendAction(UIButton())
                    } else if self.apiCallOption == "bene" {
                        self.saveBeneficary(dataResp: self.transId)
                    } else if self.apiCallOption == "list" {
                        self.listBeneficary()
                    } else if self.apiCallOption == "rm" {
                        self.remopveBeneficary(vpa: self.vpaToDelete, index: self.selectedBeneIndex)
                    }
                }
            })
            break
        default:
            break
        }
    }
}


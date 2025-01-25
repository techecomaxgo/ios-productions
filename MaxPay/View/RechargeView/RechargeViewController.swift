//
//  RechargeViewController.swift
//  MaxPay
//
//  Created by Ios Developer on 15/05/24.
//

import UIKit
import MessageUI
import Contacts
import SwiftLoader
import OlivePayLibrary




class RechargeViewController: BaseVC {
    
    
    @IBOutlet weak var lblMyNumConstant: NSLayoutConstraint!
    
    @IBOutlet weak var lblMynumNameConst: NSLayoutConstraint!
    
    @IBOutlet weak var cardConstantHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var lblCustomerMobile: UILabel!
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var viewTableBack: UIView!
    
    @IBOutlet weak var tableContacts: UITableView!

    @IBOutlet weak var textfieldSearch: UITextField!

    var contactList: [ContactDetail] = []
    
    var filteredContactList: [ContactDetail] = []
    var arrRecentContactList: [ContactDetail] = []
    
    var accountDetails: AccountDetailsOnIIN?
    
    private var checksumViewModel = SIMSelectionViewModel()

    
    var enteredNumber: String?

    @IBOutlet weak var lblTitleContacts: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewTableBack.layer.applyCornerRadiusShadow()
        
        fetchContacts()
        
        setUIData()
        
        textfieldSearch.delegate = self
        
        
        lblMyNumConstant.constant = 20
        
        lblMynumNameConst.constant = 50
        
        cardConstantHeight.constant = 50
    }
    
    func setUIData(){
        lblCustomerMobile.text = "\(Common.shared.phoneNo ?? "")"
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true


    }
    
    
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)

        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    
    func fetchContacts() {
        
        let store = CNContactStore()
        
        SwiftLoader.show(animated: true)
        
        store.requestAccess(for: .contacts) { (granted, error) in
            if granted {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactThumbnailImageDataKey] as [CNKeyDescriptor]
                let request = CNContactFetchRequest(keysToFetch: keys)

                DispatchQueue.global().async {
                    do {
                        try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                            // Process each contact

//                            var arrContacts = [String]()
                            
                            for phoneNumber in contact.phoneNumbers {
//                                arrContacts.append("\(phoneNumber.value.stringValue)")
                                
                                let contactDetail = ContactDetail(contactName: "\(contact.givenName) \(contact.familyName)", contactNumbers: phoneNumber.value.stringValue, thumbnailImageData: contact.thumbnailImageData)
                                
                                if contactDetail.contactName?.count != nil {
                                    self.contactList.append(contactDetail)
                                    self.filteredContactList.append(contactDetail)
                                }
                                
                            }
//                            let strContacts = arrContacts.joined(separator: ", ")
                            
                            print("My contactList:",self.contactList)
                            print("My filteredContactList:",self.filteredContactList)
                            
                        })
                        DispatchQueue.main.async {
                            self.tableContacts.reloadData()
                            SwiftLoader.hide()
                        }
                        
                    } catch {
                        print("Failed to fetch contacts: \(error.localizedDescription)")
                        DispatchQueue.main.async {
                            SwiftLoader.hide()
                        }
                    }
                }
            } else {
                print("Access to contacts not granted")
            }
        }
    }
    
    
    func checkvpa(vpa: String) {
        
        let payerInfo = PayerInfo(accountnumber: accountDetails?.accRefNumber, mcc: MCC, name: accountDetails?.name, payervpa: accountDetails?.vpa)
        
        var jsonToString = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(payerInfo)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
               // print(jsonString)
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
                        //return
                    }
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                    }
                } else {
                    
                  //  print(data)
                    
                    if let dt = data {
                        
                        if let data = SendMoneyVC.convertToData(dt) {
                            do {
                                
                               // print(data)
                                //let beneficiaryList = try JSONDecoder().decode([MandateListModel].self, from: data)
                                
//                                for beneficiary in beneficiaryList {
//                                    self.mandateListArr.append(beneficiary)
//                                }
                                
                            } catch {
                                print(error.localizedDescription)
                            }
                            
//                            DispatchQueue.main.async {
//                                self.tableViewMandate.reloadData()
//                                self.lblNoDataAvailable.isHidden = self.mandateListArr.count != 0
//                                SwiftLoader.hide()
//
//                            }
//
                        }
                    }
                    
                    
                    
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        
                        let vc = UIStoryboard(name: "BhimUpi", bundle: nil).instantiateViewController(withIdentifier: "PaymentUPIIDNewVC") as! PaymentUPIIDNewVC
//                        vc.contactData = contact
                        vc.accountDetails = self.accountDetails
                        vc.beneVpa = vpa
                        vc.beneName = data as? String ?? ""
                        self.navigationController?.pushViewController(vc, animated: true)
                                                
                    }
                }
            }
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



extension RechargeViewController: MFMessageComposeViewControllerDelegate {
    
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
              //  print("Data loaded...")
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
           // print("The data is:\(String(describing: data))")
            DispatchQueue.main.async {
                self.checkvpa(vpa: self.textfieldSearch.text ?? "")
            }
        }
    }
    
    public func messageComposeViewController(_ controller: MFMessageComposeViewController,didFinishWith didFinishWithresult: MessageComposeResult) {
        controller.dismiss(animated: true, completion: {})
        switch didFinishWithresult {
        case .cancelled:
            print("Cancelled")
        case .sent:
           // print("Message Sent")
            OliveUpiManager.sendMobileBindReqst(callback: { (data, err) in
                if let er = err{
                   // print(er)
                    DispatchQueue.main.async {
                        self.showToast(message: "SMS Sent failed", font: .systemFont(ofSize: 12))
                        SwiftLoader.hide()
                    }
                }else{
                    self.checkvpa(vpa: self.textfieldSearch.text!)
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


extension RechargeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return filteredContactList.count
        
        return filteredContactList.count + (enteredNumber != nil ? 1 : 0)

        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell") as! ContactsTableViewCell
        
        
        
        if indexPath.row < filteredContactList.count {
                                
            let contact = filteredContactList[indexPath.row]
            
            cell.lblName.text = contact.contactName
            cell.lblMobileOrUpi.text = contact.contactNumbers
            
            if let imageData = contact.thumbnailImageData {
                cell.imgContact.image = UIImage(data: imageData)
            } else {
                // Set a placeholder image if no contact image is available
                cell.imgContact.image = UIImage(named: "me_profile")
            }
            
            
                } else if let enteredNumber = enteredNumber {
                    
                    
//                    lblTitleContacts.text = "New Number"
                    
                    cell.lblName.text = enteredNumber

                    cell.lblMobileOrUpi?.text = ""
                }
        
        
        
        
        return cell
    }
    
    
    // Assuming you have a method to handle the entry of a new number
      @IBAction func didEnterNewNumber(_ sender: UITextField) {
          
          if let newNumber = sender.text, !newNumber.isEmpty {
              enteredNumber = newNumber
              
              if enteredNumber == nil {
                  
                  lblTitleContacts.text = "My Contacts"
                  
                  lblMyNumConstant.constant = 20
                  
                  lblMynumNameConst.constant = 50
                  
                  cardConstantHeight.constant = 50

                  
              }else{
                  
                  lblTitleContacts.text = "New Number"
                  
                  lblMyNumConstant.constant = 0
                  
                  lblMynumNameConst.constant = 0
                  
                  cardConstantHeight.constant = 0

                  
              }
              
              tableContacts.reloadData()

              
          }
      }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        textfieldSearch.resignFirstResponder()
       
        if indexPath.row < filteredContactList.count {
            
        let contact = filteredContactList[indexPath.row]
        
        if arrRecentContactList.count > 5 {
            arrRecentContactList.removeLast()
        }
        arrRecentContactList.insert(contact, at: 0)
        
        // Save cards to NSUserDefaults
        do {
            let contactData = try JSONEncoder().encode(arrRecentContactList)
            Common.shared.recentContacts = contactData
        } catch {
            print(error.localizedDescription)
        }
        
        // RechargePlanViewController
        
        let vc = UIStoryboard(name: "USP", bundle: nil).instantiateViewController(withIdentifier: "RechargePlanViewController") as! RechargePlanViewController
        vc.contactNo = contact.contactNumbers ?? ""
        // vc.skeyStr = accountDetails
        self.navigationController?.pushViewController(vc, animated: true)
        }else{
            
            
            let vc = UIStoryboard(name: "USP", bundle: nil).instantiateViewController(withIdentifier: "RechargePlanViewController") as! RechargePlanViewController
            vc.contactNo = enteredNumber ?? ""
            // vc.skeyStr = accountDetails
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
       
        
    }
    
    
    
    static func convertToData(_ object: Any) -> Data? {
        if let data = object as? Data {
            // If object is already Data, no conversion needed
            return data
        } else if let string = object as? String {
            // If object is String, convert it to Data using UTF-8 encoding
            return string.data(using: .utf8)
        } else if let number = object as? NSNumber {
            // If object is NSNumber, convert it to Data
            return number.stringValue.data(using: .utf8)
        } else if let array = object as? [Any] {
            // If object is an array, convert it to Data using JSONSerialization
            do {
                return try JSONSerialization.data(withJSONObject: array)
            } catch {
                print("Error converting array to Data: \(error)")
                return nil
            }
        } else if let dictionary = object as? [String: Any] {
            // If object is a dictionary, convert it to Data using JSONSerialization
            do {
                return try JSONSerialization.data(withJSONObject: dictionary)
            } catch {
                print("Error converting dictionary to Data: \(error)")
                return nil
            }
        }

        // Handle other cases or return nil if the type is not supported
        print("Unsupported type for conversion to Data")
        return nil
    }
    
    
}

extension RechargeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrRecentContactList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SendMoneyCollectionCell", for: indexPath) as! SendMoneyCollectionCell
        
        cell.lblName.text = arrRecentContactList[indexPath.row].contactName
        
        if let imageData = arrRecentContactList[indexPath.row].thumbnailImageData {
            cell.imgContact.image = UIImage(data: imageData)
        } else {
            // Set a placeholder image if no contact image is available
            cell.imgContact.image = UIImage(named: "me_profile")
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        textfieldSearch.resignFirstResponder()
        
        let vc = UIStoryboard(name: "BhimUpi", bundle: nil).instantiateViewController(withIdentifier: "PaymentUPIIDNewVC") as! PaymentUPIIDNewVC
        vc.contactData = arrRecentContactList[indexPath.row]
        vc.accountDetails = accountDetails
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension RechargeViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let searchText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        filterContentForSearchText(searchText)
        return true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        
        
        if  isPhoneNumber(searchText) {
                
                if searchText.isEmpty {
                    // If the search text is blank, use the original data
                    filteredContactList = contactList
                    
                } else {
                    
                    filteredContactList = contactList.filter { category in
                        if let contactName = category.contactNumbers {
                            return contactName.lowercased().contains(searchText.lowercased())
                        } else {
                            return false
                        }
                    }
                }
                
                // Sort the filtered array based on categoryName
                filteredContactList.sort { $0.contactNumbers! < $1.contactNumbers! }
            } else if isName(text: searchText) {
                
                
                if searchText.isEmpty {
                    // If the search text is blank, use the original data
                    filteredContactList = contactList
                } else {
                    
                    filteredContactList = contactList.filter { category in
                        if let contactName = category.contactName {
                            return contactName.lowercased().contains(searchText.lowercased())
                        } else {
                            return false
                        }
                    }
                }
                
                // Sort the filtered array based on categoryName
                filteredContactList.sort { $0.contactName! < $1.contactName! }
            } else {
                
              //  print("Input is neither a phone number nor a name.")
                
                if searchText.isEmpty {
                    // If the search text is blank, use the original data
                    filteredContactList = contactList
                } else {
                    
                    filteredContactList = contactList.filter { category in
                        if let contactName = category.contactNumbers {
                            return contactName.lowercased().contains(searchText.lowercased())
                        } else {
                            return false
                        }
                    }
                }
                
                // Sort the filtered array based on categoryName
                filteredContactList.sort { $0.contactNumbers! < $1.contactNumbers! }
                
                
            }
        
       // print(self.contactList)
      //  print(self.filteredContactList)
        
        print("My filteredContact count List:",self.filteredContactList.count)
        print("arrRecentContactList :",arrRecentContactList.count)
        
        
        if self.filteredContactList.count > 0 {
            
            lblTitleContacts.text = "My Contacts"
            
            lblMyNumConstant.constant = 20
            
            lblMynumNameConst.constant = 50
            
            cardConstantHeight.constant = 50

            
        }else{
            
            lblTitleContacts.text = "New Number"
            
            lblMyNumConstant.constant = 0
            
            lblMynumNameConst.constant = 0
            
            cardConstantHeight.constant = 0

            
        }
       
        
        tableContacts.reloadData()
        
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        filteredContactList = contactList
        tableContacts.reloadData()
        return true
    }
    
    
    
    func isPhoneNumber(_ text: String) -> Bool {
        let phoneNumberRegex = "^(\\+\\d{1,3}[- ]?)?\\(?\\d{3}\\)?[-. ]?\\d{3}[-. ]?\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        return phoneTest.evaluate(with: text)
    }
    
    
    func isName(text: String) -> Bool {
        let nameRegex = "^[a-zA-Z]+(?: [a-zA-Z]+)*$"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return nameTest.evaluate(with: text)
    }

    
    
}

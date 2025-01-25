//
//  SendMoneyVC.swift
//  MaxPay
//
//  Created by Ios Developer on 17/02/24.
//

import UIKit
import Contacts
import SwiftLoader
import OlivePayLibrary
import MessageUI

struct ContactDetail: Codable {
    let contactName: String?
    let contactNumbers: String?
    let thumbnailImageData: Data?
    
    enum CodingKeys: CodingKey {
        case contactName
        case contactNumbers
        case thumbnailImageData
    }
}

class SendMoneyTableCell: UITableViewCell {
    
   
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMobileOrUpi: UILabel!
    @IBOutlet weak var imgContact: UIImageView!
}

class SendMoneyCollectionCell: UICollectionViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgContact: UIImageView!
}

class SendMoneyVC: BaseVC {

    var contactList: [ContactDetail] = []
    var filteredContactList: [ContactDetail] = []
    var arrRecentContactList: [ContactDetail] = []
    
    var accountDetails: AccountDetailsOnIIN?
    
    private var checksumViewModel = SIMSelectionViewModel()

    @IBOutlet weak var tableContacts: UITableView!
    @IBOutlet weak var collectionRecentCOntacts: UICollectionView!
    @IBOutlet weak var lblRecentContact: UILabel!
    @IBOutlet weak var textfieldSearch: UITextField!
    
    //var dataDictVpa : Dictionary?
    
    var mcccodeStr = ""
    var beneNameStr = ""
    
    var mccUserMCCCode = "0000"
    
    var extractedVPA: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(accountDetails)
        fetchContacts()
        tableContacts.delegate = self
        tableContacts.dataSource = self
        self.tableContacts.reloadData()

        arrRecentContactList = []
        // Fetch card array from user defaults
        if let decoded = Common.shared.recentContacts {
            do {
                let contactList: [ContactDetail] = try JSONDecoder().decode([ContactDetail].self, from: decoded)
                for contact in contactList {
                    arrRecentContactList.append(contact)
                }
                self.collectionRecentCOntacts.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
        
        
    }
    
    
    
    
    // api of check vpa
    
    func checkvpa(vpa: String) {
        
        let payerInfo = PayerInfo(accountnumber: accountDetails?.accRefNumber, mcc: mccUserMCCCode, name: accountDetails?.name, payervpa: accountDetails?.vpa)
        
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
                    
                    print("data is received to ======>> ",data)
                    
                    
//                    if let dataDict = data as? [String: Any] {
//                            // Extract and print the VPA
//                            if let vpa = dataDict["vpa"] as? String {
//                                print("Extracted VPA: \(vpa)")
//                            } else {
//                                print("VPA key not found or not a String")
//                            }
//                        } else {
//                            print("Failed to cast data to [String: Any]")
//                        }
                    
                    
                    if let dataDict = data as? [String: Any] {
                        if let vpa = dataDict["vpa"] as? String {
                            self.extractedVPA = vpa
                            print("Extracted VPA: \(vpa)")
                        } else {
                            print("VPA key not found or not a String")
                        }
                    } else {
                        print("Failed to cast data to [String: Any]")
                    }
                  
                    
                    
         
                    if let dt = data {
                        if let dataDictAll = self.convertToSomeAnyData(data) {

                           print("datadict all the data ===========>>> ",dataDictAll)
                            
                          
                            
            
                        }
                        
                        if let data = SendMoneyVC.convertToData(dt) {
                            do {
                                
                                print("data 2 is received ===========>> ",data)
                                
                            } catch {
                                
                                print(error.localizedDescription)
                            }

                        }}
                    
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        let vc = UIStoryboard(name: "BhimUpi", bundle: nil).instantiateViewController(withIdentifier: "PaymentUPIIDNewVC") as! PaymentUPIIDNewVC
                        vc.accountDetails = self.accountDetails
                        vc.beneVpa = vpa
                        //extra fied to pass vpa
                        vc.beneVpa = self.extractedVPA ?? vpa
                        vc.beneName = self.beneNameStr
                        vc.mccCodeDNewVC = self.mcccodeStr
                        self.navigationController?.pushViewController(vc, animated: true)
                                                
                    }
                }
            }

            
        }

    }
    

    
    
    // Function to extract mcccode
    func getMccCode(from dictionary: [String: Any]) -> Int? {
        // Safely unwrap and extract the mcccode
        if let mccCode = dictionary["mcccode"] as? Int {
            return mccCode
        } else {
            return nil
        }
    }
    
    
     func convertToSomeAnyData(_ object: Any) -> Data? {
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
            
           // dataDictVpa = dictionary
            
            mcccodeStr = dictionary["mcccode"] as? String ?? ""
            //print(dictionary["mcccode"] as? String)
            
            beneNameStr = dictionary["data"] as? String ?? ""
            
            print(mcccodeStr)
            
            
            
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
    
    
    
    func convertToAllVpaData(_ object: Any) -> Data? {
        
        if let dictionary = object as? [String: Any] {
           // If object is a dictionary, convert it to Data using JSONSerialization
           do {
               return try JSONSerialization.data(withJSONObject: dictionary)
           } catch {
               print("Error converting dictionary to Data: \(error)")
               return nil
           }
       }
        
        return nil

        
    }
    
    func validateUPIID1(_ upiID: String) -> Bool {
        let validCharacterSet = CharacterSet(charactersIn: "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.-@")
        
        if upiID.isEmpty {
            self.showErrorAlert("Please Enter UPI ID")
            return false
        } else if upiID.count <= 3 || upiID.count > 99 || (upiID.rangeOfCharacter(from: validCharacterSet.inverted) != nil) || !upiID.contains(where: { $0 == "@" }) {
            self.showErrorAlert("Please Enter Valid UPI ID")
            return false
        } else if upiID.count >= 10 && isNumeric(upiID) {
            if upiID == Common.shared.phoneNo {
                self.showErrorAlert("You can't set vpa as  number")
                return false
            }
        }
        
        return true
    }
    
    func isNumeric(_ vpa: String) -> Bool {
        let numericCharacterSet = CharacterSet.decimalDigits
        return vpa.rangeOfCharacter(from: numericCharacterSet.inverted) == nil
    }
    
    @IBAction func btnVerifyAction(_ sender: Any) {
//        if textfieldSearch.text != "" && validateUPIID1(textfieldSearch.text!){
//            checkvpa(vpa: textfieldSearch.text!)
//        }else{
//            self.showErrorAlert("Please enter valid UPI ID.")
//        }

        guard let text = textfieldSearch.text, !text.isEmpty else {
            showErrorAlert("Please enter a valid UPI ID.")
            return
        }
        
        
        
        
        if validateUPIID(text) {
           // checkvpa(vpa: text)
            checkvpa(vpa: textfieldSearch.text!)
        } else {
            showErrorAlert("Please enter a valid UPI ID.")
        }
    }
    
    
    func validateUPIID(_ text: String) -> Bool {
        // Check if the text contains '@'
//        if text.contains("@") {
//            let components = text.split(separator: "@")
//            
//            // Ensure there's exactly one '@' and no numbers after '@'
//            if components.count == 2, let partAfterAt = components.last, partAfterAt.rangeOfCharacter(from: .decimalDigits) == nil {
//                return true
//            } 
//            else {
//                showErrorAlert("UPI ID should not have numbers after '@'.")
//                return false
//            }
//        }
//        
        
        
        
//        if text.contains("@") {
//            let components = text.split(separator: "@")
//            
//            // Ensure there's exactly one '@' and no numbers after '@'
//            if components.count == 2,
//               let partBeforeAt = components.first,
//               let partAfterAt = components.last,
//               partBeforeAt.rangeOfCharacter(from: .decimalDigits) != nil, // Allow numbers before '@'
//               partAfterAt.rangeOfCharacter(from: .decimalDigits) == nil { // No numbers after '@'
//                return true
//            } else {
//                showErrorAlert("UPI ID should not have numbers after '@'.")
//                return false
//            }
//        }
        
        
       
        
        if text.contains("@") {
            let components = text.split(separator: "@")
            
            // Ensure there's exactly one '@'
            if components.count == 2 {
                return true
            } else {
                showErrorAlert("Invalid UPI ID format.")
                return false
            }
        }


        
        
        // Normalize the text
        var normalizedText = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        // Validate based on normalized text length
        if normalizedText.count == 10 {
            if normalizedText == getUserMobileNum() {
                showErrorAlert("You cannot pay to your own mobile number.")
                return false
            }
            return true
        } else if normalizedText.count > 10 && normalizedText.hasPrefix("91") {
            normalizedText = String(normalizedText.dropFirst(2))
            return normalizedText.count == 10
        } else if normalizedText.count == 9 || normalizedText.count == 8 {
            return true
        } else {
            return false
        }
    }

    override func showErrorAlert(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
   

    func getUserMobileNum() -> String {
        // Implement your logic to get the user's mobile number
        return "1234567890" // Example placeholder
    }
    
    
    
    
//    func setBeneVPA(vpa: String?, beneName: String, nickName: String?) {
//           print("setBeneVPA: vpa \(vpa ?? "nil")")
//
//           do {
//               ld.show()
//               ld.isCancelable = false
//               if let vpa = vpa, !vpa.isEmpty {
//                   let safeNickName = nickName ?? ""
//                   print("saveBeneVPA Req:  vpa \(vpa) beneName \(beneName) nickName \(safeNickName)")
//                   OliveUpiManager.shared.savevpa(vpa: vpa, beneName: beneName, nickName: safeNickName)
//               }
//           } catch {
//               // Handle exception
//           }
//       }
   
    
    
    
    
//    func checkAndVerifyVPA(upii: String) {
//        do {
//            if !upii.isEmpty {
//                let payerInfo = PayerInfo()
//                payerInfo.accountnumber = Upi.getPrimaryAccount().accRefNumber
//                payerInfo.payervpa = Upi.getPrimaryAccount().vpa
//                payerInfo.name = Upi.getPrimaryAccount().name
//                payerInfo.mcc = "0000"
//                OliveUpiManager.shared.checkvpa(upii: upii, payerInfo: payerInfo)
//            }
//        } catch {
//            print(error)
//        }
//    }
 
    
  
    
    
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true

        
        self.collectionRecentCOntacts.isHidden = self.arrRecentContactList.count <= 0
        self.lblRecentContact.isHidden = self.arrRecentContactList.count <= 0
//                    self.constraintFavouriteCollectionBottom.constant = self.favouriteCategories.count <= 0 ? 0 : 20
        self.collectionRecentCOntacts.reloadData()
        self.collectionRecentCOntacts.layoutIfNeeded()
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        

    }
    
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = false

        self.navigationController?.popViewController(animated: true)
    }

//    
//    func fetchContacts() {
//        let store = CNContactStore()
//        
//        SwiftLoader.show(animated: true)
//        
//        store.requestAccess(for: .contacts) { (granted, error) in
//            if granted {
//                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactThumbnailImageDataKey] as [CNKeyDescriptor]
//                let request = CNContactFetchRequest(keysToFetch: keys)
//
//                DispatchQueue.global().async {
//                    do {
//                        try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
//                            // Process each contact
//
////                            var arrContacts = [String]()
//                            
//                            for phoneNumber in contact.phoneNumbers {
////                                arrContacts.append("\(phoneNumber.value.stringValue)")
//                                
//                                let contactDetail = ContactDetail(contactName: "\(contact.givenName) \(contact.familyName)", contactNumbers: phoneNumber.value.stringValue, thumbnailImageData: contact.thumbnailImageData)
//                                print("Contact fetched: \(contactDetail)")
//                                
//                                
//
//                                
//                                if contactDetail != nil {
//                                    self.contactList.append(contactDetail)
//                                    self.filteredContactList.append(contactDetail)
//                                    print("Contact fetched: \(contactDetail)")
//
//                                }
//                                
//                            }
////                            let strContacts = arrContacts.joined(separator: ", ")
//                            
//                        })
//                        DispatchQueue.main.async {
//                            self.tableContacts.reloadData()
//                            SwiftLoader.hide()
//                           
//
//                        }
//                        
//                    } catch {
//                        print("Failed to fetch contacts: \(error.localizedDescription)")
//                        DispatchQueue.main.async {
//                            SwiftLoader.hide()
//                        }
//                    }
//                }
//            } else {
//                print("Access to contacts not granted")
//            }
//        }
//    }
    
    
    
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
                                
                             

                                
                                if contactDetail != nil {
                                    self.contactList.append(contactDetail)
                                    self.filteredContactList.append(contactDetail)
                                }
                                
                            }
//                            let strContacts = arrContacts.joined(separator: ", ")
                            
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

}

extension SendMoneyVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SendMoneyTableCell") as! SendMoneyTableCell
        
        let contact = filteredContactList[indexPath.row]
        
        cell.lblName.text = contact.contactName
        cell.lblMobileOrUpi.text = contact.contactNumbers
        
        if let imageData = contact.thumbnailImageData {
            cell.imgContact.image = UIImage(data: imageData)
        } else {
            // Set a placeholder image if no contact image is available
            cell.imgContact.image = UIImage(named: "me_profile")
        }
        
        return cell
    }
    
    
    
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        textfieldSearch.resignFirstResponder()
//        
//        let contact = filteredContactList[indexPath.row]
//        
//        if arrRecentContactList.count > 5 {
//            arrRecentContactList.removeLast()
//        }
//        arrRecentContactList.insert(contact, at: 0)
//        
//        // Save cards to NSUserDefaults
//        do {
//            let contactData = try JSONEncoder().encode(arrRecentContactList)
//            Common.shared.recentContacts = contactData
//        } catch {
//            print(error.localizedDescription)
//        }
//        
//        let vc = UIStoryboard(name: "BhimUpi", bundle: nil).instantiateViewController(withIdentifier: "PaymentUPIIDNewVC") as! PaymentUPIIDNewVC
//        vc.contactData = contact
//        
//        print("contact ========??", vc.contactData = contact)
//        vc.accountDetails = accountDetails
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        textfieldSearch.resignFirstResponder()
        
        let contact = filteredContactList[indexPath.row]
        
        if arrRecentContactList.count > 5 {
            arrRecentContactList.removeLast()
        }
        arrRecentContactList.insert(contact, at: 0)
        
        // Save contacts to UserDefaults
        do {
            let contactData = try JSONEncoder().encode(arrRecentContactList)
            Common.shared.recentContacts = contactData
        } catch {
            print(error.localizedDescription)
        }
        
        // Extract the contact number and remove spaces
        let contactNumber = contact.contactNumbers?.replacingOccurrences(of: " ", with: "")
        
        // Instantiate PaymentUPIIDNewVC and pass the contact number
        let vc = UIStoryboard(name: "BhimUpi", bundle: nil).instantiateViewController(withIdentifier: "PaymentUPIIDNewVC") as! PaymentUPIIDNewVC
        vc.contactNumber = contactNumber  // Set the contact number in the destination VC
        
        print("Contact Number passed to PaymentUPIIDNewVC: \(String(describing: contactNumber))")
        
        vc.accountDetails = accountDetails
        self.navigationController?.pushViewController(vc, animated: true)
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
            
            print(dictionary)
            
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

extension SendMoneyVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
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

extension SendMoneyVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let searchText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        filterContentForSearchText(searchText)
        return true
    }
    
    func filterContentForSearchText(_ searchText: String) {
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
        
        tableContacts.reloadData()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        filteredContactList = contactList
        tableContacts.reloadData()
        return true
    }
}

extension SendMoneyVC: MFMessageComposeViewControllerDelegate {
    
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
            print("Message Sent")
            OliveUpiManager.sendMobileBindReqst(callback: { (data, err) in
                if let er = err{
                    print(er)
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


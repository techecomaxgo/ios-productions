//
//  PaymentUPIIDNewVC.swift
//  MaxPay
//
//  Created by india on 13/11/23.
//

import UIKit
import OlivePayLibrary
import SwiftLoader
import MessageUI
import AVFoundation

class PaymentUPIIDNewVC: BaseVC, AVAudioPlayerDelegate {
    
    var mccCodeDNewVC = ""
    
    
    var qrData = [String:Any]()
    
    var amStr = ""
    var amdigit : Double?
    var vpaUpdate = ""
    var mamStr = ""
    var mamDigit : Double?
    
    var contactNumber: String?
    
    //var amountlimit : Double?
    
    var minValue : Double?
    
    var maxValue : Double?
    var amountlimit :Double?

    var contactData: ContactDetail?
    var accountDetails: AccountDetailsOnIIN?
    var beneVpa = ""
    var beneName = ""
    var apiCallOption = ""
    var transId = ""
    private var checksumViewModel = SIMSelectionViewModel()
    var isFromRequestScreen = false
    var isFromQrScan = false
    var amtDecimal = ""
    var player: AVPlayer?
    var lastPlayTime: Date?

    @IBOutlet weak var viewTextNameBg: UIView!
    @IBOutlet weak var viewBeneficiaryBg: UIView!
    @IBOutlet weak var imgContact: UIImageView!
    @IBOutlet weak var lblUpiId: UILabel!
    @IBOutlet weak var lblCheckBalance: UILabel!
    
    @IBOutlet weak var lblFromName: UILabel!
    @IBOutlet weak var lblAccountType: UILabel!
    @IBOutlet weak var lblUpiId21: UILabel!
    @IBOutlet weak var lblRegisteredName: UILabel!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtRemark: UITextField!
    
    @IBOutlet weak var imgCheckUncheck: UIImageView!
    @IBOutlet weak var btnAddBeneficiary: UIButton!
    var audioPlayer: AVAudioPlayer!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        print("beneVpa ========",beneVpa)
//        
//        if let number = contactNumber {
//                  print("Received contact number: \(number)")
//                  // Use the contact number
//              }
//        
//      //  data["pa"] as! String
//        //print(qrData["pa"] as! String)
//        
//        
//        
////        print(qrData)
////
////        print("MAM :",qrData["mam"] as? String ?? "")
////        print("AM :",qrData["am"] as? String ?? "")
//
//        
//        if qrData["mam"] != nil && qrData["am"] != nil {
//            
//            
//            if isFromQrScan == true {
//                
//                setValues(scandata: qrData)
//                amountlimit = 100000
//                minValue = 0
//
//
//            }else{
//                
//                amountlimit = 100000
//                minValue = 0
//
//                
//            }
//            
//            
//        }else{
//            
//            amountlimit = 100000
//            minValue = 0
//            txtRemark.isEnabled = true
//
//            
//        }
//        
//        
//        
//        
//        checkvpa(vpa: beneVpa)
//        
//        lblUpiId.text = accountDetails?.vpa ?? ""
//        
//        
////        lblUpiId21.text = beneVpa ?? contactNumber
//        
//        
//        
//        if beneVpa == nil {
//            lblUpiId21.text = contactNumber
//            print(lblUpiId21.text)
//            
//        }else{
//            lblUpiId21.text = beneVpa
//            print(lblUpiId21.text)
//        }
//        
//     
//        
//        
//        let trimmedBeneName = beneName.components(separatedBy: "%20").joined(separator: " ")
//        lblRegisteredName.text = trimmedBeneName
//        
//        viewTextNameBg.isHidden = isFromQrScan
//        viewBeneficiaryBg.isHidden = isFromQrScan
//         
//        lblAccountType.text = accountDetails?.type
//        
////        constraintViewHeight.constant = isFromQrScan ? constraintViewHeight.constant - 50 : constraintViewHeight.constant
//        
//        lblFromName.text = accountDetails?.name
//        
//        if let imageData = contactData?.thumbnailImageData {
//            imgContact.image = UIImage(data: imageData)
//        } else {
//            // Set a placeholder image if no contact image is available
//            imgContact.image = UIImage(named: "me_profile")
//        }
//        
//    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("beneVpa ========", beneVpa ?? "nil")
        
        if let number = contactNumber {
            print("Received contact number: \(number)")
        } else {
            print("contactNumber is nil")
        }
        
        if qrData["mam"] != nil && qrData["am"] != nil {
            if isFromQrScan == true {
                setValues(scandata: qrData)
                amountlimit = 100000
                minValue = 0
            } else {
                amountlimit = 100000
                minValue = 0
            }
        } else {
            amountlimit = 100000
            minValue = 0
            txtRemark.isEnabled = true
        }
        
       // checkvpa(vpa: beneVpa)
        
        print("beneVpa====",beneVpa)
        print("contactNumber====",contactNumber)
        
        
        if beneVpa == ""{
            checkvpas(contactNumber: contactNumber ?? "")
        }else{
            checkvpa(vpa: beneVpa)
        }
        
        
        
        lblUpiId21.text = beneVpa ?? contactNumber
        
       
        lblUpiId.text = accountDetails?.vpa ?? ""
        
//        
//        let vpaToCheck = beneVpa ?? contactNumber ?? ""
//           
//           // Check if vpaToCheck is not empty before calling checkvpa
//           if !vpaToCheck.isEmpty {
//               checkvpa(vpa: vpaToCheck)
//           } else {
//               print("Error: No valid VPA or contact number available")
//           }
//
//        
        
        
        // Debug assignment
//        if beneVpa == nil {
//            lblUpiId21.text = contactNumber
//            print("Setting lblUpiId21.text to contactNumber: \(lblUpiId21.text ?? "nil")")
//        } else {
//            lblUpiId21.text = beneVpa
//            print("Setting lblUpiId21.text to beneVpa: \(lblUpiId21.text ?? "nil")")
//        }
        
      
     
        
       
        
        
        let trimmedBeneName = beneName.components(separatedBy: "%20").joined(separator: " ")
        lblRegisteredName.text = trimmedBeneName
        
        viewTextNameBg.isHidden = isFromQrScan
        viewBeneficiaryBg.isHidden = isFromQrScan
        
        lblAccountType.text = accountDetails?.type
        lblFromName.text = accountDetails?.name
        
        if let imageData = contactData?.thumbnailImageData {
            imgContact.image = UIImage(data: imageData)
        } else {
            imgContact.image = UIImage(named: "me_profile")
        }
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

        if beneVpa == "" {
               lblUpiId21.text = contactNumber
           } else {
               lblUpiId21.text = beneVpa
           }
           
           print("lblUpiId21.text in viewWillAppear: \(lblUpiId21.text ?? "nil")")

        lblUpiId21.text = beneVpa ?? contactNumber
        print("lblUpiId21.text in viewWillAppear ======= ", lblUpiId21.text ?? "No value")
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
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
                    }
                    
                    else if err.code == 108{
                        DispatchQueue.main.async {
                            self.showQrErrorAlert(message: err.localizedDescription)
                        }
                    }
                    
                    else if err.code == 401 || err.code == 107 {
                        
                        self.configuration()
                        //return
                    }
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                    }
                } else {
                    
                    
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                    }
                    
                    print(data)
                    
                    if let dt = data {
                        
                        if let data = self.convertToSomeAnyData(dt) {
                            
                            do {
                                
                               // print(data)
                                
                                print(self.mccCodeDNewVC)
                                
                                print(self.beneName)
                                
                                DispatchQueue.main.async {
                                    
                                    self.lblRegisteredName.text = self.beneName
                                    
                                }
                                
                                
                               
                                
                                
                                
//                                if let mcccode = data["mcccode"] as? String {
//                                                       print("MCC Code: \(mcccode)")
//                                                   } else {
//                                                       print("MCC Code not found or is not a String")
//                                                   }
//                                               
//                                                   self.dataDict = data
//                               
//                                                   print(self.dataDict ?? (Any).self)
//                               
//                                                   if let mccCode = self.getMccCode(from: data as! [[String : Any?]]) {
//                                                       print("MCC Code: \(mccCode)")
//                                                   } else {
//                                                       print("MCC Code not found")
//                                                   }
                                    
                                    
                                
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
                    
                    
                    
                }
            }
        }

    }
    
    
    
    
    func checkvpas(contactNumber: String) {
        
        let payerInfo = PayerInfo(accountnumber: accountDetails?.accRefNumber, mcc: MCC, name: accountDetails?.name, payervpa: accountDetails?.vpa)
        
        var jsonToString = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(payerInfo)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("jsonString ======>>>>",jsonString)
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
            OliveUpiManager.checkvpa(vpa: contactNumber, payerInfo: jsonToString) { data, error in
                
                print("data=========",data)
                print("error========",error)
                
                if let err = error {
                    if err.code == 102 { // Customer Accounts not found / Timed Out
                        DispatchQueue.main.async {
                            self.showErrorAlert(err.localizedDescription)
                        }
                    }
                    
                    else if err.code == 108{
                        DispatchQueue.main.async {
                            self.showQrErrorAlert(message: err.localizedDescription)
                        }
                    }
                    
                    else if err.code == 401 || err.code == 107 {
                        
                        self.configuration()
                        //return
                    }
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                    }
                } else {
                    
                    
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                    }
                    
                   // print(data)
                    if let dt = data as? [String: Any]{
                        self.vpaUpdate = dt["vpa"] as? String ?? ""
                        print(self.vpaUpdate)
                    }
                    if let dt = data {
                        
                        if let data = self.convertToSomeAnyData(dt) {
                            
                            do {
                                
                               // print(data)
                                
                                print(self.mccCodeDNewVC)
                              
                                print(self.beneName)
                                
                                DispatchQueue.main.async {
                                    
                                    self.lblRegisteredName.text = self.beneName
                                    
                                }
                                
                                
                               
                                
                                
                                
//                                if let mcccode = data["mcccode"] as? String {
//                                                       print("MCC Code: \(mcccode)")
//                                                   } else {
//                                                       print("MCC Code not found or is not a String")
//                                                   }
//
//                                                   self.dataDict = data
//
//                                                   print(self.dataDict ?? (Any).self)
//
//                                                   if let mccCode = self.getMccCode(from: data as! [[String : Any?]]) {
//                                                       print("MCC Code: \(mccCode)")
//                                                   } else {
//                                                       print("MCC Code not found")
//                                                   }
                                    
                                    
                                
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
                    
                    
                    
                }
            }
        }

    }
    
    func playDeductionAlertSound() {
           let now = Date()
           
           // Check if the sound was played recently
           if let lastPlayTime = lastPlayTime, now.timeIntervalSince(lastPlayTime) < 4 {
               print("Sound played recently. Please wait before playing again.")
               return
           }

           // Update the last play time
           lastPlayTime = now

           if let soundURL = Bundle.main.url(forResource: "deduction_alert_hindi", withExtension: "mp3") {
               do {
                   audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                   audioPlayer.delegate = self
                   audioPlayer.prepareToPlay()
                   audioPlayer.play()
               } catch {
                   print("Error loading audio file: \(error.localizedDescription)")
               }
           } else {
               print("Could not find the audio file in the app bundle.")
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
           
           mccCodeDNewVC = dictionary["mcccode"] as? String ?? ""
           //print(dictionary["mcccode"] as? String)
           
           beneName = dictionary["data"] as? String ?? ""
           
           print(mccCodeDNewVC)
           
           
           
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
    
    
    
    func showQrErrorAlert(message: String) {
        
       
        
        
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            
            alertController.addAction(okAction)
            
            present(alertController, animated: true, completion: nil)
        }
    
    
    
    
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//    
    
    func setValues(scandata : [String:Any]){
        
        
        print("MAM :",qrData["mam"] as? String ?? "")
        print("AM :",qrData["am"] as? String ?? "")
  
        
        
        if qrData["tn"] as? String != ""{
            
            txtRemark.text = qrData["tn"] as? String ?? ""

            txtRemark.isEnabled = false

        }else{
            
            txtRemark.isEnabled = true

        }
        
        /*
        
        let testCases = [
            (qrData["am"] as? String ?? "", qrData["mam"] as? String ?? "")
        ]
        
        
        for (am, mam) in testCases {
            let (range, editable) = checkAmountRangeAndEditable(am: am, mam: mam)
            
            
            
            print("am: \(am), mam: \(mam) -> amount range: \(range), amount editable: \(editable)")
            
            /*
             txtAmount.isEnabled = false
             
             txtAmount.isEnabled = true
             */
            
            
            if range == "no limit"{
                
                amountlimit = 100000
                
                txtAmount.isEnabled = false
                
            }else if range == "10-10000" {
                
                amountlimit = 100000
                
                txtAmount.isEnabled = true
                
            } else if range == "10 (fixed)" {
                
                
                txtAmount.isEnabled = false
                
                
            } else if range == "3,4,5 (not more than 5)" {
                
                txtAmount.isEnabled = true

               // amountlimit = amdigit ?? 0

                amountlimit = 5
                
                minValue = 2
                
                txtAmount.text = qrData["mam"] as? String ?? "0"

                

            }
            
            
        }
        
        */
        
        
        
    
        if qrData["am"] as? String == "null"{
            
            txtAmount.text = "0"
            
            amStr = "0"

        }else if qrData["am"] as? String == "0"{
            
            txtAmount.text = qrData["am"] as? String ?? ""
            
            amStr = qrData["am"] as? String ?? ""

        }
        else if qrData["am"] as? String == "absent"{
            
            txtAmount.text = "0"
            amStr = "0"

        }else
        {
            
            txtAmount.text = qrData["am"] as? String ?? ""

            amStr = qrData["am"] as? String ?? ""

        }
        
        
        
        if qrData["mam"] as? String == "null"{
            
            mamStr = "0"

        }else if qrData["mam"] as? String == "0"{
            
            mamStr = qrData["mam"] as? String ?? ""

        }
        else if qrData["mam"] as? String == "absent"{
            
            mamStr = "0"

        }else
        {
            mamStr = qrData["mam"] as? String ?? ""

        }
        
        
        
        if qrData["am"] as? String != "0.0" && mamStr != "0" {
            
            txtAmount.isEnabled = false
            
        }else{
            
            txtAmount.isEnabled = true
            
        }
        
        
        
        
        // for amountEditable Condition
        
       // amdigit = Int(qrData["am"] as? String ?? "0")

       // mamDigit = Int(qrData["am"] as? String ?? "0")

        
        
        if qrData["am"] as? String == "0" && qrData["mam"] as? String == "0" {
            
            txtAmount.isEnabled = true
            
            amountlimit = 100000
            
            
        } else if qrData["am"] as? String == "null" && qrData["mam"] as? String == "0" {
            
            txtAmount.isEnabled = true
            
            amountlimit = 100000
            
            
            
        }else if qrData["am"] as? String == "absent" && qrData["mam"] as? String == "0" {
            
            txtAmount.isEnabled = true
            
            amountlimit = 100000
            
            
            
        }else if qrData["am"] as? String == "0" && qrData["mam"] as? String == "null" {
            
            txtAmount.isEnabled = true
            
            amountlimit = 100000
            
        }
        else if qrData["am"] as? String == "null" && qrData["mam"] as? String == "null" {
            
            txtAmount.isEnabled = true
            
            amountlimit = 100000
            
        }
        else if qrData["am"] as? String == "absent" && qrData["mam"] as? String == "null" {
            
            txtAmount.isEnabled = true
            
            amountlimit = 100000
            
            
            
        }
        else if qrData["am"] as? String == "absent" && qrData["mam"] as? String == "null" {
            
            txtAmount.isEnabled = true
            
            amountlimit = 100000
            
            
            
        }else if qrData["am"] as? String == "0" && qrData["mam"] as? String == "null" {
            
            txtAmount.isEnabled = true
            
            amountlimit = 100000
            
            
            
        }else if qrData["am"] as? String == qrData["mam"] as? String {
            
            txtAmount.isEnabled = false
            
            amountlimit = 100000
            
            
            
        }
        else if qrData["am"] as? String == "absent" && qrData["mam"] as? String == "absent" {
            
            txtAmount.isEnabled = true
            
            amountlimit = 100000
            
            
            
        }else if qrData["am"] as? String == "0" || qrData["am"] as? String == "null" || qrData["am"] as? String == "absent" {
            
            mamDigit = Double(qrData["mam"] as? String ?? "0")

            
            if  mamDigit ?? 0.0 > 0 {
                
                txtAmount.isEnabled = true
                
                amountlimit = 100000
                
               //let setValue = mamDigit
                
                txtAmount.text = qrData["mam"] as? String ?? "0"
              
                minValue = mamDigit
                
            }
            
        } else{
            
            
            amdigit = Double(qrData["am"] as? String ?? "0")
            
             mamDigit = Double(qrData["mam"] as? String ?? "0")
            
            if amdigit ?? 0 > 0   && qrData["mam"] as? String == "0" {
                
                txtAmount.isEnabled = false
                
                amountlimit = 100000
                
                
            }else if amdigit ?? 0 > 0   && qrData["mam"] as? String == "null" {
                
                txtAmount.isEnabled = false
                
                amountlimit = 100000
                
                
            }else if amdigit ?? 0 > 0   && qrData["mam"] as? String == "absent" {
                
                txtAmount.isEnabled = false
                
                amountlimit = 100000
                
                
            }
            else if amdigit ?? 0 == 0   && mamDigit ?? 0 > 0 {
                
                txtAmount.isEnabled = true
                
                amountlimit = 100000
                
                
            }else if amdigit ?? 0 > mamDigit ?? 0{
                
                txtAmount.isEnabled = true
                
                amountlimit = amdigit ?? 0
                
                minValue = mamDigit ?? 0
                
                
            }
            
            else{
                
                txtAmount.isEnabled = true
                
                amountlimit = 100000
                
                
            }

            
        }
        
    
        
        
    }
    
    func checkAmountRangeAndEditable(am: String, mam: String) -> (String, Bool) {
        var amountRange: String = "no limit"
        var amountEditable: Bool = true
        
        if am == "10" && (mam == "0" || mam == "absent") {
            amountRange = "10 (fixed)"
            amountEditable = false
        } else if am == "0" && mam == "10" {
            amountRange = "10-10000"
        } else if am == "null" && mam == "10" {
            amountRange = "10-10000"
        } else if am == "absent" && mam == "10" {
            amountRange = "10-10000"
        } else if am == "10" && mam == "10" {
            amountRange = "10 (fixed)"
            amountEditable = false
        } else if am == "5" && mam == "2" {
            amountRange = "3,4,5 (not more than 5)"
        }
        
        return (amountRange, amountEditable)
    }
    
    
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnContinueAction(_ sender: UIButton) {
        if self.txtAmount.text?.count == 0 || Double(self.txtAmount.text ?? "0") == 0 {
            self.showErrorAlert("Please enter amount")
            return
        }else {
            // mamDigit = Double(qrData["mam"] as? String ?? "0")
            showAlertMessageWithActionButtonAndCancelButton(title: "Be Alert | सावधान रहें", message: "\nIs this transaction a fraud? \n\nक्या यह लेनदेन धोखाधड़ी है?", actionButtonText: "No", cancelActionButtonText: "Yes", vc: self) { status in
                if status == 1 {
                    self.oliveBlockApiCall()
                }else if status == 0 {
                    if self.isFromQrScan == true {
                        
                        // let checkAmount = Double(txtAmount.text ?? "0")
                        self.minValue  =  Double(self.qrData["mam"] as? String ?? "")
                        
                        self.maxValue = Double(self.qrData["am"] as? String ?? "")
                        
                        if (self.minValue != nil) || (self.maxValue != nil) {
                            if self.txtAmount.text?.count == 0 || Double(self.txtAmount.text ?? "0") == 0 {
                                self.showErrorAlert("Please enter amount")
                                return
                            }else if Double(self.txtAmount.text ?? "0")! < self.minValue! {
                                
                                self.showErrorAlert("Please enter minimum amount \(self.minValue!)")
                            }
                            
                            
                            if self.txtAmount.text?.count == 0 || Double(self.txtAmount.text ?? "0") == 0 {
                                self.showErrorAlert("Please enter amount")
                                return
                            }else if Double(self.txtAmount.text ?? "0")! > self.maxValue! {
                                
                                self.showErrorAlert("Maximum amount \(self.maxValue!)")
                            }
                            
                            
                            
                        }else{
                            if self.txtAmount.text?.count == 0 || Double(self.txtAmount.text ?? "0") == 0 {
                                self.showErrorAlert("Please enter amount")
                                return
                            }else{
//                                let storyboard = UIStoryboard(name: "BhimUpi", bundle: nil)
//                                
//                                let vc = storyboard.instantiateViewController(withIdentifier: "PaymentUPIIDNewConfirmationVC") as! PaymentUPIIDNewConfirmationVC
//                                vc.vpaUpdate = self.vpaUpdate
//                                vc.accountDetails = self.accountDetails
//                                vc.beneVpa = self.beneVpa
//                                vc.beneName = self.beneName
//                                vc.transId = self.transId
//                                vc.amtDecimal = self.txtAmount.text ?? ""
//                                vc.remark =  self.txtRemark.text ?? ""
//                                vc.mccCodeStr =  self.mccCodeDNewVC
//                                
//                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                            
                        }
                        
                    }else{
                        if self.txtAmount.text?.count == 0 || Double(self.txtAmount.text ?? "0") == 0 {
                            self.showErrorAlert("Please enter amount")
                            return
                        }
                        
                    }
                    
                    if self.txtAmount.text?.count == 0 || Double(self.txtAmount.text ?? "0") == 0 {
                        self.showErrorAlert("Please enter amount")
                        return
                    }else{
                        let storyboard = UIStoryboard(name: "BhimUpi", bundle: nil)
                        
                        let vc = storyboard.instantiateViewController(withIdentifier: "PaymentUPIIDNewConfirmationVC") as! PaymentUPIIDNewConfirmationVC
                        
                        vc.accountDetails = self.accountDetails
                        vc.beneVpa = self.beneVpa
                        vc.vpaUpdate = self.vpaUpdate
                        vc.beneName = self.beneName
                        vc.transId = self.transId
                        vc.amtDecimal = self.txtAmount.text ?? ""
                        vc.remark =  self.txtRemark.text ?? ""
                        vc.mccCodeStr =  self.mccCodeDNewVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }
                    
        
        
//        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
//        
//        let vc = storyboard.instantiateViewController(withIdentifier: "PaymentSuccessfulVC") as! PaymentSuccessfulVC
//        
//        vc.accountDetails = self.accountDetails
//        vc.beneVpa = self.beneVpa
//        vc.beneName = self.beneName
//        vc.transId = self.transId
//        vc.amount = "\(self.amtDecimal)"
//        vc.fromScreenOption = "pay"
//        
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnCheckBalanceAction(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        apiCallOption = "chkbal"
        
        let accountDetails = AccountCheckBalance(name: accountDetails?.name ?? "", mmid: accountDetails?.mmid ?? "", aeba: accountDetails?.aeba ?? "", mbeba: accountDetails?.mbeba ?? "", accRefNumber: accountDetails?.accRefNumber ?? "", ifsc: accountDetails?.ifsc ?? "", maskedAccnumber: accountDetails?.maskedAccnumber ?? "", status: accountDetails?.status ?? "", type: accountDetails?.type ?? "", vpa: accountDetails?.vpa ?? "", dLength: accountDetails?.dLength ?? "", dType: accountDetails?.dType ?? "", balance: accountDetails?.balance ?? "", balTime: accountDetails?.balTime ?? "")
        
        var jsonObjectString = ""
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(accountDetails)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
              //  print(jsonString)
                jsonObjectString = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        if self.accountDetails?.status == "A" { // Account active
            
            if self.accountDetails?.vpa != "" {
                
                DispatchQueue.global(qos:.background).async {

                    // Working Properly
                    OliveUpiManager.checkBalance(account: jsonObjectString, viewController: self) { data, error in
                        
                        
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
                            
                            let dataObject = data as! [String: Any]
                            DispatchQueue.main.async {
                                SwiftLoader.hide()
                                self.lblCheckBalance.text = "₹\(dataObject["data"] as! String)"
                            }
                        }
                    }
                }
            } else {
                
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "UPILinkUpdateVC") as! UPILinkUpdateVC
                    vc.accountDetails = self.accountDetails
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
        } else if accountDetails.status == "R" { // Account Not active
            
            // call activate account function
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "UPISetUPIPinVC") as! UPISetUPIPinVC
                vc.accountDetails = self.accountDetails
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    func oliveBlockApiCall() {
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        DispatchQueue.global(qos: .background).async {
            
            OliveUpiManager.collectBlockUnblock(vpa: self.beneVpa, block: "B", reason: "") { data, error in
                
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
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
                        let vc = storyBoard.instantiateViewController(withIdentifier: "BlockUPIListVC") as! BlockUPIListVC
                        vc.isFromBlockAlert = true
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }
    }
    
    func saveBeneficary(dataResp: String) {
        
        self.apiCallOption = "bene"
        
        let saveBeneVpa = SaveBeneVpa(vpa: self.beneVpa, name: self.beneName, nickname: txtName.text!)
        
        var strSaveBeneVpa = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(saveBeneVpa)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strSaveBeneVpa = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        DispatchQueue.global(qos: .background).async {
            
            // Manage Response
            OliveUpiManager.saveBeneVpa(bene: strSaveBeneVpa) { data, error in
                    
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
                            
                            vc.accountDetails = self.accountDetails
                            vc.beneVpa = self.beneVpa
                            vc.vpaUpdate = self.vpaUpdate
                            vc.beneName = self.beneName
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
                  //  print(data)
                                        
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        self.showToast(message: "Beneficiary added Successfully")
                        
                        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "PaymentSuccessfulVC") as! PaymentSuccessfulVC
                        
                        vc.accountDetails = self.accountDetails
                        vc.beneVpa = self.beneVpa
                        vc.vpaUpdate = self.vpaUpdate
                        vc.beneName = self.beneName
                        vc.transId = dataResp
                        vc.amount = self.amtDecimal
                        vc.fromScreenOption = "pay"

                        self.navigationController?.pushViewController(vc, animated: true)

                    }
                }
            }
            
        }
    }
    
    @IBAction func btnAddBeneficiaryAction(_ sender: UIButton) {
        
        if btnAddBeneficiary.tag == 0 {
            imgCheckUncheck.image = UIImage(named: "check")
            btnAddBeneficiary.tag = 1
        } else {
            imgCheckUncheck.image = UIImage(named: "uncheck")
            btnAddBeneficiary.tag = 0
        }
        
    }
    
}

extension PaymentUPIIDNewVC: UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Check if the text field is the decimalTextField
        if textField == txtAmount {
            // Limit to only one decimal point
            if string == "." && textField.text?.contains(".") == true {
                return false
            }
            
            // Limit to only two digits after the decimal point
            if let text = textField.text, let range = Range(range, in: text) {
                let newText = text.replacingCharacters(in: range, with: string)
                if newText.count == 1 {
                    // play Deduction Sound
                    playDeductionAlertSound()
                }
                let components = newText.components(separatedBy: ".")
                if components.count == 2 {
                    if components[1].count > 2 {
                        return false
                    }
                }
                // Limit the amount to 100000
                // amountlimit
                //amountlimit = 5
                if let amount = Double(newText), amount > amountlimit! {
                    return false
                }
            }
        } else {
            // For other text fields, limit the number of characters to 30
            if let text = textField.text, let range = Range(range, in: text) {
                let newText = text.replacingCharacters(in: range, with: string)
                return newText.count <= 30
            }
        }
        return true
    }
    
    
    
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        if let manualInputText = textField.text, let range = Range(range, in: manualInputText) {
//
//            let inputText = manualInputText.replacingCharacters(in: range, with: string)
//           // let minValue = 0 //your value
//           // let maxValue = 10 //your value
//
//            if inputText.isEmpty {
//                textField.text = "\(String(describing: minValue))"
//                return false
//            } else if textField.text == "0" {
//                textField.text = string
//                return false
//            }
//            if let inputValue = Double(inputText), (inputValue >= minValue!), (inputValue <= amountlimit!) {
//                    return true
//            }
//        }
//        return false
//    }
    
    
    
}

extension PaymentUPIIDNewVC: MFMessageComposeViewControllerDelegate {
    
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
            if self.apiCallOption == "pay" {
                self.btnContinueAction(UIButton())
            } else if self.apiCallOption == "bene" {
                self.saveBeneficary(dataResp: self.transId)
            } else if self.apiCallOption == "chkbal" {
                self.btnCheckBalanceAction(UIButton())
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
                        self.btnContinueAction(UIButton())
                    } else if self.apiCallOption == "bene" {
                        self.saveBeneficary(dataResp: self.transId)
                    } else if self.apiCallOption == "chkbal" {
                        self.btnCheckBalanceAction(UIButton())
                    }
                }
            })
            break
        default:
            break
        }
    }
}




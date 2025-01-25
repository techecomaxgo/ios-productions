//
//  BhimTransactionNextDetailsVC.swift
//  MaxPay
//
//  Created by Ios Developer on 13/05/24.
//

import UIKit
import SwiftLoader
import OlivePayLibrary

class BhimTransactionNextDetailsVC: BaseVC {
    
    @IBOutlet weak var viewTop: UIView!
    
    @IBOutlet weak var lblTransStatus: UILabel!
    
    @IBOutlet weak var imgForTrnsStatus: UIImageView!
    
    @IBOutlet weak var lblVPA: UILabel!
    
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTrnsId: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var lblRemarks: UILabel!
    
    @IBOutlet weak var lblTimeChange: UILabel!
    
    
    @IBOutlet weak var imgTrsnIndicator: UIImageView!
    
    @IBOutlet weak var btnCheckStatus: UIButton!
    
    @IBOutlet weak var btnRaise: UIButton!
    
    @IBOutlet weak var lblRaiseSet: UILabel!
    
    @IBOutlet weak var raiseView: UIView!
    @IBOutlet weak var btnRaisedtapped: DesignableButton!
    private var checksumViewModel = SIMSelectionViewModel()
    
    var responseDictFromCheck = NSDictionary()
    var responseDictFromChecks: [String: Any]?
    
    var ReqComplientVoViewModel = ReqComplientVo()
    
    var statusStr = ""
    //    var timer: Timer?
    
    var creditVpaStr = ""
    var statusCodeStr = ""

    var amountStr = ""
    var tranidStr = ""
    var dateTimeStr = ""
    var remarksStr = ""
    var refidStr = ""
    var tranHistoryObjdata = ""
    //    var dataall = ""
    var dataall: String?
    
    
    var tranIdData = ""
    var refidData = ""
    var dateTimeData = ""
    var remarksData = ""
    
    var generateRRNStr = ""
    var orderIdsStr = ""
    
    
    var tranHistoryObjs: TranHistoryModel?
    var RaiseTransactionData:RaiseTransactionData?
    
    var timer = Timer()
    var counter:Int = 20
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.configuration()
        checkStatus()
        
                
        print("tranIdData", tranIdData)
        
                
        viewTop.layer.applyCornerRadiusShadow()
        
        print("responseDictFromCheck =====>>>",responseDictFromCheck)
        print("tranHistoryObjs ====>>",tranHistoryObjs)
        
        self.updateDateTimehidedata(responseDictFromCheck: self.responseDictFromCheck as! [String : Any])
        
        
        if tranHistoryObjs?.mcc != ""{
            raisedHideandShow()
            
        }else{
            raisedbuttonhideshowsss()
        }
        
        
        if tranHistoryObjs?.mcc == "0000" || tranHistoryObjs?.mcc == nil{
            
            print("MCC_Status(c)",tranHistoryObjs?.status)
            raisedHideandShow()
            
        }else{
            raisedbuttonhideshowsss()
        }
        
        
        creditVpaStr = responseDictFromCheck["creditVpa"] as? String ?? ""
        amountStr = responseDictFromCheck["amount"] as? String ?? ""
        tranidStr = responseDictFromCheck["tranid"] as? String ?? ""
        
        refidStr =  responseDictFromCheck["refid"] as? String ?? ""
        dateTimeStr = responseDictFromCheck["dateTime"] as? String ?? ""
        
        remarksStr = responseDictFromCheck["remarks"] as? String ?? ""
        
        
        if let status = responseDictFromCheck["status"] as? String ?? tranHistoryObjs?.status {
            statusStr = status
            print("statusStr ====",statusStr)
            print("status ====",status)
            
            
        } else {
            statusStr = "Default Status" // Provide a default value or handle the case when both are nil
        }
        
        
        print(statusStr)
        
        
        
        let tranid = responseDictFromCheck["tranid"] as? String ?? tranHistoryObjs?.tranid
//        print("tranid before assigning to lblTrnsId:", tranid)
        lblTrnsId.text = tranid
        print("lblTrnsId.text after assigning:", lblTrnsId.text ?? "No text")
        
        
        print(responseDictFromCheck["creditVpa"] as? String ?? "")
        print(responseDictFromCheck["dateTime"] as? String ?? tranHistoryObjs?.dateTime)
        
        lblRemarks.text = responseDictFromCheck["remarks"] as? String ?? tranHistoryObjs?.remarks
        
        
        
        // Safely unwrap the amount from the response dictionary as a String
        if let amountString = responseDictFromCheck["amount"] as? String {
            lblAmount.text = "₹\(amountString)"
        } else if let amountInt = tranHistoryObjs?.amount {
            // Convert the Int amount to a String and assign it
            lblAmount.text = "₹\(String(amountInt))"
        } else {
            // Fallback if both are nil
            lblAmount.text = "₹0"
        }
        
        
        
        
        lblVPA.text = responseDictFromCheck["creditVpa"] as? String ?? tranHistoryObjs?.creditVpa
        
        lblDate.text = responseDictFromCheck["dateTime"] as? String ?? tranHistoryObjs?.dateTime
        
//        status stepper
        
        if responseDictFromCheck["status"] as? String ?? tranHistoryObjs?.status == "F"{
            
            
            imgForTrnsStatus.image = UIImage(named: "payment-failed-ic")
            
            imgTrsnIndicator.image = UIImage(named: "payment-failed-progress")

        }
        else if responseDictFromCheck["status"] as? String ?? tranHistoryObjs?.status == "S" {
            
            
            imgForTrnsStatus.image = UIImage(named: "complete_statusImg")
            lblTransStatus.text = "Active"
            
            imgTrsnIndicator.image = UIImage(named: "transIndicatior_five")
            
        }else if responseDictFromCheck["status"] as? String ?? tranHistoryObjs?.status == "D" {
            
            imgForTrnsStatus.image = UIImage(named: "payment-pending-ic")
            lblTransStatus.text = "Deemed"
            
            imgTrsnIndicator.image = UIImage(named: "transactionIndicator_pending_progress")
            
        }else if responseDictFromCheck["status"] as? String ?? tranHistoryObjs?.status == "P" {
            
            imgForTrnsStatus.image = UIImage(named: "payment-pending-ic")
            lblTransStatus.text = "Pending"
            
            imgTrsnIndicator.image = UIImage(named: "transactionIndicator_pending_progress")
        }
        else if responseDictFromCheck["status"] as? String ?? tranHistoryObjs?.status == "U" {
            
            imgForTrnsStatus.image = UIImage(named: "payment-failed-ic")
            
            //  lblStatusStr.text = "Auto Pay is Unpaused"
            
        }
        else if responseDictFromCheck["status"] as? String ?? tranHistoryObjs?.status == "R" {
            
            imgForTrnsStatus.image = UIImage(named: "payment-failed-ic")
            
            
        }else if responseDictFromCheck["status"] as? String ?? tranHistoryObjs?.status == "E" {
            
            imgForTrnsStatus.image = UIImage(named: "payment-failed-ic")
            
        }else if responseDictFromCheck["status"] as? String ?? tranHistoryObjs?.status == "C" {
            
            imgForTrnsStatus.image = UIImage(named: "complete_statusImg")
        }else {
            
            imgForTrnsStatus.image = UIImage(named: "payment-failed-ic")
        }
                
        
        if let dateTimeStr = responseDictFromCheck["dateTime"] as? String ?? tranHistoryObjs?.dateTime {
            print("dateTimeStr ========>>>>>>>>>>>>> 22 :", dateTimeStr)
            
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss" // Correct format
            
            if let date = inputFormatter.date(from: dateTimeStr) {
                let outputDateFormatter = DateFormatter()
                outputDateFormatter.dateFormat = "dd MMM, yyyy" // Desired date format
                let formattedDate = outputDateFormatter.string(from: date)
                
                let outputTimeFormatter = DateFormatter()
                outputTimeFormatter.dateFormat = "HH:mm:ss" // Desired time format
                let formattedTime = outputTimeFormatter.string(from: date)
                
                lblDate.text = formattedDate
                lblTime.text = formattedTime
                
                print("Formatted Date: \(formattedDate)")
                print("Formatted Time: \(formattedTime)")
            } else {
                print("Failed to parse date from dateTimeStr. Check the format.")
                lblDate.text = tranHistoryObjs?.dateTime
                // lblTimeChange.text = "Reference"
                lblTime.text = tranHistoryObjs?.dateTime
            }
        } else {
            print("dateTime is nil or missing")
            lblDate.text = tranHistoryObjs?.dateTime
            // lblTimeChange.text = "Reference"
            lblTime.text = tranHistoryObjs?.dateTime
        }
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        checkStatus()
        self.updateDateTimehidedata(responseDictFromCheck: self.responseDictFromCheck as! [String : Any])
    }
    
    
    func updateDateTimehidedata(responseDictFromCheck: [String: Any]) {
        
        // 04/09/2024 11:42:01 AM
        
        // Assuming dateTimeStr is an optional string
        if let dateTimeStr = responseDictFromCheck["dateTime"] as? String ?? tranHistoryObjs?.dateTime {
            print("dateTimeStr: \(dateTimeStr)")
            
            if compareWithNext5Minutes(dateString: dateTimeStr) {
                raiseView.isHidden = true
            }
            else {
                raiseView.isHidden = false
            }
            
        }
        
        // raiseView.isHidden = true
        
        // Example date string (replace with your actual date string)
        //  let dateTimeStr = "09/04/2024 01:29:24 PM"
        
        // Check if the current time is at least 5 minutes after the given date
        
        
        
        
        // Ensure dateTimeStr is not nil
        /*if let dateTimeStr = dateTimeStr {
            // Create a DateFormatter to parse the dateTimeStr
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-DD-YYYY hh:mm:ss" // Input format
            
            // Convert string to Date
            if let date = dateFormatter.date(from: dateTimeStr) {
                // Create another DateFormatter to format the date and time separately
                let dateOnlyFormatter = DateFormatter()
                dateOnlyFormatter.dateFormat = "MM-DD-YYYY" // Desired date format
                
                let timeOnlyFormatter = DateFormatter()
                timeOnlyFormatter.dateFormat = "hh:mm:ss a" // Desired time format
                
                // Format the Date object into date and time strings
                let dateOnlyStr = dateOnlyFormatter.string(from: date)
                let timeOnlyStr = timeOnlyFormatter.string(from: date)
                
                // Print the results
                print("Date: \(dateOnlyStr)")
                print("Time: \(timeOnlyStr)")
                
                lblDate.text = dateOnlyStr
                lblTime.text = timeOnlyStr
                
                //     raiseView.isHidden = true
                
                
                //   isTimeWithinFiveMinutes(of: dateTimeStr)
                
                print("dateTimeStr=====: \(dateTimeStr)")
                
                
                if isTimeWithinFiveMinutes(of: dateTimeStr) {
                    // Show the raiseView if the current time is at least 5 minutes after the given date
                    raiseView.isHidden = true
                    //   timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(processTimer), userInfo: nil, repeats: true)
                    
                }
                else {
                    // Ensure the raiseView is hidden otherwise
                    raiseView.isHidden = false
                }
                
                
                
            }*/
            
        }
    
    func compareWithNext5Minutes(dateString: String) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
        guard let date = formatter.date(from: dateString) else {
            print("Invalid date format")
            return false
        }

        let fiveMinutesLater = date.addingTimeInterval(300) // 5 minutes * 60 seconds/minute
        let currentDate = Date()

        return currentDate < fiveMinutesLater
    }

    
    func isTimeWithinFiveMinutes(of dateTimeStr: String) -> Bool {
        // Create a DateFormatter to parse the dateTimeStr
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm:ss a" // Input format
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Kolkata") // Use current time zone
        
        // Convert string to Date
        guard let date = dateFormatter.date(from: dateTimeStr) else {
            print("Failed to parse date string: \(dateTimeStr)")
            return false
        }
        
        // Get the current date and time
        let currentDate = Date()
        
        // Convert dates to milliseconds
        let dateInMillis = date.timeIntervalSince1970 * 1000
        let currentDateInMillis = currentDate.timeIntervalSince1970 * 1000
        
        // Calculate the time interval in milliseconds
        let timeIntervalInMillis = abs(currentDateInMillis - dateInMillis)
        
        // Define 5 minutes in milliseconds
        let fiveMinutesInMillis: TimeInterval = 5 * 60 * 1000
        
        // Debugging prints
        print("Parsed Date: \(date)")
        print("Current Date: \(currentDate)")
        print("Parsed Date (ms): \(dateInMillis)")
        print("Current Date (ms): \(currentDateInMillis)")
        print("Time Interval (ms): \(timeIntervalInMillis)")
        print("Current Timezone: \(TimeZone.current)")
        
        // Return true if the time interval is within 5 minutes
        return timeIntervalInMillis <= fiveMinutesInMillis
    }
    
    
    
    
    @objc func processTimer() {
        if counter > 0 {
            counter -= 1
            raiseView.isHidden = true
        }
        else {
            raiseView.isHidden = false  // Hide the label when the counter is zero
            timer.invalidate()  // Stop the timer
        }
    }
    
    
    
    
    
    
    private func checkDisputeReasonP2M(code: String) {
        switch code {
            
            
        case "UTOUTO" :
            lblRaiseSet.text = "Your complaint request was timeout please try again"
            btnRaise.isHidden = true
            self.sendNotificationToApp(isSent: true, type: "pr2c", title: "", msgBody: "Your complaint request was timeout please try again", benefVpa: "")
        case "TCC102", "TCC103", "TCC104":
            
            if tranHistoryObjs?.disputeStatus?.caseInsensitiveCompare("failure") == .orderedSame {
                lblRaiseSet.text = NSLocalizedString("ttc102 failure message", comment: "")
                btnRaise.isHidden = true
                self.sendNotificationToApp(isSent: true, type: "pr2c", title: "Complaint not raised yet", msgBody: "Your complaint request was failed", benefVpa: "")

                
            }
            else {
                lblRaiseSet.text = "Payee Confirms that\n Goods/Services delivered\n / Complaint is resolved \n"
                btnRaise.isHidden = true
                self.sendNotificationToApp(isSent: true, type: "pr2c", title: "Your complaint raised and resolved", msgBody: "Payee Confirms that Goods/Services delivered Complaint is resolved", benefVpa: "")
                imgForTrnsStatus.image = UIImage(named: "complete_statusImg")
                
                imgTrsnIndicator.image = UIImage(named: "transIndicatior_five")

                lblTransStatus.text = "Completed"


            }
            
        case "DRC102", "DRC103", "DRC104":
            
            if tranHistoryObjs?.disputeStatus?.caseInsensitiveCompare("failure") == .orderedSame {
                
                lblRaiseSet.text = "Your complain not resolved as your payment to\n\(tranHistoryObjs?.creditVpa) has failed\nand money is reversed back to your\naccount"
                btnRaise.isHidden = true
                self.sendNotificationToApp(isSent: true, type: "pr2c", title: "Complaint Not resolved", msgBody: "Your complain not resolved as your payment to \(tranHistoryObjs?.creditVpa) has failed and money is reversed back to your account", benefVpa: "")

            }else {
                lblRaiseSet.text = String(format: NSLocalizedString("Payment has failed and money is reversed back to your account", comment: ""), tranHistoryObjs?.creditVpa ?? "")
                btnRaise.isHidden = true
                self.sendNotificationToApp(isSent: true, type: "pr2c", title: "Payment failed", msgBody: "Payment has failed and money is reversed back to your account", benefVpa: "")

            
            }
            
        case "NAC3202":
            
            lblRaiseSet.text = "Your complain resolved with dispute reason not valid for this transaction."
            btnRaise.isHidden = true
            self.sendNotificationToApp(isSent: true, type: "pr2c", title: "Complaint not raised yet", msgBody: "Your complain resolved with dispute reason not valid for this transaction.", benefVpa: "")

            
        case "NACU048":
            
            lblRaiseSet.text = "Your complaint not raised as transaction ID is not present."
            btnRaise.isHidden = true
            self.sendNotificationToApp(isSent: true, type: "pr2c", title: "Complaint not raised yet", msgBody: "Your complaint not raised as transaction ID is not present.", benefVpa: "")

        case "NAC8011":
            
            lblRaiseSet.text = NSLocalizedString("your complain not processed as the transaction id is invalid", comment: "")
            btnRaise.isHidden = true
            self.sendNotificationToApp(isSent: true, type: "pr2c", title: "Invalid transaction ID", msgBody: "your complain not processed as the transaction id is invalid.", benefVpa: "")

        case "PR2C106":
            
            if tranHistoryObjs?.disputeStatus?.caseInsensitiveCompare("success") == .orderedSame {
                lblRaiseSet.text = "Your complain resolved with success as payee responds refund will be initiated"
                btnRaise.isHidden = true
                self.sendNotificationToApp(isSent: true, type: "PR2C106", title: "Complaint resolved successfully", msgBody: "Your complain resolved with success as payee responds refund will be initiated", benefVpa: "")

                
            }else {
                lblRaiseSet.text = "Your complain resolution is failed as payee responds for refund will not be initiated"
                btnRaise.isHidden = true
                self.sendNotificationToApp(isSent: true, type: "PR2C106", title: "Complaint resolution is failed", msgBody: "Your complain resolution is failed as payee responds for refund will not be initiated", benefVpa: "")

            }
            
            
        case "PR2C105":
            
            if tranHistoryObjs?.disputeStatus?.caseInsensitiveCompare("failure") == .orderedSame {
                
                lblRaiseSet.text = "Your complain resolved with failure as Payee Confirms that Goods/Services not delivered"
                
                btnRaise.isHidden = true
                self.sendNotificationToApp(isSent: true, type: "pr2c", title: "Your Complaint is not resolved", msgBody: "Your complain resolved with failure as Payee Confirms that Goods/Services not delivered", benefVpa: "")

                
            }else {
                lblRaiseSet.text = "Payee Confirms that Goods/Services delivered Complaint is resolved"
                btnRaise.isHidden = true
                self.sendNotificationToApp(isSent: true, type: "pr2c", title: "Your Complaint is resolved", msgBody: "Payee Confirms that Goods/Services delivered Complaint is resolved", benefVpa: "")
                
                imgForTrnsStatus.image = UIImage(named: "complete_statusImg")
                
                imgTrsnIndicator.image = UIImage(named: "transIndicatior_five")

                lblTransStatus.text = "Completed"
            }
            
            
        default:
            break
        }
    }
    
    
    
    
    
    func checkStatus() {
        generateRRNStr = Common.shared.generateRRN()
        
        // CheckStatusInput
        let txnIdStr = tranHistoryObjs?.tranid ?? ""
        
        let checkStatus = CheckStatusInput(
            mobilenumber: "91\(Common.shared.phoneNo ?? "")",
            tranid: txnIdStr,
            initiatedby: "U1",
            subtype: "TXNDISPUTE",
            rrn: generateRRNStr,
            orderid: "\(orderIdsStr)MPT",
            flag: "Y"
        )
        
        var strCheckStInput = ""
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(checkStatus)
            print("jsonData =====>>", jsonData)
            
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strCheckStInput = jsonString
                print("strCheckStInput =====>>", strCheckStInput)
                print("jsonString =====>>", jsonString)
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
//
        DispatchQueue.global(qos: .background).async {
            OliveUpiManager.checkStatus(check: strCheckStInput) { data, error in
                
                print("datan1========", data ?? "")
                print("error 2=====", error ?? "")
                
                
                
                
                // Safely unwrap data as a dictionary
                if let dt = data as? [String: Any] {
                    
                    print("dt =======",dt)
                    
                    // Extract disputeStatus from the dictionary
                    let disputeStatus = dt["disputeStatus"] as? String ?? ""
                    
                    print("disputeStatus==============",disputeStatus)
                    
                    
                    // Extract disputeStatus from the dictionary
                    let disputeRc = dt["disputeRc"] as? String ?? ""
                    
                    print("disputeRc==============",disputeRc)
                    
                    self.responseDictFromCheck = dt as NSDictionary
                    
                    // Hide lblRaiseSet if disputeStatus is not empty
                    DispatchQueue.main.async {
                        
                        
                        self.checkDisputeReasonP2M(code: disputeRc)
                        
                        
                        if disputeStatus == "" {
                           // self.lblRaiseSet.text = "Complaint not raised yet"
                            self.btnRaise.isHidden = false
                            self.updateDateTimehidedata(responseDictFromCheck: self.responseDictFromCheck as! [String : Any])
                            self.raisedHideandShow()
                            self.raisedbuttonhideshowsss()
                            
                            
                        } else {
                        
                            //   
                            //self.lblRaiseSet.text = "Complaint not raised yet"
                            self.btnRaise.isHidden = true
                            self.raisedHideandShow()
                            self.raisedbuttonhideshowsss()
                            self.checkDisputeReasonP2M(code: disputeRc)
                            
                            
                        }
                    }
                }
                
                
                // Directly print the raw data received from the server
                print("Raw response data from server: \(String(describing: data))")
                
                // Detailed Error Handling
                if let err = error {
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        // Print the full error description and details
                        self.statusCodeStr=err.domain
                        
                        print("Error Details: \(err)")
                        print("Error Domain: \(err.domain)")
                        print("Error Code: \(err.code)")
                        print("Error User Info: \(err.userInfo)")
                        print("Error Description: \(err.localizedDescription)")
                    }
                    return
                }
                
                
                // Handle data if available
                guard let unwrappedData = data else {
                    print("Error: Received nil data from server.")
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                    }
                    return
                }
                
                // Print the data if it's a dictionary
                if let dt = unwrappedData as? [String: Any] {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: dt, options: .prettyPrinted)
                        if let jsonString = String(data: jsonData, encoding: .utf8) {
                            print("Server response data (as JSON): \n\(jsonString)")
                        }
                    } catch {
                        print("Error converting dictionary to JSON string: \(error)")
                    }
                    
                    // Extract disputeStatus
                    let disputeStatus = dt["disputeStatus"] as? String ?? ""
                    
                    let disputeRc = dt["disputeRc"] as? String ?? ""
                    
                    // Hide lblRaiseSet if disputeStatus is not empty
                    DispatchQueue.main.async {
                        if disputeStatus.isEmpty {
                            if self.tranHistoryObjs?.mcc == "0000"{
                                self.lblRaiseSet.text = ""
                            }else{
                                self.lblRaiseSet.text = "Complaint not raised yet"
                            }
                            self.btnRaise.isHidden = false
                            self.updateDateTimehidedata(responseDictFromCheck: self.responseDictFromCheck as! [String : Any])
                            self.raisedHideandShow()
                            self.raisedbuttonhideshowsss()
                        } else {
                            self.btnRaise.isHidden = true
                            self.raisedHideandShow()
                            self.raisedbuttonhideshowsss()
                            self.checkDisputeReasonP2M(code: disputeRc)
                            
                            
                        }
                    }
                    
                } else if let dtString = unwrappedData as? String {
                    // If the response is already a string, print it directly
                    print("Server response as string: \n\(dtString)")
                    
                    // Optionally, convert to JSON dictionary and print
                    if let jsonData = dtString.data(using: .utf8) {
                        do {
                            if let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                                print("Converted response to dictionary: \(jsonDict)")
                            }
                        } catch {
                            print("Error converting string to dictionary: \(error)")
                        }
                    }
                } else {
                    // If data cannot be cast or printed directly
                    print("Unhandled data type or empty response.")
                }
                
                
            }
        }
    }
    
    
    
    
    
    
    
    func fadeOutRaiseView() {
        UIView.animate(withDuration: 1.0) {
            self.raiseView.alpha = 0.0
        }
    }
    
    
    
    
    func raisedHideandShow(){
        
        print("mcc ======")
        
        print("tranHistoryObjs?.mcc========1",tranHistoryObjs?.mcc)
        print("tranHistoryObjs=====",tranHistoryObjs)
        
        print("statusCodeStr", statusCodeStr)
        
        // P2P Case Pay
        
        if tranHistoryObjs?.mcc == "0000" || tranHistoryObjs?.mcc == nil {
            btnRaise.isHidden = true
            if tranHistoryObjs?.status == "F" {
                lblRaiseSet.text = "This transaction failed."
                + "\nIf any amount get deducted, it will be reversed in your account within 3 working days." +
                "\nIf not reversed you may contact your bank or raise a complaint"
//
                if self.statusCodeStr == "UT" {
                    btnRaise.isHidden = false
                } else {
                    btnRaise.isHidden = true
                }
            }
            else if tranHistoryObjs?.status == "P" {
                lblRaiseSet.text = "Your transaction Status is pending." +
                "\nMoney will get credited in receiver's account within a day." +
                "\nIf not credited you may contact your bank or raise a complaint."
            }
            else if tranHistoryObjs?.status == "D" {
                lblRaiseSet.text = "Your transaction Status is deemed." +
                "\nMoney will get credited in receiver's account within a day." +
                "\nIf not credited you may contact your bank or raise a complaint."
                btnRaise.isHidden = false
            }
            
        }
        
        // P2M  Merchant ==========>>>
        
        
        else if tranHistoryObjs?.mcc != nil && tranHistoryObjs?.mcc != "0000" {
            
            if tranHistoryObjs?.status == "C"{
                btnRaise.isHidden = false
                updateDateTimehidedata(responseDictFromCheck: responseDictFromCheck as! [String : Any])
                
            }
            
            else if tranHistoryObjs?.status == "D"{
                btnRaise.isHidden = false
                self.lblRaiseSet.text = "Complaint not raised yet"
                updateDateTimehidedata(responseDictFromCheck: responseDictFromCheck as! [String : Any])
                
            }
            
            else if tranHistoryObjs?.status == "F"{
                btnRaise.isHidden = true
                updateDateTimehidedata(responseDictFromCheck: responseDictFromCheck as! [String : Any])
                
                if self.statusCodeStr == "UT" {
                    self.lblRaiseSet.text = "Complaint not raised yet"
                    btnRaise.isHidden = false
                } else {
                    btnRaise.isHidden = true
                }
                
            }
            
            else if tranHistoryObjs?.status == "P"{
                btnRaise.isHidden = false
                self.lblRaiseSet.text = "Complaint not raised yet"
                updateDateTimehidedata(responseDictFromCheck: responseDictFromCheck as! [String : Any])
                
            }
            
            else if tranHistoryObjs?.status == "R"{
                btnRaise.isHidden = true
                updateDateTimehidedata(responseDictFromCheck: responseDictFromCheck as! [String : Any])
                
            }
        }
        
    }
    
    
    
    //
    //    func raisedbuttonhideshowsss(){
    //        // P2P Case Pay
    //
    //        print("responseDictFromCheck==============",responseDictFromCheck)
    //        print("responseDictFromCheckas? String mcc",responseDictFromCheck["mcc"] as? String)
    //
    ////        if let mcc = responseDictFromCheck["mcc"] as? String {
    ////
    //
    //
    //        if let mcc = responseDictFromCheck["mcc"] as? String {
    //            if mcc == nil  || mcc == "0000"  {
    //
    //                if let status = responseDictFromCheck["status"] as? String {
    //                    if status == "S" || status == "D" {
    //                        btnRaise.isHidden = false
    //                       updateDateTimehidedata(responseDictFromCheck: responseDictFromCheck as! [String : Any])
    //                    }
    //                    else if status == "F" || status == "R" {
    //                        btnRaise.isHidden = false
    //                    }
    //                    else {
    //                        btnRaise.isHidden = true
    //                    }
    //                }
    //            }
    //        }
    //
    //
    //
    //
    //      else
    //        {
    //            if let status = responseDictFromCheck["status"] as? String {
    //                switch status {
    //                case "C", "D", "P", "S":
    //                    btnRaise.isHidden = false
    //                updateDateTimehidedata(responseDictFromCheck: responseDictFromCheck as! [String: Any])
    //                case "F":
    //                    btnRaise.isHidden = false
    //                    // You can choose to call updateDateTime here if needed
    //                default:
    //                    btnRaise.isHidden = true
    //                }
    //            }
    //        }
    //
    //
    //    }
    
    
    func raisedbuttonhideshowsss() {
        // P2P Case Pay
        
        print("responseDictFromCheck==============", responseDictFromCheck)
        print("responseDictFromCheck as? String mcc", responseDictFromCheck["mcc"] as? String)
        
        
        
        // If mcc is nil, set btnRaise.isHidden to false
        //        if responseDictFromCheck["mcc"] == nil {
        //            btnRaise.isHidden = true
        //            return
        //        }
        
        
        
        if let mcc = responseDictFromCheck["mcc"] as? String {
            
            if mcc == "0000" {
                if let status = responseDictFromCheck["status"] as? String {
                    if status == "S" || status == "D" {
                        btnRaise.isHidden = false
                        updateDateTimehidedata(responseDictFromCheck: responseDictFromCheck as! [String: Any])
                    } else if status == "F" || status == "R" {
                        btnRaise.isHidden = false
                    } else {
                        btnRaise.isHidden = true
                    }
                }
            } else {
                if let status = responseDictFromCheck["status"] as? String {
                    switch status {
                    case "C", "D", "P", "S":
                        btnRaise.isHidden = false
                        updateDateTimehidedata(responseDictFromCheck: responseDictFromCheck as! [String: Any])
                    case "F":
                        btnRaise.isHidden = false
                    default:
                        btnRaise.isHidden = true
                    }
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func btnRaiseClicked(_ sender: UIButton) {
        
        self.btnRaiseQueryClicked()
        
        //        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        //        let vc = storyBoard.instantiateViewController(withIdentifier: "RaiseComplainVC") as! RaiseComplainVC
        //       // vc.tranHistoryObj = tranHistoryArr[indexPath.row]
        //       // vc.accountDetails = self.accountDetails
        //        self.navigationController?.pushViewController(vc, animated: true)
        
        print("tranHistoryObjs?.mcc========2",tranHistoryObjs?.mcc)
        
        
        if let beneReversalRespCode = responseDictFromCheck["beneReversalRespCode"] as? String {
            if beneReversalRespCode == "RB" {
//                let popOverVC = self.storyboard?.instantiateViewController(withIdentifier: "RaiseQueryPopUpView2")  as! RaiseQueryPopUpView2
//                popOverVC.responseDictFromCheck = self.responseDictFromCheck
//                popOverVC.tranHistoryObjss = self.tranHistoryObjs
//                
//                popOverVC.view.frame = self.view.frame
//                // popOverVC.delegatePopPassengers = self
//                
//                self.view.addSubview(popOverVC.view)
//                self.addChild(popOverVC)
                
            }
            
        }
        
        else  if let remitterReversalRespCode = responseDictFromCheck["remitterReversalRespCode"] as? String {
            if remitterReversalRespCode == "RR" {
               /* let popOverVC = self.storyboard?.instantiateViewController(withIdentifier: "RaiseQueryPopUpView2")  as! RaiseQueryPopUpView2
                popOverVC.responseDictFromCheck = self.responseDictFromCheck
                popOverVC.tranHistoryObjss = self.tranHistoryObjs
                
                popOverVC.view.frame = self.view.frame
                // popOverVC.delegatePopPassengers = self
                
                self.view.addSubview(popOverVC.view)
                self.addChild(popOverVC)*/
                
            }
            
        }

        
        
        
        else if tranHistoryObjs?.mcc == "0000"{
            
            
            if let status = responseDictFromCheck["status"] as? String {
                if status == "D" {
                    //                    let popOverVC = self.storyboard?.instantiateViewController(withIdentifier: "RaiseQueryPopUpView2")  as! RaiseQueryPopUpView2
                    //                    popOverVC.responseDictFromCheck = self.responseDictFromCheck
                    //                    popOverVC.tranHistoryObjss = self.tranHistoryObjs
                    //
                    //                    popOverVC.view.frame = self.view.frame
                    //                    // popOverVC.delegatePopPassengers = self
                    //
                    //                    self.view.addSubview(popOverVC.view)
                    //                    self.addChild(popOverVC)
                    
                    
                    btnRaiseQueryClicked()
                    
                    
                }
            }
            
            
        }
        
        
        
        
        
        else if tranHistoryObjs?.mcc == tranHistoryObjs?.mcc{
            if let status = tranHistoryObjs?.status {
                if status == "D" || status == "C" {
                    self.openP2MComplaintReasonPopup()
                }
            }
        }
        else{
            let popOverVC = self.storyboard?.instantiateViewController(withIdentifier: "RaiseQueryPopUpView")  as! RaiseQueryPopUpView
            popOverVC.responseDictFromCheck = self.responseDictFromCheck
            popOverVC.tranHistoryObjss = self.tranHistoryObjs
            
            popOverVC.view.frame = self.view.frame
            // popOverVC.delegatePopPassengers = self
            
            self.view.addSubview(popOverVC.view)
            self.addChild(popOverVC)
            
        }
        
    }
    
    fileprivate func openP2MComplaintReasonPopup() {
        let popOverVC = self.storyboard?.instantiateViewController(withIdentifier: "RaiseQueryPopUpView")  as! RaiseQueryPopUpView
        popOverVC.responseDictFromCheck = self.responseDictFromCheck
        popOverVC.tranHistoryObjss = self.tranHistoryObjs
        
        popOverVC.view.frame = self.view.frame
        // popOverVC.delegatePopPassengers = self
        
        self.view.addSubview(popOverVC.view)
        self.addChild(popOverVC)
    }
    
    func btnRaiseQueryClicked() {
             
        if self.tranHistoryObjs?.mcc == "0000"{
            if self.statusCodeStr == "UT" {
                raiseQuery(reqAdjFlag: "PBRB", reqAdjCode: "U005")
            } else  {
                raiseQuery(reqAdjFlag: "PBRB", reqAdjCode: "U010")

            }
        }else{
            if self.statusCodeStr == "UT" {
                raiseQuery(reqAdjFlag: "PBRB", reqAdjCode: "U009")
            }
        }
        
    }
    
    
    
    
    func raiseQuery(reqAdjFlag: String, reqAdjCode: String) {
        print("Raising query with reqAdjFlag: \(reqAdjFlag), reqAdjCode: \(reqAdjCode)")
        SwiftLoader.show(animated: true)
        let raisedDetails = ReqComplientVo(orgTxnId: ["tranid"] as? String ?? tranHistoryObjs?.tranid , reqAdjFlag: reqAdjFlag, reqAdjCode: reqAdjCode , initiationMode: "U1", subType: "PAYER", type: "COMPLAINT")
        
        var strraisedDetails = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(raisedDetails)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strraisedDetails = jsonString
                print("strraisedDetails ===>", strraisedDetails)
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        OliveUpiManager.raiseComplaint(check: strraisedDetails) { data, error in
            if let err = error {
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                    if err.code == 102 {
                        self.showErrorAlert(err.localizedDescription)
                        if err.domain == "046" {
                            self.lblRaiseSet.text = "\(err.localizedDescription)"
                            self.btnRaise.isHidden = true
                            self.sendNotificationToApp(isSent: true, type: "pr2c", title: "Compalint not resolved ", msgBody: "\(err.localizedDescription)", benefVpa: "")
                        }
                    } else if err.code == 401 || err.code == 107 {
                        self.configuration()
                        return
                    } else {
                        self.showErrorAlert(err.localizedDescription)
                    }
                }
                
            } else if let dt = data as? [String: Any], let crnNumber = dt["crn"] as? String {
                
                print("dt=========================>> ",dt)
                
                
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                    self.showToast(message: "Your complaint is raised successfully with CRN no: \(crnNumber)", font: .systemFont(ofSize: 12))
                    
                    self.btnRaise.isHidden = true
                    
                    
                    if self.showToast(message: "Your complaint is raised successfully with CRN no: \(crnNumber)", font: .systemFont(ofSize: 12)) == self.showToast(message: "Your complaint is raised successfully with CRN no: \(crnNumber)", font: .systemFont(ofSize: 12)){
                        self.btnRaise.isHidden = true
                    }
                    
                    
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "BhimTransactionNextDetailsVC") as! BhimTransactionNextDetailsVC
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    
                    
                }
            } else {
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                    self.showErrorAlert("Failed to raise complaint. Please try again later.")
                }
            }
        }
    }
    
    
    
    
    
    
    
    
}


extension BhimTransactionNextDetailsVC: MFMessageComposeViewControllerDelegate {
    
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
        
        print("jsonString ========>> ", jsonString)
        
        
        
        OliveUpiManager.initiateSDK(sdkHandshake: jsonString,view: self , delegate: self) { (data, err) in
            print("The data is:\(String(describing: data))")
            // self.raiseQuery()
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
                    // self.raiseQuery()
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
    
    public func sendNotificationToApp(isSent: Bool, type: String, title: String, msgBody: String, benefVpa: String) {
        // Retrieve userToken from shared preferences
        guard let userToken = Common.shared.token else {
            print("Error: User token is not available")
            return
        }
        
        // URL for sending notification
        guard let url = URL(string: "https://api.maxupi.in/api/v1/notification/send-notification") else {
            print("Error: Invalid URL")
            return
        }
        
        // Create JSON object with parameters
        let postParam: [String: Any] = [
            "skey": "AVJQIdwn79iR0zlP0iKNKumME",
            "isSent": isSent,
            "notificaton_type": type,
            "title": title,
            "messagebody": msgBody,
            "beneVpa": benefVpa
        ]
        
        // Prepare the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            // Set the request body with JSON
            let bodyData = try JSONSerialization.data(withJSONObject: postParam, options: [])
            request.httpBody = bodyData
        } catch {
            print("Error: Unable to serialize JSON: \(error)")
            return
        }
        
        // Make the network call
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Ensure there's no error in the request
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            // Ensure we have a valid response and data
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error: Server returned an invalid response")
                return
            }
            
            guard let data = data else {
                print("Error: No data received")
                return
            }
            
            // Parse the JSON response
            do {
                if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let success = jsonObject["success"] as? String, success == "success" {
                        let msg = jsonObject["message"] as? String ?? "No message received"
                        print("onResponse: \(msg)")
                    } else {
                        print("Error: Failed with response: \(jsonObject)")
                    }
                } else {
                    print("Error: Unable to parse response as JSON")
                }
            } catch {
                print("Error: JSON parsing failed: \(error)")
            }
        }
        
        // Start the task
        task.resume()
    }
}


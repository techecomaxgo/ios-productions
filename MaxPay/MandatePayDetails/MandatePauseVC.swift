//
//  MandatePauseVC.swift
//  MaxPay
//
//  Created by Ios Developer on 14/05/24.
//

import UIKit
import DatePicker
import SwiftLoader
import OlivePayLibrary


class MandatePauseVC: BaseVC {
    
    var validend : String?
    var validstart : String?
    
    var strtDateStr : String?
    var endDateStr : String?
    
    var accountDetails: AccountDetailsOnIIN?

    var umnIDGener = ""
    var umnStr = ""
    
    @IBOutlet weak var btnPause: DesignableButton!
    
    @IBOutlet weak var txtStartDate: UITextField!
    
    
    @IBOutlet weak var txtEndDate: UITextField!
    
    
    var mandatePauseTransactionData: MandateTransactionModel?

    
    var mandateObject: MandateListModel?

//    
//    override func viewDidLoad() {
//        
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        if mandatePauseTransactionData != nil {
//            
//         //   print(mandatePauseTransactionData)
//
//            
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "ddMMyyyy"
//            let endDate = dateFormatter.date(from: mandatePauseTransactionData?.validity_end ?? "")
//            let strtDate = dateFormatter.date(from: mandatePauseTransactionData?.validity_start ?? "")
//
//            // change to local time zone from your format
//            dateFormatter.dateFormat = "dd MMM yyyy"
//            dateFormatter.timeZone = TimeZone.current
//            let EndString = dateFormatter.string(from: endDate!)
//            let StrtDateString = dateFormatter.string(from: strtDate!)
//            //print(DateString)
//        
//            txtStartDate.text = StrtDateString
//           // strtDateStr = StrtDateString
//            
//            
//            txtEndDate.text = EndString
//            //endDateStr = EndString
//            
//            
//            
//            print("endDate===========",endDate)
//            print("strtDate ==============",strtDate)
//            
//            
//        }
//        
//        
//        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if mandatePauseTransactionData != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "ddMMyyyy"

            if let endDateStr = mandatePauseTransactionData?.validity_end,
               let endDate = dateFormatter.date(from: endDateStr) {
                dateFormatter.dateFormat = "dd MMM yyyy"
                dateFormatter.timeZone = TimeZone.current
                let EndString = dateFormatter.string(from: endDate)
                txtEndDate.text = EndString
            }

            if let startDateStr = mandatePauseTransactionData?.validity_start,
               let startDate = dateFormatter.date(from: startDateStr) {
                dateFormatter.dateFormat = "dd MMM yyyy"
                dateFormatter.timeZone = TimeZone.current
                let StrtDateString = dateFormatter.string(from: startDate)
                txtStartDate.text = StrtDateString
            }

            print("endDate===========", mandatePauseTransactionData?.validity_end ?? "")
            print("strtDate ==============", mandatePauseTransactionData?.validity_start ?? "")
        }
    }

    
    
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnPauseClicked(_ sender: UIButton) {
        
        pauseMandate()
        
    }
    
    func pauseMandate() {
 
        if self.validend != nil || self.validstart != nil {

            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "dd MMM yyyy"
           
            let endDate = dateFormatter.date(from: self.validend ?? "")
            let strtDate = dateFormatter.date(from: self.validstart ?? "")

            // change to local time zone from your format
            dateFormatter.dateFormat = "ddMMyyyy"
            dateFormatter.timeZone = TimeZone.current
            
            let EndString = dateFormatter.string(from: endDate!)
            let StrtDateString = dateFormatter.string(from: strtDate!)
            

            strtDateStr = StrtDateString
            
            endDateStr = EndString
 
            
        }else{
    
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "dd MMM yyyy"
           
            let endDate = dateFormatter.date(from: txtStartDate.text ?? "")
            let strtDate = dateFormatter.date(from: txtEndDate.text ?? "")

            // change to local time zone from your format
            dateFormatter.dateFormat = "ddMMyyyy"
            dateFormatter.timeZone = TimeZone.current
            let EndString = dateFormatter.string(from: endDate!)
            let StrtDateString = dateFormatter.string(from: strtDate!)
            
            strtDateStr = StrtDateString
            endDateStr = EndString
            
            
            
        }
 
   
        
        let accountDetails = AccountPay(name: accountDetails?.name ?? "", mmid: accountDetails?.mmid ?? "", aeba: accountDetails?.aeba ?? "", mbeba: accountDetails?.mbeba ?? "", accRefNumber: accountDetails?.accRefNumber ?? "", ifsc: accountDetails?.ifsc ?? "", maskedAccnumber: accountDetails?.maskedAccnumber ?? "", status: accountDetails?.status ?? "", type: accountDetails?.type ?? "", vpa: accountDetails?.vpa ?? "", dLength: accountDetails?.dLength ?? "", dType: accountDetails?.dType ?? "", balance: accountDetails?.balance ?? "", balTime: accountDetails?.balTime ?? "", accountIfsc: accountDetails?.ifsc ?? "", iin: accountDetails?.iin ?? "")
        
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
        
        
        
       
        
        umnStr = randomString(length: 32)
        
      

        
        let  baneObject = baneVpaModel(vpa: mandateObject?.payeeVpa ?? "", name:mandateObject?.beneName ?? "")
        
       
        
     
        let pShareto = mandatePauseTransactionData?.shareToPayee ?? ""
       
        let mandaName = mandatePauseTransactionData?.mandateName ?? ""
        let amounRule = mandatePauseTransactionData?.amountRule ?? ""
        let amount = mandatePauseTransactionData?.amount ?? ""

        let recurPattern = mandatePauseTransactionData?.recurrencePattern ?? ""
        

        
        
        let mandateInput =  PauseMandateInput(umn: mandatePauseTransactionData?.umn ?? "", mandatetype: "PAUSE", remark: "UPI MANDATE", purpose: "14", sharetopayee: pShareto, validitystart: strtDateStr, validityend: endDateStr, mandatename: mandaName, revocable: "Y", amountrule: amounRule, amount: amount, recurrence: recurPattern, rulevalue: "04", ruletype: "ON", executebypayeepsp: "Y", blockfund: "N", monthlylimit: "", mcc: "0000", initmode: "00", orderid: "00", refcategory: "00", refurl: "00")
        
       

        
        
        
        var strMandateInput = ""
        
        var strBaneObj = ""
        
      
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(baneObject)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strBaneObj = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(mandateInput)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strMandateInput = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        DispatchQueue.global(qos: .background).async {
            

            OliveUpiManager.createMandate(account: strAccountDetails,  beneVpa: strBaneObj, mandateInput:strMandateInput, viewController: self) { data, error in

          
                if let err = error {
                    if err.code == 102 || err.code == 108 { // 102 VPA not allowed for this customer, 108 Location has No access
                        DispatchQueue.main.async {
                            self.showErrorAlert(err.localizedDescription)
                        }
                    } else if err.code == 401 || err.code == 107 {
                        
                       // self.configuration()
                        return
                        
                    }
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                    }
                    
                } else {
                    
                    if let dt = data {
                       // print(dt)
                        
                        DispatchQueue.main.async {
                            
                            SwiftLoader.hide()
                            
                            self.showToast(message: dt as! String)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                self.navigationController?.popViewController(animated: true)
                                for controller in self.navigationController!.viewControllers as Array {
                                           if controller.isKind(of: MandateListVC.self) {
                                               self.navigationController!.popToViewController(controller, animated: true)
                                               break
                                           }
                                       }
                               
                                
                                
                            })
                        }
                    }
                }
            }
        }
        
        
        
        
    }
    

    
    func unPauseMandate() {
        
      
        if self.validend != nil || self.validstart != nil {
            
           // print("yes")
            
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "dd MMM yyyy"
           
            let endDate = dateFormatter.date(from: self.validend ?? "")
            let strtDate = dateFormatter.date(from: self.validstart ?? "")

            // change to local time zone from your format
            dateFormatter.dateFormat = "ddMMyyyy"
            dateFormatter.timeZone = TimeZone.current
            
            let EndString = dateFormatter.string(from: endDate!)
            let StrtDateString = dateFormatter.string(from: strtDate!)
            

            strtDateStr = StrtDateString
            
            endDateStr = EndString
            
        
            
        }else{
            
          
            
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "dd MMM yyyy"
           
            let endDate = dateFormatter.date(from: txtStartDate.text ?? "")
            let strtDate = dateFormatter.date(from: txtEndDate.text ?? "")

            // change to local time zone from your format
            dateFormatter.dateFormat = "ddMMyyyy"
            dateFormatter.timeZone = TimeZone.current
            let EndString = dateFormatter.string(from: endDate!)
            let StrtDateString = dateFormatter.string(from: strtDate!)
            

            strtDateStr = StrtDateString
            
            endDateStr = EndString
            
            
            
        }
 
        
 
        
        let accountDetails = AccountPay(name: accountDetails?.name ?? "", mmid: accountDetails?.mmid ?? "", aeba: accountDetails?.aeba ?? "", mbeba: accountDetails?.mbeba ?? "", accRefNumber: accountDetails?.accRefNumber ?? "", ifsc: accountDetails?.ifsc ?? "", maskedAccnumber: accountDetails?.maskedAccnumber ?? "", status: accountDetails?.status ?? "", type: accountDetails?.type ?? "", vpa: accountDetails?.vpa ?? "", dLength: accountDetails?.dLength ?? "", dType: accountDetails?.dType ?? "", balance: accountDetails?.balance ?? "", balTime: accountDetails?.balTime ?? "", accountIfsc: accountDetails?.ifsc ?? "", iin: accountDetails?.iin ?? "")
        
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
        
        
        
      
        
        umnIDGener = mandateObject?.txnid ?? ""
        
     
        umnStr = randomString(length: 32)
        
     

        
        let  baneObject = baneVpaModel(vpa: mandateObject?.payeeVpa ?? "", name:mandateObject?.beneName ?? "")
        
       
        
      
        let pShareto = mandatePauseTransactionData?.shareToPayee ?? ""
     
        let mandaName = mandatePauseTransactionData?.mandateName ?? ""
        let amounRule = mandatePauseTransactionData?.amountRule ?? ""
        let amount = mandatePauseTransactionData?.amount ?? ""

        let recurPattern = mandatePauseTransactionData?.recurrencePattern ?? ""
        

        
        
        let mandateInput =  PauseMandateInput(umn: mandatePauseTransactionData?.umn ?? "", mandatetype: "PAUSE", remark: "UPI MANDATE", purpose: "14", sharetopayee: pShareto, validitystart: strtDateStr, validityend: endDateStr, mandatename: mandaName, revocable: "Y", amountrule: amounRule, amount: amount, recurrence: recurPattern, rulevalue: "04", ruletype: "ON", executebypayeepsp: "Y", blockfund: "N", monthlylimit: "", mcc: "0000", initmode: "00", orderid: "00", refcategory: "00", refurl: "00")
        
    
        var strMandateInput = ""
        
        var strBaneObj = ""
        
      
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(baneObject)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strBaneObj = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted  // Add this line if you want the output to be formatted for better readability
            let jsonData = try encoder.encode(mandateInput)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strMandateInput = jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        DispatchQueue.global(qos: .background).async {
            

            OliveUpiManager.createMandate(account: strAccountDetails,  beneVpa: strBaneObj, mandateInput:strMandateInput, viewController: self) { data, error in

          
                
                if let err = error {
                    if err.code == 102 || err.code == 108 { // 102 VPA not allowed for this customer, 108 Location has No access
                        DispatchQueue.main.async {
                            self.showErrorAlert(err.localizedDescription)
                        }
                    } else if err.code == 401 || err.code == 107 {
                        
                       // self.configuration()
                        return
                        
                    }
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                    }
                    
                } else {
                    
                    if let dt = data {
                       // print(dt)
                        
                        DispatchQueue.main.async {
                            
                            SwiftLoader.hide()
                            
                            self.showToast(message: dt as! String)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                self.navigationController?.popViewController(animated: true)
                                for controller in self.navigationController!.viewControllers as Array {
                                           if controller.isKind(of: MandateListVC.self) {
                                               self.navigationController!.popToViewController(controller, animated: true)
                                               break
                                           }
                                       }
                               
                                
                                
                            })
                        }
                    }
                }
            }
        }
        
        
        
        
    }
    
    
    
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyz"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    
    @IBAction func btnStartDateClicked(_ sender: UIButton) {
        
//        let date = Date()
//        let calendar = Calendar.current
//        
//        self.view.endEditing(true)
//        
//        let minDate = DatePickerHelper.shared.dateFrom(day: calendar.component(.day, from: date), month:calendar.component(.month, from: date), year: calendar.component(.year, from: date))!
//        let maxDate = DatePickerHelper.shared.dateFrom(day: 01, month: 08, year: 2024)!
//        let today = Date()
//        // Create picker object
//        let datePicker = DatePicker()
//        // Setup
//        datePicker.setup(beginWith: today, min: minDate, max: maxDate) { (selected, date) in
//            if selected, let selectedDate = date {
//               // print(selectedDate.string())
//                let formatter = DateFormatter()
//                formatter.dateFormat = "dd MMM yyyy"
//                self.validstart = formatter.string(from: selectedDate)
//
//                self.txtStartDate.text = formatter.string(from: selectedDate)
//                
//            } else {
//                print("Cancelled")
//            }
//        }
//        // Display
//        datePicker.show(in: self, on: self.txtStartDate)
        
        let date = Date()
        let calendar = Calendar.current
        
        self.view.endEditing(true)
        
        // Check if validity_end is available and convert it to a Date object
        let maxDate: Date
        if let validityEndStr = mandatePauseTransactionData?.validity_end,
           let validityEndDate = DateFormatter.date(from: validityEndStr) {
            maxDate = validityEndDate
        } else {
            // Provide a fallback date if validity_end is not set
            maxDate = Calendar.current.date(byAdding: .year, value: 1, to: date)!
        }
        
        // Ensure minDate is set to the current date
        let minDate = date
        
        // Create and configure the DatePicker
        let datePicker = DatePicker()
        datePicker.setup(beginWith: minDate, min: minDate, max: maxDate) { (selected, date) in
            if selected, let selectedDate = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd MMM yyyy"
                self.validstart = formatter.string(from: selectedDate)
                self.txtStartDate.text = formatter.string(from: selectedDate)
            } else {
                print("Cancelled")
            }
        }
        // Display the date picker
        datePicker.show(in: self, on: self.txtStartDate)
        
        
    }
    
    
   
 
  
    
    
    
   

    
    
    
    @IBAction func btnEndDateClicked(_ sender: UIButton) {
//        let date = Date()
//        let calendar = Calendar.current
//        self.view.endEditing(true)
//        
//        let minDate = DatePickerHelper.shared.dateFrom(day: calendar.component(.day, from: date), month:calendar.component(.month, from: date), year: calendar.component(.year, from: date))!
//        let maxDate = DatePickerHelper.shared.dateFrom(day: 01, month: 08, year: 2024)!
//        let today = Date()
//        let datePicker = DatePicker()
//        // Setup
//        datePicker.setup(beginWith: today, min: minDate, max: maxDate) { (selected, date) in
//            if selected, let selectedDate = date {
//                print(selectedDate.string())
//                let formatter = DateFormatter()
//                formatter.dateFormat = "dd MMM yyyy"
//                self.validend = formatter.string(from: selectedDate)
//
//                self.txtEndDate.text = formatter.string(from: selectedDate)
//            } else {
//                print("Cancelled")
//            }
//        }
//        // Display
//        datePicker.show(in: self, on: self.txtEndDate)
        
        self.view.endEditing(true)

        // Retrieve and parse `validity_end`
        guard let endDateStr = mandatePauseTransactionData?.validity_end,
              let endDate = DateFormatter.date(from: endDateStr) else {
            print("Invalid end date")
            return
        }

        let date = Date()
        let calendar = Calendar.current

        // Set minDate to either today or the selected start date
        var minDate = date
        if let validstartStr = self.validstart,
           let validstartDate = DateFormatter.date(from: validstartStr) {
            minDate = validstartDate
        }

        // Set maxDate to endDate
        let maxDate = endDate

        // Configure and display date picker
        let datePicker = DatePicker()
        datePicker.setup(beginWith: minDate, min: minDate, max: maxDate) { (selected, date) in
            if selected, let selectedDate = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd MMM yyyy"
                self.validend = formatter.string(from: selectedDate)
                self.txtEndDate.text = formatter.string(from: selectedDate)
            } else {
                print("Cancelled")
            }
        }
        datePicker.show(in: self, on: self.txtEndDate)
        
    }
    
 


  
  
    
    

}




extension DateFormatter {
    static func date(from string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyy" // Your date format
        return dateFormatter.date(from: string)
    }
}



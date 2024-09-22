//
//  MandateNewReqVC.swift
//  MaxPay
//
//  Created by Admin on 08/07/24.
//

import UIKit
import DatePicker
import SwiftLoader
import OlivePayLibrary

class MandateNewReqVC: BaseVC {
    
    

    @IBOutlet weak var txtReqBy: UITextField!
    
    @IBOutlet weak var txtAmount: UITextField!
    
    @IBOutlet weak var txtStartDate: UITextField!
    
    
    @IBOutlet weak var txtFequency: UITextField!
    
    
    @IBOutlet weak var txtRemark: UITextField!
    
    @IBOutlet weak var txtEnd: UITextField!
    
    var qrData = [String:Any]()
    
    var accountDetails: AccountDetailsOnIIN?
    var checksumViewModel = SIMSelectionViewModel()

    var beneVpa = ""
    var beneName = ""
    
    var umnIDGener = ""
    var umnStr = ""
    var orderIdStr = ""
    var apiCallOption = ""
    
    var strtDateStr : String?
    var endDateStr : String?
    
    var isFromQrScan = false
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print(qrData)
        configuration()
        
        dateFormatter.dateFormat = "ddMMyyyy"
        let endDate = dateFormatter.date(from: qrData["validityend"] as? String ?? "")
        let strtDate = dateFormatter.date(from: qrData["validitystart"] as? String ?? "")

        // change to local time zone from your format
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateFormatter.timeZone = TimeZone.current
        let EndString = dateFormatter.string(from: endDate!)
        let StrtDateString = dateFormatter.string(from: strtDate!)
        //print(DateString)
    
        txtStartDate.text = StrtDateString
       // strtDateStr = StrtDateString
        
        
        txtEnd.text = EndString
        //endDateStr = EndString
        
        strtDateStr = StrtDateString
        
        endDateStr = EndString

        
        
        
        txtReqBy.text = qrData["pn"] as? String
        
        txtAmount.text = qrData["am"] as? String


        txtFequency.text = qrData["recur"] as? String
        
        txtRemark.text = qrData["tn"] as? String
    }
    
    
    
    func configuration() {
        initViewModel()
        observeEvent()
    }
    
    //MARK Network checking
    func initViewModel() {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            checksumViewModel.loginChecksumCall(Common.shared.phoneNo ?? "", Common.shared.token ?? "")
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
                //print("Data loaded...")
                if self?.checksumViewModel.checksumModel?.result == "Success" {
                    Common.shared.merchantauthtoken = self?.checksumViewModel.checksumModel?.data?.merchantauthtoken ?? ""
                    
                  //  self?.performMerchantHandshake()
                    
                }else{
                    DispatchQueue.main.async {
                        self?.showErrorAlert(self?.checksumViewModel.checksumModel?.result ?? "")
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
            //print("The data is:\(String(describing: data))")
//            if self.apiCallOption == "pay" {
//               // self.btnContinuePayAction(UIButton())
//            } else if self.apiCallOption == "bene" {
//                self.saveBeneficary(dataResp: self.transId)
//            } else if self.apiCallOption == "chkbal" {
//                self.btnCheckBalanceAction(UIButton())
//            }
        }
    }
    
    
    
    
    
    
    
    @IBAction func btnMandateCreateClicked(_ sender: UIButton) {
        
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
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
        
        
        let  baneObject = baneVpaModel(vpa: qrData["pa"] as? String, name:qrData["pn"] as? String)

        umnIDGener = qrData["tr"] as? String ?? ""
        
        umnStr = randomString(length: 25)
        
      //  orderIdStr = qrData["tr"] as? String ?? randomString(length: 32)
        
        orderIdStr = qrData["tr"] as? String ?? "OD" + randomString(length: 12)

        
        
        let mandateInput = CreateMandateInput(umn: umnStr + accessMax, mandatetype: qrData["txnType"] as? String ?? "CREATE", remark: qrData["tn"] as? String ?? "UPIMandate", purpose: qrData["purpose"] as? String ?? "", sharetopayee: "Y", validitystart: qrData["validitystart"] as? String ?? "", validityend: qrData["validityend"] as? String ?? "", mandatename: qrData["pn"] as? String ?? "", revocable: qrData["rev"] as! String, amountrule:qrData["amrule"] as? String ?? "", amount: qrData["am"] as? String ?? "", recurrence: qrData["recur"] as? String ?? "", rulevalue: qrData["recurvalue"] as? String ?? "", ruletype: qrData["recurtype"] as? String ?? "", executebypayeepsp: "Y", blockfund: qrData["block"] as? String ?? "N", monthlylimit: qrData["fam"] as? String ?? "", recurrenceValue: qrData["recurvalue"] as? String ?? "", mcc: qrData["mc"] as? String ?? "", initmode: qrData["mode"] as? String ?? "04", orderid: orderIdStr, refcategory: "00", refurl: "https://www.axis.com")
        
        
        /*
        let mandateInput =  PauseMandateInput(umn: umnStr, mandatetype: "CREATE", remark:qrData["tn"] as? String ?? "" , purpose: "14", sharetopayee: "Y", validitystart: qrData["validitystart"] as? String ?? "", validityend: qrData["validityend"] as? String ?? "", mandatename: qrData["pn"] as? String ?? "", revocable: "Y", amountrule: qrData["amrule"] as? String ?? "", amount: qrData["am"] as? String ?? "", recurrence: qrData["recur"] as? String ?? "", rulevalue:qrData["recurvalue"] as? String ?? "", ruletype: qrData["recurtype"] as? String ?? "", executebypayeepsp: "Y", blockfund: "N", monthlylimit: qrData["fam"] as? String ?? "", mcc:qrData["mc"] as? String ?? "", initmode: "04", orderid: "00", refcategory: "00", refurl: "00")
        
        */
        
        //let mandateInput = UpdatableMandateInput(umn:mandatePauseTransactionData?.umn ?? "", remarks: "UPI MANDATE", mcc: "0000", payerMobile:pMobile , purpose: "00", shareToPayee:pShareto, validityStart: "08052024", validityEnd:"15052024", mandateName: mandaName ,revocable: "Y", amountRule:amounRule , amount: amounRule , recurrence: mandatePauseTransactionData?.recurrencePattern ?? "" , ruleValue:"14", ruleType: "ON" , initiatedBy: "PAYER_INITIATED")
        
        
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
            print("jsonData ====>>>",jsonData)
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

           // OliveUpiManager.declineMandate(account: strAccountDetails, mandateInput: strMandateInput, viewController: self) { data, error in
                
                if let err = error {
                    if err.code == 102 || err.code == 108 { // 102 VPA not allowed for this customer, 108 Location has No access
                        DispatchQueue.main.async {
                            self.showErrorAlert(err.localizedDescription)
                        }
                    } else if err.code == 401 || err.code == 107 {
                        
                       // self.configuration()
                        
                        //return
                        
                    }
                    
                    
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                    }
                    
                } else {
                    
                    if let dt = data {
                    print(dt)
                   (dt as AnyObject).code
//                        
//                        DispatchQueue.main.async { [self] in
//                            SwiftLoader.hide()
//
//                            let alertController: UIAlertController
//
//                            if dt !=  nil {
//                                // Show popup with OK button
//                                self.dateFormatter.dateFormat = "ddMMyyyy"
//                                alertController = UIAlertController(title: "Success", message: "Your Mandate of ₹\(self.qrData["am"] as? String ?? "") successfully with the validity of \(self.dateFormatter.date(from: qrData["validitystart"] as? String ?? "")) to \(self.dateFormatter.date(from: qrData["validityend"] as? String ?? ""))", preferredStyle: .alert)
//                                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
//                                    // Navigate to MandateListVC
//                                    self.navigateToMandateListVC()
//                                }))
//                            } else {
//                                
//                                alertController = UIAlertController(title: "Error", message: "Your Mandate of ₹\(self.qrData["am"] as? String ?? "")  Failed Please Try Again", preferredStyle: .alert)
//                                alertController.addAction(UIAlertAction(title: "Retry", style: .default, handler: nil))
//                            }
//
//                            self.present(alertController, animated: true, completion: nil)
//                        }
                        
                        DispatchQueue.main.async { [self] in
                            SwiftLoader.hide()

                            let alertController: UIAlertController

                            if dt != nil {
                                // Set the date format to ddMMyyyy
                                self.dateFormatter.dateFormat = "ddMMyyyy"

                                // Format the start and end dates
                                let validityStart = self.dateFormatter.date(from: qrData["validitystart"] as? String ?? "")
                                let validityEnd = self.dateFormatter.date(from: qrData["validityend"] as? String ?? "")

                                // Show popup with OK button
                                alertController = UIAlertController(
                                    title: "Success",
                                    message: "Your Mandate of ₹\(self.qrData["am"] as? String ?? "") successfully with the validity of \(validityStart ?? Date()) to \(validityEnd ?? Date())",
                                    preferredStyle: .alert
                                )
                                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                                    // Navigate to MandateListVC
                                    self.navigateToMandateListVC()
                                }))
                            } else {
                                // Show error alert
                                alertController = UIAlertController(
                                    title: "Error",
                                    message: "Your Mandate of ₹\(self.qrData["am"] as? String ?? "") Failed. Please Try Again",
                                    preferredStyle: .alert
                                )
                                alertController.addAction(UIAlertAction(title: "Retry", style: .default, handler: nil))
                            }

                            // Present the alert
                            self.present(alertController, animated: true, completion: nil)
                        }

                        
                        
                        
                        
                    }
//                    
                    
                    
                    
                    
                    
                    
                
                    
                    
                    
   
                }
            }
        }
        
        
    }
    
    
//    func navigateToMandateListVC(){
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//           
//                                                                for controller in self.navigationController!.viewControllers as Array {
//                                                                           if controller.isKind(of: MandateListVC.self) {
//                                                                               self.navigationController!.pushViewController(controller, animated: true)
//                                                                               break
//                                                                           }
//                                                                       }
//    
//                                                            })
//        
//    }
    
    
    func navigateToMandateListVC() {
//        let mandateListVC = MandateListVC()
//        mandateListVC.accountDetails = self.accountDetails
//        navigationController?.pushViewController(mandateListVC, animated: true)
//        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MandateListVC") as! MandateListVC
        vc.accountDetails = accountDetails
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyz"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    
    @IBAction func btnEndDate(_ sender: UIButton) {
        
        self.view.endEditing(true)
        let minDate = DatePickerHelper.shared.dateFrom(day: 01, month: 08, year: 2021)!
        let maxDate = DatePickerHelper.shared.dateFrom(day: 01, month: 08, year: 2024)!
        let today = Date()
        // Create picker object
        let datePicker = DatePicker()
        // Setup
        datePicker.setup(beginWith: today, min: minDate, max: maxDate) { (selected, date) in
            if selected, let selectedDate = date {
                print(selectedDate.string())
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                self.txtEnd.text = formatter.string(from: selectedDate)
            } else {
                print("Cancelled")
            }
        }
        // Display
        datePicker.show(in: self, on: self.txtEnd)
    }
    
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
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


extension MandateNewReqVC: MFMessageComposeViewControllerDelegate{

    
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
                }
                
                else{
//                    if self.apiCallOption == "pay" {
//                        self.btnContinuePayAction(UIButton())
//                    } else if self.apiCallOption == "bene" {
//                        self.saveBeneficary(dataResp: self.transId)
//                    } else if self.apiCallOption == "chkbal" {
//                        self.btnCheckBalanceAction(UIButton())
//                    }
                }
            })
            break
        default:
            break
        }
    }
}

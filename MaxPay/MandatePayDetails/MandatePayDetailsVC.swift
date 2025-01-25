//
//  MandatePayDetailsVC.swift
//  MaxPay
//
//  Created by Ios Developer on 07/03/24.
//

import UIKit
import SwiftLoader
import OlivePayLibrary
import MessageUI
import GameplayKit


class MandatePayDetailsVC: BaseVC {

    @IBOutlet weak var btnApprove: DesignableButton!
    
    @IBOutlet weak var btnDecline: DesignableButton!
    
    
    private var checksumViewModel = SIMSelectionViewModel()

    @IBOutlet weak var lblStatusStr: UILabel!
    
    var umnIDGener = ""
    var umnStr = ""
    
    
    var statusStr = ""
    
    @IBOutlet weak var lblMandateVpa: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblFreq: UILabel!
    @IBOutlet weak var lblUMN: UILabel!
    @IBOutlet weak var lblValidity: UILabel!
    @IBOutlet weak var lblTransactionID: UILabel!
    
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var lblPayeeName: UILabel!
    
    @IBOutlet weak var lblStartdate: UILabel!
    
    @IBOutlet weak var lblEnddate: UILabel!
    
    @IBOutlet weak var stackRePause: UIStackView!
    
    var mandateTransactionObject: MandateTransactionModel?

    @IBOutlet weak var vwlogoPic: UIView!
    
    
    var mandateObject: MandateListModel?
    
    var accountDetails: AccountDetailsOnIIN?
    
    var isPending = false
    
    
    var tabValue = 0
    
    @IBOutlet weak var umnLblDisp: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
      //  print(mandateTransactionObject)
        
       // print(mandateObject)
        
        //print(isPending)
        
       // print(accountDetails)

        
        // Auto Pay Mandate completed
        
        vwlogoPic.layer.applyCornerRadiusShadow()
        
    
        if isPending == true{
            
            btnApprove.setTitle("Approve", for: .normal)
            btnDecline.setTitle("Decline", for: .normal)

        }else{
            
//            btnApprove.setTitle("Decline", for: .normal)
            
        }
         
        
        if mandateTransactionObject != nil {
            
            
            if mandateTransactionObject?.umn != nil{
                
                umnLblDisp.isHidden = false
                
            }else{
    
                umnLblDisp.isHidden = true
                
            }
            
            
            if tabValue == 0 {
                
                stackRePause.isHidden = false

            }else{
                
                stackRePause.isHidden = !isPending

            }
                
            
            

            lblPayeeName.text = mandateTransactionObject?.payername ?? ""
            lblMandateVpa.text = mandateTransactionObject?.payeeVpa ?? ""
            lblAmount.text = "₹ " + (mandateTransactionObject?.amount ?? "0")
            lblFreq.text = mandateTransactionObject?.recurrencePattern ?? ""
            lblUMN.text = mandateTransactionObject?.umn ?? ""
            
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "ddMMyyyy"
            let endDate = dateFormatter.date(from: mandateTransactionObject?.validity_end ?? "")
            let strtDate = dateFormatter.date(from: mandateTransactionObject?.validity_start ?? "")

            // change to local time zone from your format
            dateFormatter.dateFormat = "dd MMM yyyy"
            dateFormatter.timeZone = TimeZone.current
            let EndString = dateFormatter.string(from: endDate!)
            let StrtDateString = dateFormatter.string(from: strtDate!)
            //print(DateString)
        
            lblStartdate.text = StrtDateString
            
            lblEnddate.text = EndString
            
            
          //  lblStartdate.text = mandateTransactionObject?.validity_end ?? ""
            
           // lblEnddate.text = mandateTransactionObject?.validity_end ?? ""
            
            lblTransactionID.text = mandateTransactionObject?.txnid ?? ""
            
            statusStr =  mandateTransactionObject?.payeeStatus ?? ""
            
            
            
            if statusStr == "F"{
                
              //  lblStatus.text = "Failed"
                
            }else if statusStr == "S" {
                
                lblStatusStr.text = "Auto Pay is Active"
                
            }else if statusStr == "U" {
                
                lblStatusStr.text = "Auto Pay is Unpaused"
                
            }
            else if statusStr == "R" {
                
                lblStatusStr.text = "Autopay is Revoked"
                
            }else if statusStr == "E" {
                
                lblStatusStr.text = "Autopay is Expired"
                
            }else if statusStr == "C" {
                
               // lblStatus.text = "Completed"
                
            }else {

               // lblStatus.text = "Failed"
                
            }
            
            
        }else{
            
            if mandateObject?.umn != nil{
                
                umnLblDisp.isHidden = false
                
            }else{
    
                umnLblDisp.isHidden = true
                
            }
             
            
            
            lblPayeeName.text = mandateObject?.beneName ?? ""

            lblMandateVpa.text = mandateObject?.payeeVpa ?? ""
            lblAmount.text = "₹ " + (mandateObject?.amount ?? "0")
            lblFreq.text = mandateObject?.recurrencePattern ?? ""
            lblUMN.text = mandateObject?.umn ?? ""
            //lblValidity.text = mandateObject?.expdate ?? ""
            lblTransactionID.text = mandateObject?.txnid ?? ""
            //lblStatus.text = (mandateObject?.status ?? "") == "P" ? "Pending" : (mandateObject?.status ?? "")
            
            
            //
            
           // stackRePause.isHidden = !isPending

            
            statusStr =  mandateObject?.status ?? ""
            
            if statusStr == "P" {
                
                lblStatusStr.text = "Auto Pay is Pending"
                
            }
            
            

            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "ddMMyyyy"
            let endDate = dateFormatter.date(from: mandateObject?.validity_end ?? "")
            let strtDate = dateFormatter.date(from: mandateObject?.validity_start ?? "")

            // change to local time zone from your format
            dateFormatter.dateFormat = "dd MMM yyyy"
            dateFormatter.timeZone = TimeZone.current
            let EndString = dateFormatter.string(from: endDate!)
            let StrtDateString = dateFormatter.string(from: strtDate!)
            //print(DateString)
        
            lblStartdate.text = StrtDateString
            
            lblEnddate.text = EndString
            
            
            
        }
        
       
        
        
    }
    
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func btnRevokeClicked(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "Approve" {
            
            approveMandate()
            
        }else{
            revokeMandate()

        }
        
        
    }
    
    
    @IBAction func btnPauseClicked(_ sender: UIButton) {
        
        
        if sender.titleLabel?.text == "Decline" {
            
            declineMandate()
            
        }else{

           // pauseMandate()
            
           // MandatePayDetailsVC
            
            
            let vc = UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "MandatePauseVC") as! MandatePauseVC

            vc.mandatePauseTransactionData = mandateTransactionObject
            vc.accountDetails = accountDetails
            vc.mandateObject  = mandateObject
            vc.umnStr = umnStr
            vc.umnIDGener = umnIDGener

            
            self.navigationController?.pushViewController(vc, animated: true)
            
            

        }
        
        
    }
    
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyz"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    
    func declineMandate() {
        
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
        
        
        
        let x = Double(mandateObject?.amount ?? "0")
        let amtDecimal = String(format: "%.2f", Double(round(100 * x!) / 100))
        
        umnIDGener = mandateObject?.txnid ?? ""
        
      //  print(mandateObject?.txnid ?? "")
        
        //umnStr = umnIDGener.components(separatedBy: CharacterSet.decimalDigits).joined()
        
        umnStr = randomString(length: 20)
        
       // print(umnStr)
       // print(umnStr.count)

        
        let  baneObject = baneVpaModel(vpa: mandateObject?.payeeVpa ?? "", name:mandateObject?.beneName ?? "")
        
        let mandateInput = MandateInput(amount: amtDecimal, remark: "UPI", txnid: mandateObject?.txnid ?? "", umn: umnStr + accessMax, action: "DECLINE")
        
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
            

            
          //  OliveUpiManager.createMandate(account: strAccountDetails,  beneVpa: strBaneObj, mandateInput:strMandateInput, viewController: self) { data, error in
            
            //OliveUpiManager.declineMandate(account: strAccountDetails, mandateInput: strMandateInput, viewController: self)
            
            OliveUpiManager.authorizeMandate(account: strAccountDetails, beneVpa: strBaneObj, mandateInput: strMandateInput, viewController: self){ data, error in
                
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
                     //   print(dt)
                        
                        DispatchQueue.main.async {
                            
                            SwiftLoader.hide()
                            self.showToast(message: dt as! String)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                self.navigationController?.popViewController(animated: true)
                            })
                        }
                    }
                }
            }
        }
    }
    
    
    func pauseMandate() {
        
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
        
        
        
        let x = Double(mandateObject?.amount ?? "0")
        let amtDecimal = String(format: "%.2f", Double(round(100 * x!) / 100))
        
        umnIDGener = mandateObject?.txnid ?? ""
        
        print(mandateObject?.txnid ?? "")
        
        //umnStr = umnIDGener.components(separatedBy: CharacterSet.decimalDigits).joined()
        
        umnStr = randomString(length: 32)
        
        //print(umnStr)
       // print(umnStr.count)

        
        let  baneObject = baneVpaModel(vpa: mandateObject?.payeeVpa ?? "", name:mandateObject?.beneName ?? "")
        
        let mandateInput = MandateInput(amount: amtDecimal, remark: "UPI", txnid: mandateObject?.txnid ?? "", umn: umnStr + accessMax, action: "APPROVE")
        
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

           // OliveUpiManager.declineMandate(account: strAccountDetails, mandateInput: strMandateInput, viewController: self) { data, error in
                
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
                            })
                        }
                    }
                }
            }
        }
    }
    
    
    
    func approveMandate() {
        
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
        
        
        
        let x = Double(mandateObject?.amount ?? "0")
        let amtDecimal = String(format: "%.2f", Double(round(100 * x!) / 100))
        
        umnIDGener = mandateObject?.txnid ?? ""
        
        //print(mandateObject?.txnid ?? "")
        
        //umnStr = umnIDGener.components(separatedBy: CharacterSet.decimalDigits).joined()
        
        umnStr = randomString(length: 32)
        
       // print(umnStr)
       // print(umnStr.count)

        
        let  baneObject = baneVpaModel(vpa: mandateObject?.payeeVpa ?? "", name:mandateObject?.beneName ?? "" )

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

        
        
        let mandateInput = MandateInput(amount: amtDecimal, remark: "UPI", txnid: mandateObject?.txnid ?? "", umn: umnStr + accessMax, action: "APPROVE")
        
      //  print("mandateInput :", mandateInput)

        
        var strMandateInput = ""

        
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
            
            
           // OliveUpiManager.updateMandate(account: strAccountDetails,  mandateInput:strMandateInput, newState: "REVOKE", viewController: self) { data, error in

            OliveUpiManager.authorizeMandate(account: strAccountDetails, beneVpa: strBaneObj, mandateInput: strMandateInput, viewController: self){ data, error in

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
                      //  print(dt)
                        
                        DispatchQueue.main.async {
                            
                            SwiftLoader.hide()
                            self.showToast(message: dt as! String)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                self.navigationController?.popViewController(animated: true)
                            })
                        }
                    }
                }
            }
        }
    }
    
    
    func revokeMandate() {
        
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
        
        
        
       // let x = Double(mandateObject?.amount ?? "0")
        
       // let amtDecimal = String(format: "%.2f", Double(round(100 * x!) / 100))
        
        umnIDGener = mandateObject?.txnid ?? ""
        
    //    print(mandateObject?.txnid ?? "")
        
        //umnStr = umnIDGener.components(separatedBy: CharacterSet.decimalDigits).joined()
        
        umnStr = randomString(length: 32)
        
      //  print(umnStr)
       // print(umnStr.count)

        
        
        //let mandateInput = MandateInput(amount: amtDecimal, remark: "UPI MANDATE", txnid: mandateObject?.txnid ?? "", umn: umnStr + "@axis", action: "APPROVE")
        
        //UpdatableMandateInput
        
        let pMobile = mandateTransactionObject?.payerMobile ?? ""
        let pShareto = mandateTransactionObject?.shareToPayee ?? ""
        
        let validityStart = mandateTransactionObject?.validity_start ?? ""
        
        let validityEnd = mandateTransactionObject?.validity_end ?? ""
        
        let mandaName = mandateTransactionObject?.mandateName ?? ""
      //  let amounRule = mandateTransactionObject?.amountRule ?? ""
        let amountStr = mandateTransactionObject?.amount ?? ""
        
        print("mandateTransactionObject====>",mandateTransactionObject)

        let mandateInput = UpdatableMandateInput(umn:mandateTransactionObject?.umn ?? "", remarks: "UPI MANDATE", mcc: "0000", payerMobile:pMobile , purpose: "00", shareToPayee:pShareto, validityStart: validityStart, validityEnd:validityEnd, mandateName: mandateTransactionObject?.mandateName ?? ""  ,revocable: "Y", amountRule:mandateTransactionObject?.amountRule ?? ""  , amount: amountStr , recurrence: mandateTransactionObject?.recurrencePattern ?? "" , ruleValue:"14" , ruleType: mandateTransactionObject?.recurrenceRuleType ?? "" , initiatedBy: "PAYER_INITIATED")
        
        print(mandateInput)
        
        var strMandateInput = ""
        
        
        
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
            
            print("Accounts ", strAccountDetails)
            print("strMandateInput ", strMandateInput)
            
            OliveUpiManager.updateMandate(account: strAccountDetails,  mandateInput:strMandateInput, newState: "REVOKE", viewController: self) { data, error in

                print("data ===>", data)
                print("error", error)
           // OliveUpiManager.declineMandate(account: strAccountDetails, mandateInput: strMandateInput, viewController: self) { data, error in
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
                            })
                        }
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




extension MandatePayDetailsVC: MFMessageComposeViewControllerDelegate {
    
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
           // print("The data is:\(String(describing: data))")
            //self.btnApproval(UIButton())
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
                   // self.btnApproval(UIButton())
                }
            })
            break
        default:
            break
        }
    }
}

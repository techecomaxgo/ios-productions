//
//  BhimTrasactionDetailsVC.swift
//  MaxPay
//
//  Created by india on 14/11/23.
//

import UIKit
import DropDown
import OlivePayLibrary
import SwiftLoader
import MessageUI


class BhimTrasactionDetailsVC: BaseVC {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblVpa: UILabel!
    @IBOutlet weak var lblTxnId: UILabel!
    @IBOutlet weak var lblTxnDate: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblfiveMinutes: UILabel!
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblRemark: UILabel!
    @IBOutlet weak var imgSendReceiveIc: UIImageView!
    @IBOutlet weak var vwCheckStatus: UIView!
    
    @IBOutlet weak var vwSeprator: UIView!
    
    @IBOutlet weak var imgForSteps: UIImageView!
    
    @IBOutlet weak var vwBackground: UIView!
    
    
    var accountDetails: AccountDetailsOnIIN?
    let dropDown = DropDown()
    var tranHistoryObj: TranHistoryModel?
    private var checksumViewModel = SIMSelectionViewModel()
    
    var generateRRNStr = ""
    var orderIdsStr = ""
    
   // var orderIdsStr = ""
    
    var strCheckStInputs = ""
    
    
    @IBOutlet weak var btnStatusCheck: UIButton!
    
    
    var dataResDict = NSDictionary()
    var dataResDicts = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vwCheckStatus.layer.applyCornerRadiusShadow()
        vwBackground.layer.applyCornerRadiusShadow()
        
        
        
        
        setTranHistoryData(data: tranHistoryObj, accountDetails: accountDetails)
        
        
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnShowstatusAction(_ sender: Any) {
        
        //raiseQuery()
        
        generateRRNStr =  Common.shared.generateRRN()
        
        orderIdsStr =  Common.shared.generateMyOrderId()
        print(orderIdsStr)
        
        print(generateRRNStr)
        
        checkStatus()
        

        
    }
    
    

    
    func setTranHistoryData(data: TranHistoryModel?, accountDetails: AccountDetailsOnIIN?)
    {
        lblTxnId.text = data?.tranid
        lblTxnDate.text = data?.refid
        lblTime.text = data?.dateTime
        lblRemark.text = data?.remarks
    
        lblStatus.text = Status.getStatus(from: data?.status ?? "")
        
        lblStatus.textColor = data?.status == "C" ? UIColor.init(named: "primary-green") : data?.status == "P" ? UIColor.orange : UIColor.init(named: "status-red-color")
        
        if data?.mcc == tranHistoryObj?.mcc {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let transactionDate = dateFormatter.date(from: data?.dateTime ?? "") {
                // Add 5 minutes to the transaction date
                let fiveMinutesLater = Calendar.current.date(byAdding: .minute, value: 5, to: transactionDate)
                let now = Date()
                
                // Show the "Check Status" button if 5 minutes have passed
                vwCheckStatus.isHidden = now < fiveMinutesLater!
            }
        }
        
        imgSendReceiveIc.image = data?.type == "PAY" ? UIImage(named: "ic_arrow_up")?.withRenderingMode(.alwaysTemplate) : UIImage(named: "ic_arrow_down")?.withRenderingMode(.alwaysTemplate)
        
        imgSendReceiveIc.tintColor = data?.status == "C" ? UIColor.init(named: "primary-green") : data?.status == "P" ? UIColor.orange : UIColor.init(named: "status-red-color")
        
        lblAmount.text = "₹ " + (data?.amount ?? "0")
        
        if data?.type == "PAY" {
            if accountDetails?.vpa == data?.creditVpa {
                lblVpa.text = data?.debitVpa
                lblName.text = data?.remitterName == nil ? "No Name" : data?.remitterName
            } else {
                lblVpa.text = data?.creditVpa
                lblName.text = data?.beneficiaryName == nil ? "No Name" : data?.beneficiaryName
            }
        } else if data?.type == "COLLECT" {
            if accountDetails?.vpa == data?.creditVpa {
                lblVpa.text = data?.debitVpa
                lblName.text = data?.remitterName == nil ? "No Name" : data?.remitterName
            } else {
                lblVpa.text = data?.creditVpa
                lblName.text = data?.beneficiaryName == nil ? "No Name" : data?.beneficiaryName
            }
        }
        
        if data?.mcc == "0000" {
            lblfiveMinutes.isHidden=true
        }else{
            lblfiveMinutes.isHidden=false
        }
    }

    
    
    
    
//    @IBAction func btnShowstatusAction(_ sender: Any) {
//        generateRRNStr = Common.shared.generateRRN()
//        orderIdsStr = Common.shared.generateMyOrderId()
//        
//        print(generateRRNStr)
//        checkStatus()
//    }

    
    
    
    func timeDifference(from dateString: String) -> DateComponents? {
        // Date format based on the provided string "27/08/2024 04:29:57 PM"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss a"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        // Convert the string to a Date object
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        // Get the current date and time
        let currentDate = Date()
        
        // Calculate the difference between the current date and the given date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: date)
        
        return components
    }
    
    
    
//    if let difference = timeDifference((tranHistoryObj?.dateTime)!) {
//        print("Days: \(difference.day ?? 0), Hours: \(difference.hour ?? 0), Minutes: \(difference.minute ?? 0), Seconds: \(difference.second ?? 0)")
//    } else {
//        print("Invalid date string")
//    }
//        }
    
    
    
    
    
    
    
//    @IBAction func btnShowstatusAction(_ sender: Any) {
//        generateRRNStr =  Common.shared.generateRRN()
//        orderIdsStr =  Common.shared.generateMyOrderId()
//        
//        print(generateRRNStr)
//        checkStatus()
//    }

    

    
    
    
    func checkStatus() {
        
        // CheckStatusInput
        let txnIdStr = tranHistoryObj?.tranid
        
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
            encoder.outputFormatting = .prettyPrinted  // Format the JSON for better readability
            let jsonData = try encoder.encode(checkStatus)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                strCheckStInput = jsonString
                print("strCheckStInput =====>>", strCheckStInput)
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        
        DispatchQueue.global(qos: .background).async {
            OliveUpiManager.checkStatus(check: strCheckStInput) { data, error in
                
                print("error==========",error)
                print("data==============",data)
                
                if let err = error {
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        if err.code == 102 {
                            //self.showErrorAlert(err.localizedDescription)
                            //self.configuration()
                            
                            //changes now
                            
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
                            let vc = storyBoard.instantiateViewController(withIdentifier: "BhimTransactionNextDetailsVC") as! BhimTransactionNextDetailsVC
                            
                            vc.tranHistoryObjs = self.tranHistoryObj
                            
                        //    vc.tranHistoryObjdata  = TranHistoryModel
                            
                    //        vc.tranHistoryObjdata = tranHistoryObjs
                            
                         //   vc.tranHistoryObj = self.tranHistoryObjs
                            
                            
                            
                         //   vc.tranHistoryObjdata = tranHistoryObjs
                            
                      //      vc.dataall = data as! String
                            
                            vc.tranIdData = (self.tranHistoryObj?.tranid)!
                            vc.refidData = (self.tranHistoryObj?.refid)!
                            vc.dateTimeData = (self.tranHistoryObj?.dateTime)!
                            vc.remarksData = (self.tranHistoryObj?.remarks)!
                            
                        //    vc.responseDictFromCheck = dt as NSDictionary
                            self.navigationController?.pushViewController(vc, animated: true)
                            
                        } 
              
                        else if err.code == 401 || err.code == 107 {
                            self.configuration()
                            
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
                            let vc = storyBoard.instantiateViewController(withIdentifier: "BhimTransactionNextDetailsVC") as! BhimTransactionNextDetailsVC
                            
                            vc.tranHistoryObjs = self.tranHistoryObj
                            
                        //    vc.tranHistoryObjdata  = TranHistoryModel
                            
                    //        vc.tranHistoryObjdata = tranHistoryObjs
                            
                         //   vc.tranHistoryObj = self.tranHistoryObjs
                            
                            
                            
                         //   vc.tranHistoryObjdata = tranHistoryObjs
                            
                      //      vc.dataall = data as! String
                            
                            vc.tranIdData = (self.tranHistoryObj?.tranid)!
                            vc.refidData = (self.tranHistoryObj?.refid)!
                            vc.dateTimeData = (self.tranHistoryObj?.dateTime)!
                            vc.remarksData = (self.tranHistoryObj?.remarks)!
                            
                        //    vc.responseDictFromCheck = dt as NSDictionary
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                    return
                }
                
                // Identify the type of data
                print("Type of data: \(type(of: data))")
                
                if let dt = data as? [String: Any] {
                    // If data is already a dictionary
                    print("Response data: \(dt)")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        SwiftLoader.hide()
                        
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
                        let vc = storyBoard.instantiateViewController(withIdentifier: "BhimTransactionNextDetailsVC") as! BhimTransactionNextDetailsVC
                        
                        vc.responseDictFromCheck = dt as NSDictionary
                        vc.tranHistoryObjs = self.tranHistoryObj
                        vc.orderIdsStr = self.orderIdsStr
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                } else if let dtString = data as? String {
                    // If data is a string, try to convert it to a dictionary
                    if let jsonData = dtString.data(using: .utf8) {
                        do {
                            if let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? NSDictionary {
                                print("Response data: \(jsonDict)")
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    SwiftLoader.hide()
                                    
                                    let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
                                    let vc = storyBoard.instantiateViewController(withIdentifier: "BhimTransactionNextDetailsVC") as! BhimTransactionNextDetailsVC
                                    
                                    vc.responseDictFromCheck = jsonDict
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                            }
                        } catch {
                            print("Error converting string to dictionary: \(error)")
                            
                           // changes on its 29 aug
                            
                            
                            
                            
                        }
                    }
                } else {
                    print("Error: Unhandled data type")
                }
            }
        }
        
        
        
        
        
        
        
        
        
        
//
//        DispatchQueue.global(qos: .background).async {
//            OliveUpiManager.checkStatus(check: strCheckStInput) { data, error in
//                
//                print("error==========", error)
//                print("data==============", data)
//                
//                if let err = error {
//                    DispatchQueue.main.async {
//                        SwiftLoader.hide()
//                        
//                        if err.code == 102 {
//                            let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
//                            let vc = storyBoard.instantiateViewController(withIdentifier: "BhimTransactionNextDetailsVC") as! BhimTransactionNextDetailsVC
//                            
//                            
//                            
//                            
//                            print("tranHistoryObjs =========",self.tranHistoryObj)
//                            
//                            vc.tranHistoryObjs = self.tranHistoryObj
//                            
//                            // Assuming `data` should be passed as a string if available
//                            if let dataString = data as? String {
//                                print("dataString =========", dataString)
//                                vc.dataall = dataString
//                            }
//                            
//                            // Set other properties of BhimTransactionNextDetailsVC
//                            vc.tranIdData = self.tranHistoryObj?.tranid ?? ""
//                            vc.refidData = self.tranHistoryObj?.refid ?? ""
//                            vc.dateTimeData = self.tranHistoryObj?.dateTime ?? ""
//                            vc.remarksData = self.tranHistoryObj?.remarks ?? ""
//                            
//                            // Navigate to the next view controller
//                            self.navigationController?.pushViewController(vc, animated: true)
//                        } else if err.code == 401 || err.code == 107 {
//                            self.configuration()
//                        }
//                    }
//                    return
//                }
//                
//                // Identify the type of data
//                print("Type of data: \(type(of: data))")
//                
//                if let dt = data as? [String: Any] {
//                    // If data is already a dictionary
//                    print("Response data: \(dt)")
//                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                        SwiftLoader.hide()
//                        
//                        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
//                        let vc = storyBoard.instantiateViewController(withIdentifier: "BhimTransactionNextDetailsVC") as! BhimTransactionNextDetailsVC
//                        
//                        vc.responseDictFromCheck = dt as NSDictionary
//                        self.navigationController?.pushViewController(vc, animated: true)
//                    }
//                    
//                } 
//                
//                
//                else if let dtString = data as? String {
//                    // If data is a string, try to convert it to a dictionary
//                    if let jsonData = dtString.data(using: .utf8) {
//                        do {
//                            if let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? NSDictionary {
//                                print("Response data: \(jsonDict)")
//                                
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                                    SwiftLoader.hide()
//                                    
//                                    let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
//                                    let vc = storyBoard.instantiateViewController(withIdentifier: "BhimTransactionNextDetailsVC") as! BhimTransactionNextDetailsVC
//                                    
//                                    vc.responseDictFromCheck = jsonDict
//                                    self.navigationController?.pushViewController(vc, animated: true)
//                                }
//                            }
//                        } catch {
//                            print("Error converting string to dictionary: \(error)")
//                        }
//                    }
//                } else {
//                    print("Error: Unhandled data type")
//                }
//            }
//        }


    }









    
    
    func convertToDictAnyData(_ object: Any) -> Data? {
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
           
           dataResDict = dictionary as NSDictionary
           
           print(dataResDict)
           
         //  mcccodeStr = dictionary["mcccode"] as? String ?? ""
           //print(dictionary["mcccode"] as? String)
           
         //  beneNameStr = dictionary["data"] as? String ?? ""
           
//           print(mcccodeStr)
           
           
           
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

extension BhimTrasactionDetailsVC: MFMessageComposeViewControllerDelegate {
    
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
                print("Data loaded...",self?.checksumViewModel.checksumModel?.data?.result)
                
                if self?.checksumViewModel.checksumModel?.data?.result?.lowercased() == "success" {
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
}


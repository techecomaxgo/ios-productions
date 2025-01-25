//
//  RaiseQueryPopUpView2.swift
//  MaxPay
//
//  Created by Admin on 05/09/24.
//

import UIKit
import OlivePayLibrary
import SwiftLoader

class RaiseQueryPopUpView2: UIViewController {
    
    @IBOutlet var bgView_ctrl: UIView!
    @IBOutlet weak var popView_Ctrl: UIView!
    
    var responseDictFromCheck: NSDictionary?
    var selectedTag: Int?
    private var checksumViewModel = SIMSelectionViewModel()
    var tranHistoryObjss: TranHistoryModel?
    


    @IBOutlet private var multiRadioButton: [UIButton]!{
        didSet{
            multiRadioButton.forEach { (button) in
                button.setImage(UIImage(named:"circle-boarding-notselected"), for: .normal)
                button.setImage(UIImage(named:"circle-boarding-selected"), for: .selected)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("tranHistoryObjss ====>",tranHistoryObjss)

        self.bgView_ctrl.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        popView_Ctrl.layer.cornerRadius = 25
        popView_Ctrl.layer.borderWidth = 1.0
        popView_Ctrl.layer.borderColor = UIColor.white.cgColor
        popView_Ctrl.clipsToBounds = true

        // Assign tags programmatically
        for (index, button) in multiRadioButton.enumerated() {
            button.tag = index + 1
        }
        
      //  if
        
        
    }
    
    @IBAction private func raiseQueryRadioAction(_ sender: UIButton){
        uncheck()
        sender.isSelected = true
        selectedTag = sender.tag
        print("Selected Button Title: \(sender.titleLabel?.text ?? "No title")")
        print("Selected Button Tag: \(sender.tag)")
        
    }
    
    
    
    @IBAction func btnCross(_ sender: Any) {
        popView_Ctrl.isHidden = true
        bgView_ctrl.isHidden = true
    }
    
    
    func raiseQuery(reqAdjFlag: String, reqAdjCode: String) {
        print("Raising query with reqAdjFlag: \(reqAdjFlag), reqAdjCode: \(reqAdjCode)")
        
        popView_Ctrl.isHidden = true
        bgView_ctrl.isHidden = true
        
        let raisedDetails = ReqComplientVo(orgTxnId: responseDictFromCheck?["tranid"] as? String ?? tranHistoryObjss?.tranid , reqAdjFlag: reqAdjFlag, reqAdjCode: reqAdjCode , initiationMode: "U1", subType: "PAYER", type: "COMPLAINT")
        
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
                    } else if err.code == 401 || err.code == 107 {
                        self.configuration()
                        return
                    } else {
                        self.showErrorAlert(err.localizedDescription)
                    }
                }
                
            } else if let dt = data as? [String: Any], let crnNumber = dt["crnNumber"] as? String {
                
                print("dt=========================>> ",dt)
                
                
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                    self.showToast(message: "Your complaint is raised successfully with CRN no: \(crnNumber)", font: .systemFont(ofSize: 12))
                    self.popView_Ctrl.isHidden = true
                    
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
    
    
    
    
    
    
    func uncheck(){
        multiRadioButton.forEach { (button) in
            button.isSelected = false
        }
    }
    
    
    @IBAction func btnRaiseQueryClicked(_ sender: UIButton) {
  
        guard let tag = selectedTag else {
            print("No button selected")
            return
        }
        
        uncheck()
        sender.isSelected = true
        
        print("Selected Button Tag: \(tag)")
        
        switch tag {
        case 1:
            raiseQuery(reqAdjFlag: "PBRB", reqAdjCode: "U010")
        case 2:
            raiseQuery(reqAdjFlag: "PBRB", reqAdjCode: "U005")
            
        default:
            print("No matching case for tag \(tag)")
        }
        
        
    }
    
    
    
    
    
    func showAnimate()
        
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations:
            {
                self.view.alpha = 1.0
                self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
        
    {
        UIView.animate(withDuration: 0.0, animations:
            {
                self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
    
    
}




extension RaiseQueryPopUpView2: MFMessageComposeViewControllerDelegate {
    
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
    
    func showErrorAlert(_ strMsg:String){
        let alert = UIAlertController(title: "MaxUPI", message: strMsg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func showToast(message : String, font: UIFont = .systemFont(ofSize: 15)) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 125, y: self.view.frame.size.height-100, width: 250, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        toastLabel.layer.borderWidth = 1
        toastLabel.layer.borderColor = UIColor(hexString: "9FC438").cgColor
        toastLabel.textColor = UIColor.white
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
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
//            if self.apiCall == "PendingMandates" {
//                self.getPendingMandates()
//            } else {
//                self.getMandateTransactions()
//            }
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
                }
                
//                else {
//                    if self.apiCall == "PendingMandates" {
//                        self.getPendingMandates()
//                    } else {
//                        self.getMandateTransactions()
//                    }
//                    DispatchQueue.main.async {
//                        self.showToast(message: "SMS Delivered", font: .systemFont(ofSize: 12))
//                    }
//                }
            })
            break
        default:
            break
        }
    }
}

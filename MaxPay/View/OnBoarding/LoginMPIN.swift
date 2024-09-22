//
//  LoginMPIN.swift
//  MaxPay
//
//  Created by india on 08/11/23.
//

import UIKit
import SwiftLoader
import OlivePayLibrary
import MessageUI
import ObjectMapper

class LoginMPIN: UIViewController, UITextFieldDelegate, MFMessageComposeViewControllerDelegate {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var txtPINOne: UITextField!
    @IBOutlet weak var txtPINTwo: UITextField!
    @IBOutlet weak var txtPINThree: UITextField!
    @IBOutlet weak var txtPNFour: UITextField!
    
    private var loginViewModel = LoginViewModel()
    open var updatedAccountList: [CustomerBankAccounts]?
    private var registractionVWMidel = RegistractionViewModel()
    private var otpVerifyVWModel = OTPVerifyViewModel()
    private var notificationViewModel = NotificationViewModel()

    var window: UIWindow?

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupTextFields()
        
        
        let cntrl = MFMessageComposeViewController()
        cntrl.messageComposeDelegate = self
      
        btnSignIn.layer.applyCornerRadiusShadow()
        
//        txtPINOne.delegate = self
//        txtPINTwo.delegate = self
//        txtPINThree.delegate = self
//        txtPNFour.delegate = self
//        
//        txtPINOne.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
//        txtPINTwo.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
//        txtPINThree.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
//        txtPNFour.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        if Common.shared.isLoggedIn ?? false {
            btnBack.isHidden = true
        }else{
            btnBack.isHidden = false
        }
    }
    
    func setupTextFields() {
        txtPINOne.delegate = self
        txtPINTwo.delegate = self
        txtPINThree.delegate = self
        txtPNFour.delegate = self
        
        txtPINOne.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        txtPINTwo.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        txtPINThree.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        txtPNFour.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        txtPINOne.becomeFirstResponder()
    }
    
    @IBAction func btnFOrgotMpin(_ sender: Any) {
        configurationOtpRegenarate()
    }
    
    
    @IBAction func btnDoneAction(_ sender: Any) {
        
        
        
        if txtPINOne.text != "" && txtPINTwo.text != "" && txtPINThree.text != "" && txtPNFour.text != "" {
            configuration()
        }else{
            showErrorAlert("Please enter your MPIN.")
        }
        
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
            let text = textField.text
            
            if text?.count == 1 {
                switch textField {
                case txtPINOne:
                    txtPINTwo.becomeFirstResponder()
                case txtPINTwo:
                    txtPINThree.becomeFirstResponder()
                case txtPINThree:
                    txtPNFour.becomeFirstResponder()
                case txtPNFour:
                    txtPNFour.resignFirstResponder()
                    btnDoneAction(UIButton())
                default:
                    break
                }
            } else if text?.count == 0 {
                switch textField {
                case txtPINTwo:
                    txtPINOne.becomeFirstResponder()
                case txtPINThree:
                    txtPINTwo.becomeFirstResponder()
                case txtPNFour:
                    txtPINThree.becomeFirstResponder()
                default:
                    break
                }
            }
        }
        
    
    
    @objc func textFieldDidChange(textField: UITextField){

        let text = textField.text

        if (text?.utf16.count)! >= 1{
            switch textField{
            case txtPINOne:
                txtPINTwo.becomeFirstResponder()
                
            case txtPINTwo:
                txtPINThree.becomeFirstResponder()
                
            case txtPINThree:
                txtPNFour.becomeFirstResponder()
                
            case txtPNFour:
                txtPNFour.resignFirstResponder()
                btnDoneAction(UIButton())

            default:
                break
            }
        }else{
            switch textField{
            case txtPNFour:
                txtPINThree.resignFirstResponder()
                
            case txtPINThree:
                txtPINTwo.becomeFirstResponder()
                
            case txtPINTwo:
                txtPINOne.becomeFirstResponder()
                
            case txtPINOne:
                txtPINOne.becomeFirstResponder()
                
            default:
                break
            }
        }
    }
    func showErrorAlert(_ strMsg:String){
        let alert = UIAlertController(title: "MaxUPI", message: strMsg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
  
    func performMerchantHandshake(){
//        let merchantAuthToken="s2balfs1s4sur2vl207w97sgqvlguda2mffrux3fhjblfim1pxa8cy3bf0p9tkvvs6bhdc35kwc0blpsdhtyxxae4822oa1hqy4hek60z3m2y2j9jmjvij0elv"
        //    let sdkHandShake = SDKHandshake()
        //    sdkHandShake.emailId = "srikanth.g@olivecrypto.com"
        //    sdkHandShake.merchId = "Olive001"
        //    sdkHandShake.merchChanId = "OLIVEAPP"
        //    sdkHandShake.submerchantid = "674545454"
        //    sdkHandShake.mcccode = "1520"
        //    sdkHandShake.unqCustId = "919542244401"
        //    sdkHandShake.mobileNo = "919542244401"
        //    sdkHandShake.deviceid = ""
        //    sdkHandShake.appid = ""
        //    sdkHandShake.custname = "Gimka Srikanth"
        //        sdkHandShake.merchantauthtoken = merchantAuthToken
        //    sdkHandShake.unqTxnId = Utils.generateRandomDigits(13)
        //    let sdkHandShakeInput = sdkHandShake.toJSONString()
        
        let sdkHandShake = SDKHandshake(emailId: "", merchId: "MAXPE", merchChanId: "MAXPE", submerchantid: "OLIVE", mcccode: "7322", unqCustId: "91\(Common.shared.phoneNo ?? "")", mobileNo: "91\(Common.shared.phoneNo ?? "")", deviceid: Common.shared.getDeviceID(), appid: appId, custname: "MAX", merchantauthtoken: Common.shared.merchantauthtoken ?? "", unqTxnId:SDKHandshake.shared.generateRandomDigits(12))
        let jsonString = sdkHandShake.jsonString(sdkHandShake)
        OliveUpiManager.initiateSDK(sdkHandshake: jsonString,view: self , delegate: self) { (data, err) in
            self.fetchAccounts()
        }
    }
    func  fetchAccounts(){
        OliveUpiManager.fetchMyAccounts() { (data, err) in
            // DialogUtils.removeActivityView(view: self.view)
            if let e = err{
//                DialogUtils.showMessageWithOk(controller: self, message: e.localizedDescription, title: "Alert")
                if let dt = data as? String{
                    self.updatedAccountList?.removeAll()
                    // let accountList = Mapper<CustomerBankAccounts>().mapArray(JSONString: dt)
                    print(data!)
                    do{
                        let model = try JSONDecoder().decode([CustomerBankAccounts].self, from: data as! Data)
                        print(model)
                    }catch{}
                }
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
                }else{
                    if let dt = data as! String?{
                        print(dt)
                    }
                }
            })
            break
        default:
            break
        }
    }
   
}

extension LoginMPIN {
    
    //MARK: API Calling
     func configurationOtpRegenarate() {
         SwiftLoader.show(animated: true)
         regenarateOTPCall()
         observeEventRegenarate()
     }

    func regenarateOTPCall() {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            otpVerifyVWModel.otpRegenarateCall(Common.shared.phoneNo ?? "")
        }else{
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internetconnection.")
            
        }
    }
    //MARK: Observing the data
    func observeEventRegenarate() {
        otpVerifyVWModel.eventHandler = { [weak self] event in
            guard self != nil else { return }

            switch event {
            case .loading:
                
                print("loading....")
                
            case .stopLoading:
                
                print("Stop loading...")
                SwiftLoader.hide()
            case .dataLoaded:
                print("Data loaded...")
                DispatchQueue.main.async {
                    if self?.otpVerifyVWModel.otpVerifyModel?.status == "success" {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "OTPVerifyVC") as! OTPVerifyVC
                        vc.isFromForgotPin = true
                        vc.strPhoneNumber = Common.shared.phoneNo ?? ""
                        self?.navigationController?.pushViewController(vc,animated: true)
                    }else{
                        self?.showErrorAlert(self?.otpVerifyVWModel.otpVerifyModel?.message ?? "")
                        SwiftLoader.hide()
                    }
                }
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
            }
        }
    }
}

extension LoginMPIN {
    
   //MARK: API Calling
    
    func configuration() {
        
        SwiftLoader.show(animated: true)
        initViewModel()
        observeEvent()
        
    }
    //MARK Network checking
    func initViewModel() {
        
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            
            let strPin = "\(txtPINOne.text!)\(txtPINTwo.text!)\(txtPINThree.text!)\(txtPNFour.text!)"
            loginViewModel.loginMpinCall(Common.shared.phoneNo ?? "",strPin)
            
        }else{
            
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internet connection.")
            
        }
    }
    //MARK: Observing the data
    func observeEvent() {
        loginViewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }

            switch event {
            case .loading:
                
                print("loading....")
                
            case .stopLoading:
                
                print("Stop loading...")
                SwiftLoader.hide()
            case .dataLoaded:
                print("Data loaded...")
                SwiftLoader.hide()
                
               // print(self?.loginViewModel.loginModel?.dataLogin)
                
                Common.shared.isLoggedIn = true
                Common.shared.token = self?.loginViewModel.loginModel?.token ?? ""
                Common.shared.userFirstName = self?.loginViewModel.loginModel?.dataLogin?.f_name ?? ""
                Common.shared.userLastName = self?.loginViewModel.loginModel?.dataLogin?.l_name ?? ""

                DispatchQueue.main.async {
                    
                    if self?.loginViewModel.loginModel?.status == "success" {
                                   
//                        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
//                        let vc = storyboard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
//                        self?.navigationController?.pushViewController(vc,animated: true)

                        self?.configurationNotification(token: Common.shared.fcmToken ?? "")

                    } else {
                        
                        self?.showErrorAlert(self?.loginViewModel.loginModel?.message ?? "")
                        self?.txtPINOne.text = ""
                        self?.txtPINTwo.text = ""
                        self?.txtPINThree.text = ""
                        self?.txtPNFour.text = ""
                        self?.txtPINOne.becomeFirstResponder()
                        
                    }
                }
                
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
            }
        }
    }

}

extension LoginMPIN {
    
    func configurationNotification(token: String) {
        initNotificationViewModel(token: token)
        observeNotificationEvent()
    }
    //MARK Network checking
    
    func initNotificationViewModel(token: String) {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            notificationViewModel.addNotificationTokenCall(token: token, vpa_address: "", acc_num: "", ifsc_code: "")
        }else{
            self.showErrorAlert("Please check your internet connection.")
        }
    }
    
    //MARK: Observing the data
    func observeNotificationEvent() {
        
        notificationViewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }
            
            switch event {
            case .loading:
                
                print("loading....")
                
            case .stopLoading:
                
                print("Stop loading...")
                
            case .dataLoaded:
              
                print("Data loaded...")
//                
//                let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
//                self?.navigationController?.pushViewController(vc,animated: true)
//                
                
                self?.window = UIWindow(frame: UIScreen.main.bounds)
                self?.window?.rootViewController = CustomTabBarController()
                self?.window?.makeKeyAndVisible()
                


            case .error(let error):
                print(error!)

            }
        }
    }
}

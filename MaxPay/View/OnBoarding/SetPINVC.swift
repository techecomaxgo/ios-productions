//
//  SetPINVC.swift
//  MaxPay
//
//  Created by india on 06/11/23.
//

import UIKit
import SwiftLoader

class SetPINVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtPINOne: UITextField!
    @IBOutlet weak var txtPINTwo: UITextField!
    @IBOutlet weak var txtPINThree: UITextField!
    @IBOutlet weak var txtPNFour: UITextField!
    @IBOutlet weak var txtConfirmPINOne: UITextField!
    @IBOutlet weak var txtConfirmPINTwo: UITextField!
    @IBOutlet weak var txtConfirmTree: UITextField!
    @IBOutlet weak var txtConfirmFourPINFour: UITextField!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var imgPinCorrect: UIImageView!
    
    var strPhoneNumber = ""
    private var setPinGenetationViewModel = SetPinGenetationViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnDone.layer.applyCornerRadiusShadow()
        txtPINOne.delegate = self
        txtPINTwo.delegate = self
        txtPINThree.delegate = self
        txtPNFour.delegate = self
        txtConfirmPINOne.delegate = self
        txtConfirmPINTwo.delegate = self
        txtConfirmTree.delegate = self
        txtConfirmFourPINFour.delegate = self
        
        txtPINOne.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtPINTwo.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtPINThree.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtPNFour.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtConfirmPINOne.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtConfirmPINTwo.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtConfirmTree.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtConfirmFourPINFour.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
    }
    @IBAction func btnDoneAction(_ sender: Any) {
        if txtPINOne.text != "" && txtPINTwo.text != "" && txtPINThree.text != "" && txtPNFour.text != "" && txtConfirmPINOne.text != "" && txtConfirmPINTwo.text != "" && txtConfirmTree.text != "" && txtConfirmFourPINFour.text != "" {
            let strPin = "\(txtPINOne.text!) \(txtPINTwo.text!)  \(txtPINThree.text!) \(txtPNFour.text!)"
            let strConfirmPin = "\(txtConfirmPINOne.text!) \(txtConfirmPINTwo.text!)  \(txtConfirmTree.text!) \(txtConfirmFourPINFour.text!)"
            if strPin == strConfirmPin {
                configuration()
            }else{
                showErrorAlert("MPIN does not match.")
                
                txtPINOne.text = ""
                txtPINTwo.text = ""
                txtPINThree.text = ""
                txtPNFour.text = ""
                txtConfirmPINOne.text = ""
                txtConfirmPINTwo.text = ""
                txtConfirmTree.text = ""
                txtConfirmFourPINFour.text = ""
            }
            
        }else{
            showErrorAlert("Please enter your OTP code.")
        }
        
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
                txtConfirmPINOne.becomeFirstResponder()
                
            case txtConfirmPINOne:
                txtConfirmPINTwo.becomeFirstResponder()
                
            case txtConfirmPINTwo:
                txtConfirmTree.becomeFirstResponder()
                
            case txtConfirmTree:
                txtConfirmFourPINFour.becomeFirstResponder()
                
            case txtConfirmFourPINFour:
                txtConfirmFourPINFour.becomeFirstResponder()
            
            default:
                break
            }
        }else{
            switch textField{
            case txtConfirmFourPINFour:
                txtConfirmTree.becomeFirstResponder()
                
            case txtConfirmTree:
                txtConfirmPINTwo.becomeFirstResponder()
                
            case txtConfirmPINTwo:
                txtConfirmPINOne.becomeFirstResponder()
                
            case txtConfirmPINTwo:
                txtConfirmPINOne.becomeFirstResponder()
                
            case txtConfirmPINOne:
                txtConfirmPINOne.becomeFirstResponder()
                
            case txtPNFour:
                txtPINThree.becomeFirstResponder()
                
            case txtPINThree:
                txtPINTwo.becomeFirstResponder()
                
            case txtPINThree:
                txtConfirmPINTwo.becomeFirstResponder()
                
            case txtPINTwo:
                txtPINOne.becomeFirstResponder()
                
            case txtPINOne:
                txtPINOne.becomeFirstResponder()
            default:
                break
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        imgPinCorrect.isHidden = (txtPINOne.text == txtConfirmPINOne.text && txtPINTwo.text == txtConfirmPINTwo.text && txtPINThree.text == txtConfirmTree.text && txtPNFour.text == txtConfirmFourPINFour.text) ? false : true
    }
    
    func showErrorAlert(_ strMsg:String){
        let alert = UIAlertController(title: "MaxUPI", message: strMsg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
extension SetPINVC {
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
            setPinGenetationViewModel.setPinGenerationCall(strPhoneNumber,strPin)
        }else{
            SwiftLoader.hide()
            self.showErrorAlert("Please check your internetconnection.")
            
        }
    }
    //MARK: Observing the data
    func observeEvent() {
        setPinGenetationViewModel.eventHandler = { [weak self] event in
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
                    if self?.setPinGenetationViewModel.otpVerifyModel?.status == "success" {
                       let storyboard = UIStoryboard(name: "Main", bundle: nil)
                       let vc = storyboard.instantiateViewController(withIdentifier: "LoginMPIN") as! LoginMPIN
                       self?.navigationController?.pushViewController(vc,animated: true)
                    }else{
                        self?.showErrorAlert(self?.setPinGenetationViewModel.otpVerifyModel?.message ?? "")
                    }
                }
            case .error(let error):
                print(error!)
                SwiftLoader.hide()
            }
        }
    }

}

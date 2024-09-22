//
//  complaintFormVC.swift
//  MaxPay
//
//  Created by Ios Developer on 01/02/24.
//

import UIKit
import SwiftLoader

protocol CustomPickerDelegate: AnyObject {
    func didSelectOption(option: String, textFieldTag: Int, selectedRow: Int)
}

class ComplaintFormVC: BaseVC, CustomPickerDelegate {

    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var txtTypeOfComplaints: UITextField!
    @IBOutlet weak var txtParticipationType: UITextField!
    @IBOutlet weak var txtServiceReason: UITextField!
    @IBOutlet weak var textWriteComplaint: UITextView!
    let textViewPlaceHolder = "Write your complaint here"
    private var complaintViewModel = ComplaintViewModel()
    var txnId = ""
    var selectedPicker = 0
    
    let arrTypeOfComplaint = ["Transaction Level", "Service Based"]
    let arrParticipationType = ["Transaction", "Agent", "Biller/system", "Biller"]
    
    let TransactionRelatedDeposition = ["Transaction Successful, account not updated", "Amount deducted, biller account credited but transaction ID not received", "Amount deducted, biller account not credited & transaction ID not received", "Amount deducted multiple times", "Double payment updated", "Erroneously paid in wrong account", "Others, provide details in description"]
    
    let ServiceRelatedDepostions = ["Agent not willing to print receipt", "Agent misbehaved", "Agent outlet closed", "Agent denying registration of complaint", "Agent not accepting certain bills", "Agent overcharging", "Biller available. Unable to transact", "Multiple failure for same biller", "Denomination not available", "Incorrect bill details displayed", "Incomplete / No details reflecting"]
    
    var selectedType = [String]()
    
    let pickerView = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()

        if textWriteComplaint.text == textViewPlaceHolder {
            textWriteComplaint.textColor = UIColor.init(named: "grey-chip-color")
        }
        
        txtTypeOfComplaints.tag = 1
        txtParticipationType.tag = 2
        txtServiceReason.tag = 3
        
        setupPicker(for: txtTypeOfComplaints, options: arrTypeOfComplaint)
        setupPicker(for: txtParticipationType, options: arrParticipationType)
        setupPicker(for: txtServiceReason, options: TransactionRelatedDeposition)
        
        
    }
    

    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }


    @IBAction func btnSubmitAction(_ sender: Any) {
        
        if txtMobileNo.text == "" || txtTypeOfComplaints.text == "" || txtParticipationType.text == "" || txtServiceReason.text == "" || textWriteComplaint.text == "Write your complaint here" {
            
            showToast(message: "Please fill all details.")
            
        } else if txtMobileNo.text!.count < 10 {
            
            showToast(message: "Enter valid phone number")
            
        } else {

            // call api
            configurationForComplaintList()
            
        }
    }
}

extension ComplaintFormVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func setupPicker(for textField: UITextField, options: [String]) {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = textField.tag // Using tag to identify which text field
        pickerView.backgroundColor = UIColor(named: "pay-card-bg-color")
        
        textField.inputView = pickerView
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: false)
        textField.inputAccessoryView = toolbar
    }
    
    // MARK: - UIPickerViewDataSource methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView.tag == 1 ? arrTypeOfComplaint.count : pickerView.tag == 2 ? arrParticipationType.count : selectedType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView.tag == 1 ? arrTypeOfComplaint[row] : pickerView.tag == 2 ? arrParticipationType[row] : selectedType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedOption = pickerView.tag == 1 ? arrTypeOfComplaint[row] : pickerView.tag == 2 ? arrParticipationType[row] : selectedType[row]
        if let delegate = self as? CustomPickerDelegate {
            delegate.didSelectOption(option: selectedOption, textFieldTag: pickerView.tag, selectedRow: row)
        }
    }
    
    // MARK: - Done button action
    @objc func doneButtonTapped() {
        view.endEditing(true)
        
        print(pickerView.selectedRow(inComponent: 0))
        
//        if selectedPicker == 1 {
//            txtTypeOfComplaints.text = arrTypeOfComplaint[pickerView.selectedRow(inComponent: 0)]
//            if let delegate = self as? CustomPickerDelegate {
//                delegate.didSelectOption(option: txtTypeOfComplaints.text ?? "", textFieldTag: selectedPicker, selectedRow: pickerView.selectedRow(inComponent: 0))
//            }
//        } else if selectedPicker == 2 {
//            txtParticipationType.text = arrParticipationType[pickerView.selectedRow(inComponent: 0)]
//        } else if selectedPicker == 3 {
//            txtServiceReason.text = selectedType[pickerView.selectedRow(inComponent: 0)]
//        }
//        
//        selectedPicker = 0
    }
    
    func didSelectOption(option: String, textFieldTag: Int, selectedRow: Int) {
        if let textField = view.viewWithTag(textFieldTag) as? UITextField {
            textField.text = option
            
            if textFieldTag == 1 {
                selectedType = selectedRow == 0 ? TransactionRelatedDeposition : ServiceRelatedDepostions
            }
        }
    }
}

extension ComplaintFormVC: UITextFieldDelegate, UITextViewDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 3 && txtTypeOfComplaints.text == "" {
            showToast(message: "Select type of Complaints")
            view.endEditing(true)
            return
        }
        selectedPicker = textField.tag
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let finalText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if textField == txtMobileNo {
            return finalText.count <= 10
        }
        
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.init(named: "grey-chip-color") {
            textView.text = ""
            textView.textColor = UIColor.init(named: "reload-grey-color")
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = UIColor.init(named: "grey-chip-color")
        }
    }
    
}

extension ComplaintFormVC {
    
    func configurationForComplaintList() {
        DispatchQueue.main.async {
            SwiftLoader.show(animated: true)
        }
        initViewModel()
        observeEventForComplaintSearch()
    }
    
    //MARK Network checking
    func initViewModel() {
        let isConnected = ReachabilityClass.isConnectedToNetwork()
        
        if isConnected == true {
            complaintViewModel.complaintRegisterModel(description: textWriteComplaint.text, disposition: txtServiceReason.text ?? "", participation_type: txtParticipationType.text ?? "", complaintType: txtTypeOfComplaints.text ?? "", txn_id: txnId, mobileNo: txtMobileNo.text ?? "")
        }else{
            DispatchQueue.main.async {
                SwiftLoader.hide()
                self.showErrorAlert("Please check your internet connection.")
            }
        }
    }
    
    //MARK: Observing the data
    func observeEventForComplaintSearch() {
        
        complaintViewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }
            
            switch event {
            case .loading:
                
                print("loading....")
                
            case .stopLoading:
                
                print("Stop loading...")
                
            case .dataLoaded:
                print("Data loaded...")
                                
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                    
                    if let status = self?.complaintViewModel.complaintRegisterModel?.status {
                        
                        if status == "success" {
                            
                            let vc = UIStoryboard(name: "Complaint", bundle: nil).instantiateViewController(withIdentifier: "ComplaintSubmittedVC") as! ComplaintSubmittedVC
                            vc.complaintRegisterModel = self?.complaintViewModel.complaintRegisterModel
                            self?.navigationController?.pushViewController(vc, animated: true)
                            
                        } else {
                            
                            self?.showErrorAlert(self?.complaintViewModel.complaintRegisterModel?.message ?? "")
   
                        }
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
}
